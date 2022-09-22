select  pv.id [PVID],
		pv.Name [Product],
		pvp.CostPrice [RecentCostPrice],
		pvp.CachedListPrice [RecentListPrice],
		pv.Mrp [RecentMRP],
		Format(((pv.Mrp)-(pvp.CachedListPrice))/(pv.Mrp),'P') [Discount]

from ProductVariant pv
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId 

where pv.Published = 1
and pv.Deleted = 0
and pv.Name like '%Shagor Kola%'
and pvp.MetropolitanAreaId = 3

Group By pv.id,
		 pv.Name,
         pvp.CostPrice,
		 pvp.CachedListPrice,
		 pv.Mrp



