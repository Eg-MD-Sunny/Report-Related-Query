select top 50
              Month(cast(dbo.ToBdt(S.ReconciledOn)as date))Month,
              pv.id,
              pv.name,
			  count(tr.SalePrice)QTY,
			  sum(tr.SalePrice)SaleAmount,
			  (pv.Weight)NetWeight

from ThingRequest tr 
join Thing t on t.id = tr.AssignedThingId 
join Shipment s on s.id = tr.ShipmentId 
join ProductVariant pv on pv.id = tr.ProductVariantId 
join ProductVariantCategoryMapping pvcm on pvcm.ProductVariantId = pv.Id  

where s.ReconciledOn is not null
and s.ReconciledOn >= '2021-10-01 00:00 +06:00'
and s.ReconciledOn < '2021-10-05 00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and pvcm.CategoryId in (11,12)

group by  pv.Weight,pv.name,pv.Id,Month(cast(dbo.ToBdt(S.ReconciledOn)as date))

