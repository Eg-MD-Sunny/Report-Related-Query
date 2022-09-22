--"Please share the current customers count of Super Regular and Dead states and their Complete and cancelled orders count (life time).
--Output column : Customer State Name, Order State Name, Customer Count, Order Count
--Sort ""CustomerStateName"" Column By Z to A and ""OrderStateName"" A to Z"

Select  dbo.GetEnumName('CustomerState', CustomerState)[CustomerStateName],
		dbo.GetEnumName('OrderStatus' , OrderStatus ) [OrderStateName],
		Count(distinct(c.id)) [CustomerCount],
		Count(distinct(o.id)) [OrderCount]

from [Order] o
join Customer c on c.Id = o.Id 

where c.CustomerState in (70,90)
and o.OrderStatus in (30,40)

Group by dbo.GetEnumName('CustomerState', CustomerState),
		 dbo.GetEnumName('OrderStatus' , OrderStatus )

Order By 1 desc , 2 asc
