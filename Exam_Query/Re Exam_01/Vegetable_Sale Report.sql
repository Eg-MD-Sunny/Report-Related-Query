--04. Please share a sales report of vegetables from 25th Mar to 31st Mar 2022 Reconciled terns only Output Columns
--   # Data,
--   # Saleamount,
--   # SaleQty,
--   # sold weight in TON 
--   # Sort Sold wight in TON" column by Z to A

Select  Cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		Count(tr.SalePrice) [SaleQty],
		Sum(tr.SalePrice) [SaleAmount],
		Sum(pv.Weight / 1000) [Weigth/Ton]

From ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId
join ProductVariantCategoryMapping pvcm on pv.Id = pvcm.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-25 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pvcm.CategoryId = 12

Group by Cast(dbo.ToBdt(s.ReconciledOn)as date)

Order by [Weigth/Ton] desc 



