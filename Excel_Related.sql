select pv.Id [PV ID],
       pv.name [Product],
	   count(tr.SalePrice)[Sale Qty],
	   sum(tr.SalePrice)[Sale Amount]

from Thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-26 00:00 +06:00'
and s.ReconciledOn < '2022-02-27 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pv.Id in (14927,
20291,
20293,
20357,
20359,
20423,
20502,
24026,
24060,
24076,
24126,
24267,
24269,
24278)

group by pv.Id,
         pv.name
