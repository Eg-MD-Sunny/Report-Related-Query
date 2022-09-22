select e.BadgeId [CDBD],
       e.FullName [Name],
	   d.DesignationName [Designation],
	   e.ShiftStartTime1 [1st FingerPrint Time]
	   --e.ShiftStartTime2 [2nd FingerPrint Time]

from Employee e
join Designation d on d.Id = e.DesignationId 
where e.BadgeId = 8005


--select top 10 *
--from Designation 

--select top 10 *
--from Employee 