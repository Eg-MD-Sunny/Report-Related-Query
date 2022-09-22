select pv.Id [PVID],
       pv.Name [Product],
	   sum(case when w.MetropolitanAreaId = 2 then pvp.CostPrice else null end)[CTG_CostPice],
	   sum(case when w.MetropolitanAreaId = 2 then tr.SalePrice else null end)[CTG_SalePrice],
	   sum(case when w.MetropolitanAreaId = 3 then pvp.CostPrice else null end)[JSR_CostPice],
	   sum(case when w.MetropolitanAreaId = 3 then tr.SalePrice else null end)[JSR_SalePrice]

from Thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId 
join Warehouse w on w.id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-06 00:00 +06:00'
and s.ReconciledOn < '2022-02-09 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)

group by pv.Id,
         pv.Name