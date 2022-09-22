select BadgeId, FullName 
from Employee 

where BadgeId = 8005

select distinct tr.ProductVariantId,
	   pv.Name Product,
	   t.id , cast(dbo.ToBdt (t.PriceSetOn)AS datetime) ,
	   (case when w.MetropolitanAreaId=2 then t.CostPrice else null end) CTGCostPrice, 
	   tr.Mrp,
	   (case when w.MetropolitanAreaId=2 then tr.ListPrice else null end) CTGListPrice
	  
from [order] o 
join shipment s on s.OrderId=o.Id
join ThingRequest tr on tr.ShipmentId=s.Id
join ProductVariant pv on pv.Id=tr.ProductVariantId
join thing t on t.id=tr.AssignedThingId
join warehouse w on w.id=s.WarehouseId
where cast(dbo.tobdt(o.CreatedOnUtc) as Date)='2021-10-27'
and tr.productvariantid in (19987)
and w.MetropolitanAreaId = 2
group by tr.ProductVariantId,pv.Name,(case when w.MetropolitanAreaId=1 then t.CostPrice else null end), 
	   (case when w.MetropolitanAreaId=2 then t.CostPrice else null end), 
	   (case when w.MetropolitanAreaId=2 then tr.ListPrice else null end),
	    t.id,cast(dbo.ToBdt (t.PriceSetOn)AS datetime),
		tr.Mrp




		--Current Discount Codes

Select d.name Name,
       d.CouponCode,
	   d.DiscountPercentage,
	   d.StartDateUtc,
	   d.EndDateUtc

from Discount d

where (cast(EndDateUtc as date) >=getdate()  or EndDateUtc is null)
and CouponCode is not null

order by 1 desc