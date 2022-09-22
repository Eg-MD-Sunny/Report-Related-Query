
Select		CONVERT (DATE,dbo.ToBdt(GETDATE()))

Select		CONVERT (DATE,(dateadd(day,-1,dbo.ToBdt(GETDATE()))))

Select		CONCAT(CONVERT(varchar, getdate(), 23),' 00:00 +6:00')

Select		CONCAT(CONVERT(varchar, dbo.ToBdt ( getdate() ), 23),' 00:00 +6:00')

Select		CONCAT(CONVERT(varchar, dbo.ToBdt ( getdate()-1 ), 23),' 00:00 +6:00')

Select		CONVERT(varchar, dbo.ToBdt ( getdate() ), 23)

Select		CONVERT(varchar, dbo.ToBdt ( getdate()-30 ), 23)

Select		dateadd(mm, datediff(mm, 0, dbo.ToBdt ( getdate() ) ) - 1, 0)

Select		dateadd(mm, datediff(mm, 0, dbo.ToBdt ( getdate() ) ) - 0 , 0)  

Select		convert(date,(DATEADD(m,DATEDIFF(m, 0, dbo.ToBdt(GETDATE())), 0)))

Select		Month( dbo.ToBdt ( getdate() ) ) - 1







Select      [Warehouse].[WarehouseGroupId], [WarehouseGroup].[Name] [Group],
            [Warehouse].[Id] [WarehouseID], [Warehouse].[Name] [Warehouse]
from        [Warehouse]
    Join    [WarehouseGroup] On [Warehouse].[WarehouseGroupId] = [WarehouseGroup].[Id]


Select		*
From		[Warehouse]










/*


DECLARE @StartDate date, @EndDate date;
SET @StartDate = CONVERT (date,(dateadd(day,-1,dbo.ToBdt(GETDATE()))));
SET @EndDate = CONVERT (DATE,dbo.ToBdt(GETDATE()));

Select Count(distinct c.CustomerCount) CustomerCount
From
	(select  o.CustomerId CustomerCount
	from [order] o
	join shipment s on s.OrderId=o.id
	join ThingRequest tr on tr.ShipmentId=s.id
	where cast(dbo.tobdt(s.ReconciledOn) as date)>=@StartDate
	and cast(dbo.tobdt(s.ReconciledOn) as date)<@EndDate
	and shipmentstatus NOT IN ( 1, 9, 10 )
	and IsReturned=0
	and IsMissingAfterDispatch=0
	and IsCancelled=0
	and HasFailedBeforeDispatch=0
	and s.ReconciledOn is not null
	group by o.CustomerId
	having Count(tr.ProductVariantId)>30) C


--		CONVERT (datetimeoffset,(dateadd(day,-1,dbo.ToBdt(GETDATE()))))
--		SET @StartDate = CONVERT (DATE,(dateadd(day,-1,dbo.ToBdt(GETDATE()))));

Select CONVERT (datetime,(dateadd(day,-0,dbo.ToBdt(GETDATE()))))

Select CONVERT (datetime2,(dateadd(day,-0,dbo.ToBdt(GETDATE()))))

Select GETDATE()

DECLARE @Start datetimeoffset = '2021-10-14 00:00 +6:00'; 
DECLARE @End datetimeoffset = '2021-10-15 00:00 +6:00'; 

SELECT S.ReconciledOn, OrderId
from [order] o
	join shipment s on s.OrderId=o.id
	join ThingRequest tr on tr.ShipmentId=s.id
	where s.ReconciledOn >=@Start
	and s.ReconciledOn <@End
	and shipmentstatus NOT IN ( 1, 9, 10 )
	and IsReturned=0
	and IsMissingAfterDispatch=0
	and IsCancelled=0
	and HasFailedBeforeDispatch=0
	and s.ReconciledOn is not null
group by S.ReconciledOn, OrderId
Order By 1


*/
