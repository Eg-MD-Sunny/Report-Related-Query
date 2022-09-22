--"Find the bottom 10 most profitable products of Jan 2022. Take Only Profitable Products. (reconciled)
--Exlude gift items.
--Output column should have product variant id,productname,order qty, sale qty, profit amount "

select  top 10 pv.id [PVID],
		pv.Name [Product],
		Count(distinct(s.orderId))[OrderQty],
		Count(tr.SalePrice)[SaleQty],
		Sum(tr.SalePrice)-Sum(t.CostPrice) [ProfitAmount] 

from Thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >='2022-01-01 00:00 +06:00'
and s.ReconciledOn < '2022-02-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pv.Name not like '%Gift From Chaldal%'

Group by pv.id,
		 pv.Name

Having Sum(tr.SalePrice) > Sum(t.CostPrice)

Order by 5 asc

