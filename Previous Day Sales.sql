select TOP 25 cast(dbo.toBdt(s.ReconciledOn)as date)[Date],
     --s.WarehouseId [Warehouse ID],
       tr.ProductVariantId [PVID],
	   pv.Name [Product],
	   sum(tr.saleprice)[SaleAmount],
	   Count(tr.SalePrice) [Sale Qty]

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
join warehouse w on w.id = s.warehouseid

where s.ReconciledOn is not null
and s.ReconciledOn>= '2022-02-23 00:00 +06:00'
and s.ReconciledOn< '2022-02-24 00:00 +06:00'
and ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and w.metropolitanAreaId = 2

group by tr.ProductVariantId,
         pv.Name,
		 cast(dbo.toBdt(s.ReconciledOn)as date)
		 --s.WarehouseId
order by 5 desc


--SELECT PV.Id [PVID]
--FROM ProductVariant PV
--WHERE PV.Name LIKE '%Apple Jujube (Apple Kul Boroi) 500 gm%'
