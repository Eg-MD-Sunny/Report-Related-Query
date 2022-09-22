/** Thing Querry Part - 03**/

	 select distinct tr.ProductVariantId,pv.Name,tr.Mrp,
	 max(case when w.MetropolitanAreaId=1 then tr.ListPrice else null end) DHKListPrice,
	 max(case when w.MetropolitanAreaId=2 then tr.ListPrice else null end) CTGListPrice,
	 max(case when w.MetropolitanAreaId=3 then tr.ListPrice else null end) JSRListPrice,
	 max(case when w.MetropolitanAreaId=4 then tr.ListPrice else null end) KHListPrice

	from [order] o
	join shipment s on s.OrderId=o.Id
	join ThingRequest tr on tr.ShipmentId=s.Id
	join ProductVariant pv on pv.Id=tr.ProductVariantId
	join thing t on t.id=tr.AssignedThingId
	join warehouse w on w.id=s.WarehouseId

	where cast(dbo.tobdt(o.CreatedOnUtc) as Date)='2021-11-14'
	and tr.productvariantid in (2512,2290,13429)

	group by tr.ProductVariantId,pv.Name,tr.Mrp

/**End**/