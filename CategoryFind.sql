select pv.name PVName
from ProductVariant pv
where pv.id in (9751,15980,3158,5609,8474,6568)

select c.name CategoryName
from Category c
where c.id = 25


select pv.Name AllProductName
from ProductVariant pv
join ProductVariantCategoryMapping pvcm on pvcm.ProductVariantId  = pv.Id 
join Category c on c.Id = pvcm.CategoryId 

where c.Id = 11