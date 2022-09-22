/*
	01. Please share a sales report of vegetables from 25th Mar to 31st Mar 2022 Reconciled terns only Output Columns
	# Data,
	# Saleamount,
	# SaleQty,
	# sold weight in TON 
	# Sort Sold wight in TON" column by Z to A 
*/

select  cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		sum(tr.SalePrice) [SaleAmount],
		count(tr.SalePrice) [SaleQty],
		sum(pv.Weight)/1000 [Weight/TON]

from ThingRequest tr
join shipment s on s.id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join ProductVariantCategoryMapping pvcm on pv.Id = pvcm.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-25 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and pvcm.CategoryId = 12

group by cast(dbo.ToBdt(s.ReconciledOn)as date)

order by 4 desc

--=========================================================================================================================================================--

/*
	02.	Please share a sales report of vegetables from 27th Mar to 31st Mar 2022 Reconciled terns only Output Columns
	# Date
	# pvid
	# product
	# Missing Qty
	# Demage Qty
	# Date Colum by Z to A 
*/


select  cast(dbo.ToBdt(tt.CreatedOn)as date) [Date],
		pv.Id [PVID],
		pv.Name [Product],
		Count(case   when tt.ToState in (16) 
				then pv.Id 
		 else null  end 
		) [Missing Qty],
		Count(case   when tt.ToState in (8,32) 
				then pv.Id 
		 else null  end 
		) [Demage Qty]

from thing t
join ThingEvent te on t.Id = te.ThingId
join ThingTransaction tt on tt.Id = te.ThingTransactionId 
join ProductVariant pv on pv.id = t.ProductVariantId 
join ProductVariantCategoryMapping pvc on pv.Id = pvc.ProductVariantId 

where tt.CreatedOn >= '2022-03-27 00:00 +06:00'
and tt.CreatedOn < '2022-04-01 00:00 +06:00'
and tt.ToState in (8,16,32,64)
and pvc.CategoryId = 12

Group by cast(dbo.ToBdt(tt.CreatedOn)as date),
		 pv.Id,
		 pv.Name
Order by 4 desc

--=========================================================================================================================================================--

/*
	03. Please share top 20 adjusted products (Failed before dispatch) in Mar 2022. (take only reconciled orders) Output Column:- 
	# ProductVariantId,
	# ProductName,
	# AdjustedQty,
	# AdjusedAmount (MRP)
	# Sort AdjustedQty Column by Z to A"
*/

select top 20 pv.Id [PVID],
		pv.Name [Product],
		count(pv.Id) [AdjustedQty],
		sum(tr.Mrp) [AdjusedAmount]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.EstimatedDeliveredOn is not null
and s.EstimatedDeliveredOn  >= '2022-03-01 00:00 +06:00'
and s.EstimatedDeliveredOn < '2022-04-01 00:00 +06:00'
and tr.HasFailedBeforeDispatch = 1

group by pv.Id,
		 pv.Name

order by 4 desc

--=========================================================================================================================================================--

/*
	04. Find the bottom 50 products of Mirpur warehouse only for 2021 (based on total customer count), Take only reconciled items.Output columns should have 
	# product variant id,
	# productname,
	# total customer count,
	# total order count,
	# total sale quantity,
	# total sales amount.
*/

select top 50 pv.Id [PVID],
		pv.Name [Product],
		count(distinct(o.customerId)) [TotalCustomerCount],
		count(distinct(o.id)) [TotalOrderCount],
		count(tr.SalePrice) [TotalSaleQty],
		sum(tr.SalePrice) [TotalSale Amount]

from ThingRequest tr
join Shipment s on s.id = tr.ShipmentId 
join [Order] o on o.Id = s.OrderId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2021-01-01 00:00 +06:00'
and s.ReconciledOn < '2022-01-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and s.WarehouseId = 4

group by pv.Id,
		 pv.Name

order by 3 desc


--=========================================================================================================================================================--

/*
	05. Please share the current customers count of Super Regular and Dead states and their Complete and cancelled orders count (life time). Output column : 
	# Customer State Name,
	# Order State Name,
	# Customer Count,
	# Order Count
	# Sort ""CustomerStateName"" Column By Z to A and ""OrderStateName"" A to Z"
*/

select  dbo.GetEnumName('CustomerState',CustomerState) [CustomerStateName],
		dbo.GetEnumName('OrderStatus', OrderStatus) [OrderStateName],
		count(distinct(c.id)) [CustomerCount],
		count(distinct(o.id)) [OrderCount]

from customer c
join [Order] o on o.CustomerId = c.Id 

where c.CustomerState in (70,90)
and o.OrderStatus  in (30,40)

Group by dbo.GetEnumName('CustomerState', CustomerState),
		 dbo.GetEnumName('OrderStatus' , OrderStatus )

order by 1 desc , 2 asc







