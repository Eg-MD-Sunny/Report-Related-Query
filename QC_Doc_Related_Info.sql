select e.BadgeId [CDBD],
	   e.FullName [Name],
	   d.Id [DesignationId],
	   d.DesignationName [DesignationName],
	   e.JoinedOn [JoiningDate],
	   e.TerminatedOn [Terminated]

from Employee e 
join Designation d on d.Id = e.DesignationId 

where e.BadgeId in (11652)
--and e.TerminatedOn is not null
and d.Id in (53)

--select *
--from Employee e
--where e.BadgeId = 8127

