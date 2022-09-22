--03. Please share a sales report of "Ramadan" Category from 20th March to 31st March 2022 Reconciled to only 
--   # which products sales price greater than 1000/-  Output Coulmn are
--   # OrderaQty 
--   # SaleQty 
--   # SalesAmount


Select  Count(distinct s.OrderId) [OrderQty],
		Count(tr.SalePrice) [SaleQty],
		Sum(tr.SalePrice) [SalePrice]

From ThingRequest tr
join shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join ProductVariantCategoryMapping pvcm on pv.Id = pvcm.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >='2022-03-20 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and pvcm.CategoryId in (
		select c.Id [Category] 
		from Category c
		where c.Name like '%Ramadan%'
)

Having Sum(tr.SalePrice) > 1000





