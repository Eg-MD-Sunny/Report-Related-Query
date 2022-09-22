--02. How many orders we had profit from list to 3rd April 2022? Reconciled terrs only Take Only Profitable Products Output Coulm -
--   # Date
--   # OrderQty
--   # total Profit
--   # Sort profit column by Z to A


Select	Cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		Count(Distinct s.OrderId) [OrderQty], 
		Sum(tr.SalePrice) - Sum(t.CostPrice) [Profit]

From ThingRequest tr
join thing t on t.id = tr.AssignedThingId 
join Shipment s on s.id = tr.ShipmentId 

Where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-04-03 00:00 +06:00'
and s.ReconciledOn < '2022-04-04 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)

Group By Cast(dbo.ToBdt(s.ReconciledOn)as date)

Having Sum(tr.SalePrice) < Sum(t.CostPrice)

Order By [Profit] desc



