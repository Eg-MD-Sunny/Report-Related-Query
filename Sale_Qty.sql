select pv.Name [Product],
	   count(tr.SalePrice) [SaleQty],
	   sum(tr.SalePrice) [Sale Amount],
	   (Case when pv.ShelfType = 5 Then 'Perishable' When pv.ShelfType = 9 Then 'Frozen Perishable' else Null end) Category

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-01 00:00 +06:00'
and s.ReconciledOn < '2022-03-06 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and pv.ShelfType in (5,9)

group by pv.Name,
         (Case when pv.ShelfType = 5 Then 'Perishable' When pv.ShelfType = 9 Then 'Frozen Perishable' else Null end)

