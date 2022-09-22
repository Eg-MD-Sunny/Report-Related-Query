select w.Id [WarehouseID],
       w.Name [Warehouse],
	   pv.Id [PVID],
	   pv.Name [Product],
	   count(pv.Id) [Missing Qty]

from thing t
join ThingEvent te on t.Id = te.ThingId 
join ThingTransaction tt on tt.Id = te.ThingTransactionId 
join Warehouse w on w.Id = t.WarehouseId 
join ProductVariant pv on pv.Id = t.ProductVariantId 

where tt.CreatedOn >= '2022-06-08 00:00 +06:00'
and tt.CreatedOn < '2022-06-15 00:00 +06:00'
and tt.ToState in (16)
and pv.Id in (27863)

Group by w.Id,
         w.Name,
	     pv.Id,
	     pv.Name