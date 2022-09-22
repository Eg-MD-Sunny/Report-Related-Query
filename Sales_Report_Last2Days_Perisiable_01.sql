-----//Start Maximum & Minimum ThingID //----- 

select Max(tr.Id) [MaximumThingID],
       Min(tr.Id) [MinimumThingID]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-02-17 00:00 +06:00'
and s.ReconciledOn < '2022-02-19 00:00 +06:00'

-----//End Maximum & Minimum ThingID //----- 


select DateName(WEEKDAY,s.ReconciledOn)[Day],
	   DateName(Month,s.ReconciledOn)[Month],	
	   Cast(
			dbo.ToBdt(s.ReconciledOn) as date
		) [Date],
       w.MetropolitanAreaId [MetropolitanAreaID],
	   w.Id [WarehouseID],
	   w.Name [Warehouse],
	   pv.Id [PVID],
	   pv.Name [Product],
	   Count(tr.SalePrice) [SaleQTY],
	   Sum(tr.SalePrice) [TotalAmount],
	   (Sum(tr.SalePrice) - Sum(t.CostPrice)) [Profit],
	   (Case 
			When pv.ShelfType in (5)
				Then 'Perishable'
			When pv.ShelfType in (9)
				Then 'Frozen Perishable'
			Else Null End
	   ) [Category]
	   
from thing t
join ThingRequest tr on t.Id = tr.AssignedThingId
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join Warehouse w on w.Id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >='2022-02-17 00:00 +06:00'
and s.ReconciledOn < '2022-02-19 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and pv.ShelfType in (5,9)
and s.ShipmentStatus not in (1,9,10)
and tr.Id >= 72485870
and tr.Id <= 75164020

Group By DATEName(WEEKDAY,s.ReconciledOn),
		 DateName(Month,s.ReconciledOn),
        cast(
			dbo.ToBdt(s.ReconciledOn) as date
		),
         w.MetropolitanAreaId,
	     w.Id,
	     w.Name,
	     pv.Id,
	     pv.Name,
		 (Case 
			When pv.ShelfType in (5)
				Then 'Perishable'
			When pv.ShelfType in (9)
				Then 'Frozen Perishable'
			Else Null End
	     )
Order By 7 DESC