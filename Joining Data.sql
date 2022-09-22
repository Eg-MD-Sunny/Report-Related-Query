select  e.BadgeId [CDBD],
		e.FullName [FullName],
		cast(dbo.ToBdt(e.JoinedOn) as Date) [JoinedO],
		e.Gender [Gender],
		(case when w.MetropolitanAreaId=1 then 'Dhaka' when w.MetropolitanAreaId=2 then 'Chattogram' Else 'Jashore' end) [Area],
		w.Name [Warehouse],
		d.Id [DesignationID],
		d.DesignationName [DesignationName]

from Employee e
join Designation d on d.id=e.DesignationId
full join Warehouse w on e.WarehouseId=w.Id

where e.JoinedOn is not null
and cast(dbo.ToBdt(e.JoinedOn) as Date) >= '2022-09-15'
and cast(dbo.ToBdt(e.JoinedOn) as Date) < '2022-09-16'
and w.DistributionNetworkId=1

order by 3 asc





