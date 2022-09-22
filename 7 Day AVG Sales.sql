--Previous 7 days avg sale qty

select  s.WarehouseId,w.Name warehosue,tr.ProductVariantId, pv.Name Product, (count(tr.SalePrice)/7) AVG_Sales
from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
join Warehouse w on w.id=s.WarehouseId
where s.ReconciledOn>= '2021-11-08 00:00 +06:00'
and s.ReconciledOn< '2021-11-15 00:00 +06:00'
and s.ReconciledOn is not null
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and tr.ProductVariantId in (
	select ProductVariantId from ProductVariantCategoryMapping 
	where CategoryId in (11)
)
group by tr.ProductVariantId,pv.Name,s.WarehouseId,w.Name