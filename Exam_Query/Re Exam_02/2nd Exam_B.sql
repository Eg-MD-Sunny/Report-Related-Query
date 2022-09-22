--"Find warehouse wise Sales of Soyabean Oil 5 ltr (Rupchanda) of Mar 2022 (Reconciled)
--Output Column should have warehouse_id,warehouse name,Order Qty, total sale quantity, total sales amount"

select  w.id [WarehouseID],
		w.Name [WarehouseName],
		Count(distinct(s.orderId)) [OrderQty],
		Count(tr.SalePrice) [TotalSaleQty],
		Sum(tr.SalePrice) [TotalSaleAmount]

from ThingRequest tr 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join Warehouse w on w.Id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-01 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pv.id in (2443)

Group by  w.id,
		  w.Name







