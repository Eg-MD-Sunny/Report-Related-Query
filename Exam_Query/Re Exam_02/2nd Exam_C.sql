--"Find the top 10 most profitable products of Dec 2021. Take Only Profitable Products. (reconciled)
--Output column should have product variant id,productname,order qty, sale qty, total cost price,total sale price, profit amount"

select top 10 pv.id [PVID],
		pv.Name [Product],
		Count(distinct(s.orderId)) [OrderQty],
		Count(tr.SalePrice) [SaleQty],
		Sum(t.CostPrice) [TotalCostPrice],
		Sum(tr.SalePrice) [TotalSalePrice],
		Sum(tr.SalePrice)-Sum(t.CostPrice) [Profit]

from thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2021-12-01 00:00 +06:00'
and s.ReconciledOn < '2022-01-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)

Group by pv.id,
		 pv.Name

Order by 7 desc

