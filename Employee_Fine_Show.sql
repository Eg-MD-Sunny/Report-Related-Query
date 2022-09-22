select e.badgeid CDBD, e.fullname Name, PerformanceEventType,cast(dbo.tobdt(createdon) as date)dates,amount,Memo,IsRevoked
from EmployeePerformanceEvent epe
join Employee e
on epe.EmployeeId = e.id
where e.badgeid = 2624