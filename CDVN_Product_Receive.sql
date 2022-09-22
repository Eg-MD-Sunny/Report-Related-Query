select cast(dbo.tobdt(po.CompletedOn) as date) ReceivedDate,
       t.purchaseorderid POID,
       t.productvariantid PVID,
	   pv.name Product,
       v.id VendorID,
	   v.name VendorName,
       count(*) RequestedQuantity,
       sum(case when t.costprice is not null then 1 else 0 end) ReceivedQuantity

from thing t
join purchaseorder po on po.id=t.purchaseorderid
join productvariant pv on pv.id=t.ProductVariantId
join ProductVariantVendorMapping pvvm on Pv.id = pvvm.ProductVariantId
---join product p on p.id=pv.productid
join vendor v on v.id=pvvm.vendorid

where cast(dbo.tobdt(po.CompletedOn) as date)>='2022-02-02'
and cast(dbo.tobdt(po.CompletedOn) as date)<'2022-02-09'
and po.purchaseorderstatusid not in (3)
and po.CompletedOn is not null
and pv.Id in (23065,9562,22392,13688,24478,23069,13686,23071,13695,22222,22318,23061)

group by t.purchaseorderid,
         t.productvariantid,
		 cast(dbo.tobdt(po.CompletedOn) as date),
         v.id,
		 v.name,
		 pv.name
order by 2 asc