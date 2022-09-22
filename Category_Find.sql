select pv.Id,
pv.Name,
pvcm.CategoryId,
c.Name

from ProductVariant pv
join productvariantcategorymapping pvcm on pvcm.productvariantid=pv.id
join category c on c.id=pvcm.CategoryId

where pv.id=8789

select * from productvariant where name LIKE '%Apple Jujube (Apple Kul Boroi) 500 gm%'