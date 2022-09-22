--07. Please share top 20 returned products from 25th Mar to 31st Mar 2022. Reconciled Orders only Output Columns
--   # ProductVarientID, 
--   # ProductName, 
--   # ReturnedQty.
--   # Retumedamount (MRP)
--   # Sort ReturnedQty Column by Z to A


select top 20 Count (distinct s.OrderId) [Orderid], --Extra
		pv.id [PVID],
		pv.Name [Product],
		Count(pv.id) [ReturnQty],
		Sum(pv.Mrp) [ReturnedAmount]
		

from thing t
join ThingRequest tr on t.id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-25 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsReturned = 1

Group By pv.id,
		 pv.Name

Order By ReturnQty desc


