--05. Please share the customers state wise current customers count and their placed order count lifetime). Show me 
--   # only those states whose customer count is greater than 30k,  Output column
--   # State Name
--   # Customer Count
--   # Order Count

Select  dbo.GetEnumName('CustomerState', CustomerState) [CustomerState],
		Count(distinct o.CustomerId) [TotalCustomer],
		Count(distinct (o.id)) [TotalOrder]

From [Order] o
Join customer c on c.id = o.CustomerId 

Group By dbo.GetEnumName('CustomerState',CustomerState)

Having Count(distinct o.CustomerId) > 30000