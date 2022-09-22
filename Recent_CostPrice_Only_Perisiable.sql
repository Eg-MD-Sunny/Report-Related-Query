select pv.Id [PVID],
       pv.Name [Product],
	   pvc.CostPrice [CostPrice]

from ProductVariantPricing pvc 
join ProductVariant pv on pv.Id = pvc.ProductVariantId 

where pvc.ValidFrom >= '2022-03-01 00:00 +06:00'
and pvc.ValidFrom < '2022-03-02 00:00 +06:00'
and pv.ShelfType in (5,9)

