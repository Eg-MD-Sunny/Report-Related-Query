select cast(dbo.ToBdt(tt.CreatedOn)as date) [Date],
	   w.MetropolitanAreaId [MetropolitanAreaID],
	   w.Id [WarehouseID],
	   w.Name [Warehouse],
	   --s.OrderId [OrderId],
	   pv.Id [PVID],
	   pv.Name [Product],
	   Count(Case when tt.ToState in (8,32) 
			 then pv.Id 
			 else null end
	   )[DemageQty],
	   Count(Case when tt.ToState in (16) 
			 then pv.Id 
			 else null end
	   )[MissingQTY]

from thing t
join ThingEvent te on t.id = te.ThingId 
join ThingTransaction tt on tt.Id = te.ThingTransactionId 
join Warehouse w on w.Id = t.WarehouseId 
join ProductVariant pv on pv.Id = t.ProductVariantId 


where tt.CreatedOn >= '2022-06-09 00:00 +06:00'
and tt.CreatedOn < '2022-06-16 00:00 +06:00'
and pv.ShelfType  not in (5,9)
and tt.ToState in (8,16,32)
--and pv.name like '%For Pvid%'
--and t.Id >= 38603735
--and t.Id <= 137573013
--and  pv.BlockSale = 1
and pv.giftForProductVarientId is not null

Group by cast(dbo.ToBdt(tt.CreatedOn)as date),
	     w.MetropolitanAreaId,
	     w.Id,
	     w.Name,
	     pv.Id,
	     pv.Name
		-- s.OrderId


----====================================================-----
--select Max(te.ThingId) [MaximumThingID],
--       Min(te.ThingId) [MinimumThingID]

--from ThingEvent te
--join ThingTransaction tt on tt.Id = te.ThingTransactionId 

--where tt.CreatedOn >= '2022-03-17 00:00 +06:00'
--and tt.CreatedOn < '2022-03-18 00:00 +06:00'
----====================================================-----




select top 1 * from ProductVariant