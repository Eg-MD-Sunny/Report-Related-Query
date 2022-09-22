--employee neme and reporting time

select e.BadgeId,
       e.FullName,
	   e.ShiftStartTime1,
	   e.ShiftStartTime2,
	   (Case	when e.OffDayBits in (1)
				then 'Friday'
				when e.OffDayBits in (2)
				then 'Saturday'
				when e.OffDayBits in (4)
				then 'Sunday'
				when e.OffDayBits in (8)
				then 'Monday'
				when e.OffDayBits in (16)
				then 'Tuesday'
				when e.OffDayBits in (32)
				then 'Wednesday'
				when e.OffDayBits in (64)
				then 'Tharsday'
		else null end
	   ) [Offday]

from Employee e

where e.BadgeId in (3218,12195,8005,5732,8625,11662,8858,5130,8636,5656,8624,4526)
