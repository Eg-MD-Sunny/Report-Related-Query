--"Find the bottom 50 products of Mirpur warehouse only for 2021 (based on total customer count), Take only reconciled items.
--Output columns should have product variant id,productname, total customer count, total order count, total sale quantity, total sales amount."



select top 50 pv.Id [PVID],
		pv.Name [Product],
		Count(distinct o.CustomerId) [TotalCustomerCount],
		Count(distinct o.id) [TotalOrderId],
		Count(tr.SalePrice) [TotalSaleQty],
		Sum(tr.SalePrice) [TotalSaleAmount]

from ThingRequest tr 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join [Order] o on o.id = s.OrderId

where s.ReconciledOn is not null 
and s.ReconciledOn >= '2021-01-01 00:00 +06:00'
and s.ReconciledOn < '2022-01-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and s.WarehouseId = 4

Group By pv.Id,
		 pv.Name

Order by 3 asc
