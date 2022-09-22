--Adding Return Product in Shelf

select w.Id					[WID],
	   w.Name				[WarehouseName],
	   e.badgeid			[badgeid],
	   e.FullName			[EmployeeName],
	   de.designationname	[Designation],
	   pv.id				[PVID],	
	   pv.name				[Product],
	   count(*)				[Quantity],
	   t.CostPrice			[Price]
	   

from thingevent te
join thing t on t.id = te.thingid
join thingtransaction tt on tt.id = te.thingtransactionid
join productvariant pv on pv.id = t.productvariantid
join employee e on e.id = tt.CreatedByCustomerId
join designation de on de.id = e.designationid
join warehouse w on w.id=e.WarehouseId
join Shelf sh on sh.Id=t.ShelfId

where tt.fromstate in (2199023255552,274877906944,8796093022208,70368744177664,140737488355328)
and tt.tostate in (256)
and tt.CreatedOn >= '2022-04-01 00:00 +06:00'
and tt.CreatedOn < '2022-05-01 00:00 +06:00'

group by w.Id,
		 w.Name,
	     e.badgeid,
	     e.FullName,
	     de.designationname,
	     pv.id,
	     pv.name,
		 t.CostPrice

order by 8 desc




--Adding Audit Product in Shelf