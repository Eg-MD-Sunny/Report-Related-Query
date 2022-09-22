--"Find out the Customers who cancelled ""Vegetable"" Categories products in march 2022. (Reconciled Orders)
--Output column should have customerid,ordercount,cancelled qty and cancelled amount. Sort cancelledQty Column by Z to A"

select  o.customerId [CustomerId],
		Count(distinct(o.id)) [OrderCount],
		Count(pv.Id)[CancelledQty],
		Sum(tr.SalePrice) [CancelledAmount]


from ThingRequest tr 
join Shipment s on s.Id = tr.ShipmentId 
join [Order] o on o.Id = s.OrderId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join ProductVariantCategoryMapping pvcm on pv.Id = pvcm.ProductVariantId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-01 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 1
and s.ShipmentStatus not in (1,9,10)
and pvcm.CategoryId = 12

Group by o.customerId
Order by 3 desc


