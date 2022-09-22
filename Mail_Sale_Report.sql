select pv.Id [PVID],
       pv.Name [Product],
	   count(tr.SalePrice) [QTY],
	   sum(tr.SalePrice) [Sale Amount]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-04 00:00 +06:00'
and s.ReconciledOn < '2022-02-06 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)

group by pv.Id,
         pv.Name



select pv.Id [PVID]
from ProductVariant pv
where pv.Name like '%%'