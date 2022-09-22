select distinct pv.Id [PVID],
       pv.Name [ProductName],
	   max(t.CostPrice) [Last_CostPrice],
	   pv.Mrp [MRP],
	   t.PriceSetOn [Last_CostPrice_SetOn]

from Thing t
join ProductVariant pv on pv.Id = t.ProductVariantId 

where t.CostPrice is not null
and pv.Published = 1

group by pv.Id,
         pv.Name,
	     pv.Mrp,
	     t.PriceSetOn