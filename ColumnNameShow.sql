----Show DataBase Any Table All Column Name 

---Helping Querry
select top 100 *
from ProductVariant 
order by Id desc

---Show Any Product Category 
select * from Category c where c.name like '%Fresh Vegetables%'


select COLUMN_NAME 
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME ='WarehouseStock'


select top 100 *
from CurrentWarehouseStock  