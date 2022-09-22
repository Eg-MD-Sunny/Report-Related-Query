--Find top 10 products (Quantity Wise) PurchaseOrder Details of Diaper Category from beginning to Feb2021.
--But total cost price should be greater than 2,500,000/- and total quantity should be greater than 3,000.
--Use "Price Set On" as date range.

--Select c.Id [ID],
--       c.Name [Name]
--from Category c
--where c.Name like 'Diapers'


select top 10  pv.id [PVID],
               pv.Name [Product],
			   Count(case when t.CreationEventType in (1,2,10)
					 then pv.Id  
					 else null end
			   ) [Quantity],
			   Sum(t.CostPrice) [Cost Price]

from Thing t 
join ProductVariant pv on pv.Id = t.ProductVariantId
join ProductVariantCategoryMapping pvcm on pv.Id = pvcm.ProductVariantId 


where t.PriceSetOn >= '2022-03-01 00:00 +06:00'
and t.PriceSetOn < '2022-03-02 00:00 +06:00'
and pvcm.CategoryId in (211)


Group by pv.id,
         pv.Name

having Sum(t.CostPrice) > 2500 
and Count(case when t.CreationEventType in (1,2,10)
					 then pv.Id  
					 else null end
	) > 15









