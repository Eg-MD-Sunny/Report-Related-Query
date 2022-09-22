---Vegetable 

select  (case when ma.Id is not null
		      then ma.Name 
	     else 'Global' end) [City],
		pv.Id [PVID],
		pv.Name [Product],
		pv.NameBn [BanglaName],
		pv.Published [Published],
		pv.Deleted [Deleted],
		pv.Weight [Weight/KG],
		pvp.CostPrice [CostPrice]
		

from ProductVariant pv
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId 
left join MetropolitanArea ma on ma.Id = pvp.MetropolitanAreaId 

where pv.Id in (
	select ProductVariantId from ProductVariantCategoryMapping 
	where CategoryId in (12)
)

order by 8 desc




---Fruits

select  (Case When ma.Id is not null
		      then ma.Name 
	     else 'Global' end) [City],
		pv.Id [PVID],
		pv.Name [Product],
		pv.NameBn [BanglaName],
		pv.Published [Published],
		pv.Deleted [Deleted],
		pv.Weight [Weight/KG],
		pvp.CostPrice [CostPrice]


from ProductVariant pv
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId 
left join MetropolitanArea ma on ma.Id = pvp.MetropolitanAreaId 


where pv.Id in (
	select ProductVariantId from ProductVariantCategoryMapping 
	where CategoryId in (11)
)

order by 8 desc










--select  c.Id [CID],
--		c.Name [Name]

--from Category c 
--where c.Name like '%Fresh Vegetables%'