-- Stock Sales 
Select  
	(PV.ID) PVID, PV.Name ProductName,
	Count(PV.ID) SaleQuantity,
    sum(tr.SalePrice) SalePrice

From ThingRequest TR 
	Join Shipment S on S.id=Tr.ShipmentId
	join ProductVariant PV on Pv.id=tr.ProductVariantId
	

where s.ReconciledOn is not null
 and s.ReconciledOn >= '2021-12-01 00:00 +6:00'	
 and s.ReconciledOn < '2022-01-01 00:00 +6:00'	

	and tr.IsCancelled = 0
	and tr.IsReturned = 0
	and tr.IsMissingAfterDispatch = 0
	and tr.HasFailedBeforeDispatch = 0
	and s.ShipmentStatus not in (1,9,10)
	and pv.id in (5592,8323,5937,6842,13684,6228,13677,5923,6838,5929,13668,6227,6847)

	and s.WarehouseId in (37)
Group By 
	(PV.ID), PV.Name
Order By 3 desc


-- Actual Market Purchase (Bought Information)

SELECT		CAST(dbo.tobdt(tss.CreatedOn) as DATE) BoughtDate,w.name Warehouse,pv.Id PVID,pv.Name ProductName,
			count(*) ProductQTY,sum(t.costprice) Costprice
FROM		thingtransaction tss
	JOIN	thingevent te ON tss.id = te.thingtransactionid
	JOIN	thing t ON t.id = te.thingid
	JOIN	productvariant pv on pv.id = t.productvariantid
	join    warehouse w on w.id=te.WarehouseId
WHERE		tss.CreatedOn >= '2021-11-22 00:00 +6:00'	
	AND		tss.CreatedOn < '2021-12-23 00:00 +6:00'	
	AND		fromstate IN (262144, 536870912)
	AND		tostate IN ( 65536,16777216,268435456)

	and		t.CostPrice is not null
	and     te.WarehouseId in (37)
	and		pv.id in (

	            select ProductVariantId from ProductVariantCategoryMapping pvcm where categoryId in (12)

			)
GROUP BY	CAST(dbo.tobdt(tss.CreatedOn) as DATE),w.name,pv.Id, pv.Name
order by	1,3 asc

--select top 10 * from ThingEvent

/*
Select pv.id PVID, pv.name ProductName, case when c.id=12 then 'Vegetables' when c.id = 11 then 'Fruits' when c.id in (1262,1235) then 'Fish' when c.id=25 then 'Meat' when c.id=61 then 'Eggs' end Category
from ProductVariant pv 
join ProductVariantCategoryMapping pvcm on pvcm.ProductVariantId=pv.id
join Category c on c.id=pvcm.CategoryId
where c.id in (12,11,1262,1235,25,61)
and pv.Deleted=0
and pv.Published=1
*/