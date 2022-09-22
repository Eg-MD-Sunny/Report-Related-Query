select  TOP 10 e.Id [ID],
		e.BadgeId [CDBD],
		e.FullName [Name],
		o.id [OrderID]

from Employee e
join customer c on c.Id = e.Id
join [Order] o on c.Id = o.CustomerId 
where c.Id = 32034283

order by 4 desc



--select top 2 *
--from Employee 

--select top 2 *
--from Customer 