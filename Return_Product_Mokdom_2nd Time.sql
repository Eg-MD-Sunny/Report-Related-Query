select cast(dbo.ToBdt(ro.CreatedOn) as date)[Date],
	   ro.Id [ReturnOrderID],
	   v.Name [VandorName],
	   pv.Id [PVID],
	   pv.Name [Product],
	   Count(ro.Id) [ReturnOrderID],
	   Sum(t.ReturnPrice) [TotalReturnPrice],
	   w.Id [SourchingWarehouseID],
	   e.FullName [EmployeeName]


from ReturnOrder ro
join Vendor v on v.Id = ro.VendorId 
join Warehouse w on w.Id = ro.SourcingWarehouseId
join thing t on t.ReturnOrderId = ro.Id 
join ProductVariant pv on pv.Id = t.ProductVariantId 
join Employee e on e.Id = ro.PlacedByCustomerId 

where ro.CreatedOn >= '2022-03-20 00:00 +06:00'
and ro.CreatedOn < '2022-03-21 00:00 +06:00'
and v.Name like '%MD Mokdom%'
and ro.ReturnOrderStatus not in (3)

Group By cast(dbo.ToBdt(ro.CreatedOn) as date),
	     ro.Id,
	     v.Name,
	     pv.Id,
	     pv.Name,
	     w.Id,
	     e.FullName