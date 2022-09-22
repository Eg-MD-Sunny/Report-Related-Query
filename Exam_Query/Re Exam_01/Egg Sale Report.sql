--06. Please share a sales report for special offers egg 12 pes and regular chicken egg layer 12 pes in Mar 22 Reconciled items only Output Coulmn-
--   # Date, 
--   # product name.
--   # Customer Count
--   # OrderQty 
--   # Sales amount. 
--   # proft 
--   # Sort date column by A to Z

select  Cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		pv.Name [Product],
		Count(o.CustomerId) [CustomerQty],
		Count(distinct o.id) [OrderQty],
		Sum(tr.SalePrice) [SaleAmount],
		Sum(tr.SalePrice) - Sum(t.CostPrice) [Profit]

from ThingRequest tr
join thing t on t.Id = tr.AssignedThingId 
join shipment s on s.Id = tr.ShipmentId 
join [Order] o on o.Id = s.OrderId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-22 00:00 +06:00'
and s.ReconciledOn < '2022-03-23 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pv.id in (24048,4248)

Group By Cast(dbo.ToBdt(s.ReconciledOn)as date),
		 pv.Name

Order By Date asc





