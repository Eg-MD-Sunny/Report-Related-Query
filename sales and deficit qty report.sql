----Deficit Quantity

Select pv.id,pv.name, sum(df.dq) DeficitQuantity

from ProductVariant pv 
join (
Select po.id PurchaseOrderID,pv.id PVID,pv.name ProductName, de.DeficitQuantity DQ
from thing t
join productvariant pv on pv.id=t.ProductVariantId
join PurchaseOrder po on po.id=t.PurchaseOrderId
left join (select popv.PurchaseOrderId POID,popv.ProductVariantId PVID, sum(deficitQuantity) DeficitQuantity
from PurchaseOrderProductVariant popv
group by popv.PurchaseOrderId,popv.ProductVariantId) de on de.POID=po.id and de.PVID=pv.id
where cast(dbo.tobdt(po.createdon) as date)>='2021-10-25'
and cast(dbo.tobdt(po.createdon) as date)<'2021-10-26'
--and pv.ShelfType in (5,9)
group by pv.id,pv.name,po.id,de.DeficitQuantity) df on df.PVID=pv.Id
where pv.id=9917
group by pv.id,pv.name
order by 1 asc

--elect pv.vendorid,v.name from productvariantvendormapping pv  join vendor v on v.id=pv.vendorid  where pv.productvariantid = 26124

--Sale Report

Select	PV.ID PVID, PV.Name ProductName,Count(PV.ID) SaleQuantity, sum(tr.SalePrice) SalePrice
From ThingRequest TR
join	ProductVariant PV on Pv.id=tr.ProductVariantId
Join	Shipment S on S.id=Tr.ShipmentId
where reconciledon>= '2021-10-04 00:00 +06:00'
	and reconciledon< '2021-10-05 00:00 +06:00'
    and tr.IsCancelled = 0
	and		tr.IsReturned = 0
	and		tr.IsMissingAfterDispatch = 0
	and		tr.HasFailedBeforeDispatch = 0
	and		s.ShipmentStatus not in (1,9,10)
	and		pv.ShelfType in (5,9)
	and		s.ReconciledOn is not null
Group By	PV.ID, PV.Name
order by 3 desc



select top 1* from PurchaseOrderProductVariant
select top 1* from purchaseorder










select sum(popv.deficitQuantity),sum(popv.requestedquantity)

from PurchaseOrderProductVariant popv
join purchaseorder po on po.id=popv.purchaseorderid

where po.createdon >= '2021-12-25 00:00 +06:00'
and po.createdon < '2021-12-26 00:00 +06:00'
and popv.productvariantid=9917