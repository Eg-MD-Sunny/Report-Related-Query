---=============================================---

-----Geting Min & Max Thing ID
select Max(te.ThingId) [MaximumThingID],
       Min(te.ThingId) [MinimumThingID]
from ThingEvent te
join ThingTransaction tt on tt.Id = te.ThingTransactionId 

where tt.CreatedOn >= '2022-03-15 00:00 +06:00'
and tt.CreatedOn < '2022-03-16 00:00 +06:00'
and tt.ToState in (8,16,32)

---=============================================---

-----// Demage & Missing Report //-----

select w.MetropolitanAreaId [MetropolitanID],
       w.Id [WarehouseID],
	   w.Name [Warehouse],
	   pv.Id [PVID],
	   pv.Name [Product],
	   count(
			case 
				when tt.ToState in (16)
				then (pv.Id)
			else null end
		) [Missing Qty],
       count(
			case 
				when tt.ToState in (8,32)
				then (pv.Id)
			else null end
	   ) [Demage QTY]
	   
from Thing t
join ThingEvent te on t.Id = te.ThingId 
join ThingTransaction tt on tt.Id = te.ThingTransactionId
join ProductVariant pv on pv.Id = t.ProductVariantId 
join Warehouse w on w.Id = t.WarehouseId 

where tt.CreatedOn >= '2022-03-15 00:00 +06:00'
and tt.CreatedOn < '2022-03-16 00:00 +06:00'
and tt.ToState in (8,16,32)
and pv.ShelfType in (5,9)
and t.id >= 43753389 ------ MinimumThingId
and t.id <= 137157702 ------ MaximumThingId

group by w.MetropolitanAreaId,
         w.Id,
	     w.Name,
	     pv.Id,
	     pv.Name
