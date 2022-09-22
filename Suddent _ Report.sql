select pv.Id [PVID],
       pv.name [Product],
	   count(tr.SalePrice) [SalesQTY],
	   count(case when tt.ToState in (8,32) then (pv.Id) else null END) [DemageQTY]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join thing t on t.Id = tr.AssignedThingId 
join ThingEvent te on te.ThingId = t.Id 
join ThingTransaction tt on te.ThingTransactionId = tt.Id 


where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-26 00:00 +06:00'
and s.ReconciledOn < '2022-02-27 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)


group by pv.Id,
       pv.name




--select top 1 * from ThingEvent te
--select top 1 * from ThingTransaction tt