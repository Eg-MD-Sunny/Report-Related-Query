--select top 10 *
--from Employee e
--22141


select s.WarehouseId,tr.ProductVariantId, pv.Name Product, count(tr.SalePrice) Sale_Quantity
from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
where dbo.ToBdt(s.DeliveryWindowEnd)>= '2021-11-05 00:00 +06:00'
and dbo.ToBdt(s.DeliveryWindowEnd)< '2021-11-06 00:00 +06:00'
and pv.id = 24478
and s.WarehouseId in (18,19)
group by tr.ProductVariantId,pv.Name,s.WarehouseId
