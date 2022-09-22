select *
from Designation 

select top 5 *
from Employee 

----(Start) Any Emploee All Info Find 
	select e.FullName, e.PhoneNumber, e.Email, d.DesignationName 
	from Employee e
	join Designation d on d.Id = e.DesignationId 
	where e.BadgeId in (8005, 8006)
----(End) Any Emploee All Info Find


----(Start) Any Emploee All Info Find //using Designation//
select e.FullName, e.BadgeId, d.DesignationName  
from Employee e
join Designation d on d.Id = e.DesignationId 
where d.Id = 99
--99,36
----(End) Any Emploee All Info Find //using Designation//