-- 3 Days AVG Sales Of Perishable

select  w.MetropolitanAreaId,
		s.WarehouseId,
		w.Name [Warehouse],
		tr.ProductVariantId [PVID], 
		pv.Name [Product], 
		(count(tr.SalePrice)/count(distinct cast(dbo.tobdt(s.reconciledon) as date))) AVG_Sales

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
join Warehouse w on w.id=s.WarehouseId

where  s.ReconciledOn is not null
and s.ReconciledOn>= '2022-02-26 00:00 +06:00'
and s.ReconciledOn< '2022-03-01 00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.ShelfType in (5,9)

group by w.MetropolitanAreaId,s.WarehouseId,w.Name,tr.ProductVariantId,pv.Name

--##############################################################################################################


--select count(distinct cast(dbo.tobdt(s.reconciledon) as date)) [Days_Count],
--       pv.Id [PVID],
--	   pv.Name [Product],
--	   count(tr.SalePrice) [QTY]

--from ThingRequest tr
--join Shipment s on s.id=tr.ShipmentId
--join ProductVariant pv on pv.id=tr.ProductVariantId

--where  s.ReconciledOn is not null
--and s.ReconciledOn>= '2022-02-01 00:00 +06:00'
--and s.ReconciledOn< '2022-02-08 00:00 +06:00'
--and s.ShipmentStatus not in (1,9,10)
--and IsCancelled=0
--and IsReturned=0
--and HasFailedBeforeDispatch=0
--and IsMissingAfterDispatch=0
--and pv.Id in (5592)

--group by pv.Id,
--	     pv.Name



--Warehouse Wise Adjustment

--select  w.id WarehouseId, 
--		w.name Warehouse,
--	    pv.id PVID,                        
--		pv.name ProductName,                                     
--	    (Count(*)/count(distinct cast(dbo.tobdt(EstimatedDeliveredOn) as date))) Adjust_Qty                                   
                       
                        
                        
--from  shipment s                        
--join thingrequest tr on tr.shipmentid=s.id                        
--join productvariant pv on pv.id=tr.productvariantid                        
--join Warehouse w on w.id=s.WarehouseId                
                        
--where EstimatedDeliveredOn is NOT NULL                        
--and tr.hasfailedbeforedispatch=1                                         
--and EstimatedDeliveredOn >= '2022-02-28 00:00 +6:00'                        
--and EstimatedDeliveredOn < '2022-03-01 00:00 +6:00'                        
                        
--group by w.id,w.Name, pv.id,pv.name           
--order by 1 ASC