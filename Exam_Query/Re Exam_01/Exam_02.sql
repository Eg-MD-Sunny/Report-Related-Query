select  pv.Id [PVID],
		pv.Name [Product],
		Count(tr.SalePrice) [SaleQty],
		Sum(tr.SalePrice) [Amount]

from thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-04-01 00:00 +06:00'
and s.ReconciledOn < '2022-04-04 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pv.ShelfType in (5,9)

Group by  pv.Id,
		  pv.Name
