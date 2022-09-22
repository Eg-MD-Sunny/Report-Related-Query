---Output Colum Should Have || Date, OrderReturnID, PVID, PVName, VendorName, ReturnProductQTY, TotalReturnPrice, SourchingWarehouseName, EmployeeName
---Return Products To MR. Mokdom


select cast(dbo.toBdt(ro.CreatedOn)as date)[Date],
	   ro.Id [OrderReturnID],
	   pv.Id [PVID],
	   pv.Name [Product],
	   v.Name [VendorName],
	   Count(ro.Id) [ReturnProductQTY],
	   Sum(t.ReturnPrice) [ReturnPrice],
	   w.Name [SourchingWarehouseName],
	   e.FullName [EmployeeName]


from ReturnOrder ro
join Vendor v on v.Id = ro.VendorId 
join Employee e on e.Id = ro.PlacedByCustomerId 
join Thing t on t.ReturnOrderId = ro.Id 
join ProductVariant pv on pv.Id = t.ProductVariantId 
join Warehouse w on w.Id = ro.SourcingWarehouseId 

where ro.CreatedOn >= '2022-03-20 00:00 +06:00'
and ro.CreatedOn < '2022-03-21 00:00 +06:00'
and ro.ReturnOrderStatus not in (3)
and v.Id = 459


Group by cast(dbo.toBdt(ro.CreatedOn)as date),
	     ro.Id,
	     pv.Id,
	     pv.Name,
	     v.Name, 
	     w.Name,
	     e.FullName








-----// Start Useable Table //-----

select top 10 * from ReturnOrder RO
select top 10 * from Employee E
select top 10 * from Thing T
select top 10 * from ProductVariant PV
select top 10 * from Vendor V
select top 10 * from Warehouse W

-----// End Useable Table //-----



-----// Start Helping Function //-----
select v.Id [VendorID], 
       v.Name [VendorName]
from Vendor v
where v.Name like 'MD Mokdom'

--cast(dbo.tobdt(ro.CreatedOn) as date) =CAST(GETDATE()-1 as date)

-----// End Helping Function //-----