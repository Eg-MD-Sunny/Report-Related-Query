--Need Actual sales report for perishable and non perishable.
--Take only those products which we had loss.
--Date range : 1st april to 7th april 2022


select  cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		sum(case   when pv.ShelfType in (5,9)
				then tr.SalePrice 
		else null end		
		) [PerishableSales],
		Sum(case   when pv.ShelfType not in (5,9)
				then tr.SalePrice 
		else null end		
		) [NonPerishableSales],
		Sum(tr.SalePrice) [TotalSales],
		Sum(case   when pv.ShelfType in (5,9)
				then t.CostPrice  
		else null end		
		) [PerishableCost],
		Sum(case   when pv.ShelfType not in (5,9)
				then t.CostPrice  
		else null end		
		) [NonPerishableCost],
		sum(t.CostPrice) [TotalCost],
		sum(t.CostPrice) - Sum(tr.SalePrice) [TotalLossAmount],
		Format((Sum(t.CostPrice) - sum(tr.SalePrice))/sum(t.CostPrice),'p') [% of Loss Amount]


from thing t 
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.id = tr.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-04-01 00:00 +06:00'
and s.ReconciledOn < '2022-04-08 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and (tr.SalePrice) < (t.CostPrice)

group by cast(dbo.ToBdt(s.ReconciledOn)as date)

order by 1 



