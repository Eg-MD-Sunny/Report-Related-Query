--select w.MetropolitanAreaId [MetropolitanAreaId],
--       pv.Id [PVID],
--	   pv.Name [Name]

--from ThingRequest tr
--join Shipment s on s.Id = tr.ShipmentId 
--join ProductVariant pv on pv.Id = tr.ProductVariantId 
--join Warehouse w on w.id = s.WarehouseId 

--where s.ReconciledOn is not null
--and s.ReconciledOn >= '2022-02-22 00:00 +06:00'
--and s.ReconciledOn < '2022-03-10 00:00 +06:00'
--and pv.Published = 1
--and pv.ShelfType in (5,9)

--and pv.Id not in (
--	select pv.id
--	from ThingRequest tr
--    join Shipment s on s.Id = tr.ShipmentId 
--    join ProductVariant pv on pv.Id = tr.ProductVariantId 
--	where s.ReconciledOn is not null
--    and s.ReconciledOn >= '2022-02-22 00:00 +06:00'
--    and s.ReconciledOn < '2022-03-10 00:00 +06:00'
--	and IsCancelled=0
--    and IsReturned=0
--    and HasFailedBeforeDispatch=0
--    and IsMissingAfterDispatch=0
--	and pv.ShelfType in (5,9)
--	and s.ShipmentStatus not in (1,9,10)
--)








select w.MetropolitanAreaId [MetropolitanAreaId],
       pv.Id [PVID],
	   pv.Name [Name]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join Warehouse w on w.id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-22 00:00 +06:00'
and s.ReconciledOn < '2022-03-10 00:00 +06:00'
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.ShelfType in (5,9)
and s.ShipmentStatus not in (1,9,10)
and pv.Published = 1
