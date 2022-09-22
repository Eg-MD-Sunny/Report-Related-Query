---=======================================================---
SELECT max(tr.id) MaximumThingrequestID, 
       min(tr.id) MinimumThingrequestID

FROM ThingRequest tr
join shipment s on s.id = tr.shipmentid

WHERE ReconciledOn is not null
and s.ReconciledOn >= '2022-03-17 00:00 +6:00'
and s.ReconciledOn < '2022-03-18 00:00 +6:00'

---========================================================---

select w.Id [WarehouseID],
       w.Name [Warehouse],
	   pv.Id [PVID],
	   pv.name [Product],
	   count(tr.SalePrice)[SaleQty],
	   sum(tr.SalePrice) [SalePrice],
	   sum(t.CostPrice) [CostPrice],
	   (sum(tr.SalePrice)-sum(t.CostPrice))[Profit],
	   (sum(t.CostPrice) - sum(tr.SalePrice)) [Loss], 
	   ((sum(tr.SalePrice)-sum(t.CostPrice))/sum(tr.SalePrice)) [ProfitMargin],
	   (sum(tr.SalePrice)/count(distinct(o.id))) [CartSize]

from thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.id = tr.ShipmentId 
join [Order] o on o.Id = s.OrderId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId  
join Warehouse w on w.Id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-14 00:00 +06:00'
and s.ReconciledOn < '2022-03-16 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and pv.ShelfType in (5,9)
and s.ShipmentStatus not in (1,9,10)
and tr.id >= 74835402
and tr.Id <= 77584323

Group By w.Id,
         w.Name,
	     pv.Id,
	     pv.name,
		 (pvp.CachedListPrice - tr.SalePrice)

--Order by Discount 