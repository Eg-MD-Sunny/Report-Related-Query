------Daily Data After 12:00 PM

Select Cast(dbo.tobdt(reconciledon) as date) Date,
       Sum(tr.mrp) TotalMrp,
	   Sum(tr.saleprice) TotalSales,
	   Sum(tr.mrp)-Sum(tr.saleprice) TotalDiscount,
       CONCAT( CONVERT(decimal(10,3),(Sum(tr.mrp)-Sum(tr.saleprice))*100.00/CAST(Sum(tr.mrp) AS float)),'%') DiscountPercentage

From Shipment S
Join ThingRequest TR on S.id=Tr.ShipmentId

where s.ReconciledOn is not null
and reconciledon >= '2022-03-15 00:00:00 +06:00'
and reconciledon <'2022-03-16 00:00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0

group by Cast(dbo.tobdt(reconciledon) as date)
order by 1 desc