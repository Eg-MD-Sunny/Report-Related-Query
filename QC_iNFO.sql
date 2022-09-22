select e.BadgeId [CDBD],
	   e.FullName [Name],
	   d.Id [Designation ID],
	   d.DesignationName [Designation]

from Employee e
join Designation d on d.Id = e.DesignationId 

where d.Id = 53


select * from Designation 