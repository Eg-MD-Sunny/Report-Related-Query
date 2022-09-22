-- ######################### Monthly Key Matrics ##########################

DECLARE @Result TABLE (
	[Id] int IDENTITY (1,1) NOT NULL,
	[Month] Varchar(7),
	[NumOrders] int,
	[TotalOrderValue] decimal,
	[NumCorporateCustomersWithOrders] int,
	[NumCorporateOrders] int,
	[CorporateOrderValue] decimal,
	[AverageOrderValue] decimal,
	[TotalItemsSold] int,
	[UniqueItemsSold] int,
	[NumFirstTimeCustomers] int,
	[NumUsersWhoRepeatedOrders] int,
	[NumFirstTimeUsersWithRepeatOrders] int,
	[FirstTimeOrderTotals] decimal,
	[FirstTimeOrderAverage] decimal
);

INSERT INTO @Result
SELECT 
	CONVERT(NVARCHAR(7), dbo.tobdt(o.CreatedOnUtc), 120) [Month]
	,COUNT(distinct o.id) [NumOrders]
	,SUM(tr.SalePrice) [TotalOrderValue]
	,COUNT(distinct(case when c.IsCorporate = 1 then c.Id end)) [NumCorporateCustomersWithOrders]
	,COUNT(distinct(case when c.IsCorporate = 1 then o.Id end)) [NumCorporateOrders]
	,SUM(case when c.IsCorporate = 1 then tr.SalePrice end) [CorporateOrderValue]
	,SUM(tr.SalePrice)/COUNT(distinct o.id) [AverageOrderValue]
	,COUNT(tr.SalePrice) [TotalItemsSold]
	,COUNT(distinct tr.ProductVariantId) [UniqueItemsSold]
	,COUNT(distinct(case when o.FirstCompletedOrderForCustomer = 1 then c.Id end)) [NumFirstTimeCustomers]
	,NULL [NumUsersWhoRepeatedOrders]
	,NULL [NumFirstTimeUsersWithRepeatOrders]
	,SUM(case when o.FirstCompletedOrderForCustomer = 1 then tr.SalePrice end) [FirstTimeOrderTotals]
	,SUM(case when o.FirstCompletedOrderForCustomer = 1 then tr.SalePrice end)/COUNT(distinct(case when o.FirstCompletedOrderForCustomer = 1 then o.Id end)) [FirstTimeOrderAverage]

FROM Shipment s
	JOIN thingrequest tr ON tr.shipmentID = s.Id
	JOIN [Order] o on s.OrderId = o.id
	JOIN Customer c on o.CustomerId = c.Id

WHERE 
	tr.IsCancelled = 0
	AND tr.IsReturned = 0
	AND tr.IsMissingAfterDispatch = 0
	AND tr.HasFailedBeforeDispatch = 0
	AND o.OrderStatus in (30)
	AND o.StoreId = 1
	AND Cast(dbo.tobdt(o.CreatedOnUtc) as date) >= '2013-07-01'
	AND Cast(dbo.tobdt(o.CreatedOnUtc) as date) < '2013-10-01'

GROUP BY
	CONVERT(NVARCHAR(7), dbo.tobdt(o.CreatedOnUtc), 120)

--select * from @Result

-- [NumFirstTimeUsersWithRepeatOrders]

DECLARE @StartDate DATE;
DECLARE @NextDate DATE;
DECLARE @EndDate DATE;
DECLARE @NumFirstTimeUsersWithRepeatOrders TABLE([Month] Varchar(7),[NumFirstTimeUsersWithRepeatOrders] int);

SELECT
	@StartDate = CONCAT(MIN(Month),'-01'),
	@EndDate = DATEADD(month, DATEDIFF(month, 0, CONCAT(MAX(Month), '-01')), 1)
FROM @Result;

WHILE @StartDate < @EndDate
BEGIN
	SET @NextDate = DATEADD(MONTH,1,@StartDate)

-- #################################################################################################
	-- [NumUsersWhoRepeatedOrders]
	UPDATE @Result SET
			[NumUsersWhoRepeatedOrders] = i.[NumUsersWhoRepeatedOrders]
		FROM
			@Result r
			INNER JOIN 
				(
					SELECT
						CONVERT(NVARCHAR(7), @StartDate, 120) [Month]
						,COUNT(RepeatedCustomer.CustomerId) [NumUsersWhoRepeatedOrders]
					FROM (
						SELECT 
							o.CustomerId
							,COUNT(distinct o.id) [Num Orders]
						FROM 
							[Order] o
						WHERE
							o.OrderStatus in (30)
							AND o.StoreId = 1
							AND cast(dbo.tobdt(o.CreatedOnUtc) as date) < @NextDate
						GROUP BY
							o.CustomerId
						HAVING
							COUNT(distinct o.id) > 1
					) RepeatedCustomer

				) i ON r.Month = i.Month;


-- #################################################################################################
	-- [NumFirstTimeUsersWithRepeatOrders]
		INSERT INTO @NumFirstTimeUsersWithRepeatOrders
		SELECT
			RepeatedCustomer.Month [Month]
			,COUNT(RepeatedCustomer.CustomerId) [NumFirstTimeUsersWithRepeatOrders]
		FROM (
			SELECT 
				CONVERT(NVARCHAR(7), dbo.tobdt(o.CreatedOnUtc), 120) [Month]
				,o.CustomerId
				,COUNT(distinct o.id) [Num Orders]
			FROM 
				[Order] o
			WHERE
				o.OrderStatus in (30)
				AND cast(dbo.tobdt(o.CreatedOnUtc) as date) >= @StartDate
				AND cast(dbo.tobdt(o.CreatedOnUtc) as date) < @NextDate
				AND o.StoreId = 1
				AND o.CustomerId IN (
					select distinct o.CustomerId
					from [Order] o 
					where o.FirstCompletedOrderForCustomer = 1
					AND cast(dbo.tobdt(o.CreatedOnUtc) as date) >= @StartDate
					AND cast(dbo.tobdt(o.CreatedOnUtc) as date) < @NextDate
					AND o.StoreId = 1
				)
			GROUP BY
				CONVERT(NVARCHAR(7), dbo.tobdt(o.CreatedOnUtc), 120)
				,o.CustomerId
			HAVING
				COUNT(distinct o.id) > 1
		) RepeatedCustomer
		GROUP BY
			RepeatedCustomer.Month

	SET @StartDate = @NextDate;
END

-- Select * from @NumFirstTimeUsersWithRepeatOrders
UPDATE @Result SET
		[NumFirstTimeUsersWithRepeatOrders] = j.[NumFirstTimeUsersWithRepeatOrders]
	FROM
		@Result r
		INNER JOIN @NumFirstTimeUsersWithRepeatOrders j ON r.Month = j.Month;


Select * from @Result Order by Month






