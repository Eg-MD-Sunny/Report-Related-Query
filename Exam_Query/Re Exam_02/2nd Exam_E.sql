--"Find the average sales amount of new customers of Feb 2022. (Reconciled Orders)
--There is a column named ""FirstCompletedOrderForCustomer"" in ""Order"" Table. 
--If its value is 1, then it's a new customer order, if its value is zero, it's an old customer order.
--Output columns should have countomer count, Order Count, total sales value, per customers average sales value."



select  Count(distinct(o.customerId)) [CustomerCount],
		Count(distinct(o.id)) [OrderCount],
		Sum(tr.SalePrice) [TotalSaleValue],
		Sum(tr.SalePrice)/Count(distinct(o.customerId)) [CustomerAvgSale] ---Per Customers Average Sales Value.

from ThingRequest tr 
join Shipment s on s.Id = tr.ShipmentId 
join [Order] o on o.Id = s.OrderId
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-01 00:00 +06:00'
and s.ReconciledOn < '2022-03-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and o.FirstCompletedOrderForCustomer = 1

