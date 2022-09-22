--select
--	CAST(dbo.ToBdt(Shipment.DeliveryWindowEnd) as date) DeliveryWindowEnd,
--	Thing.id ThingId,
--	ProductVariant.Id ProductVariantId,
--	ProductVariant.Name ProductVariantName,
--	COUNT(ThingRequest.SalePrice) SaleQTY,
--    COUNT(distinct ProductVariant.Id) UniquePVID,
--	SUM(ThingRequest.SalePrice) TotalSaleAmount,
--	(SUM(ThingRequest.SalePrice)-SUM(Thing.CostPrice)) Profit,
--	(Case when ProductVariant.ShelfType in (5,9) then 'Perishable' else 'Non-Perishable' end) Category
		
--from 
--	ThingRequest
--	join Shipment on ThingRequest.shipmentID=Shipment.Id
--	join Thing on Thing.Id=ThingRequest.AssignedThingId
--	join ProductVariant on ProductVariant.Id=ThingRequest.ProductVariantId
	
--where Shipment.orderid = 7754723

--group by  
--    CAST(dbo.ToBdt(Shipment.DeliveryWindowEnd) as date),
--	Thing.id,
--	ProductVariant.Id,
--	ProductVariant.Name,
--	(Case when ProductVariant.ShelfType in (5,9) then 'Perishable' else 'Non-Perishable' end)
--ORDER BY 2 ASC









-- Thing Wise Whole Checking

Select t.id,tt.id,dbo.TSN(FromState) FromState,
dbo.TSN(ToState) ToState,
dbo.GetEnumName('ThingAction',TriggeringAction) Action,
count(*) Quantity,CAST(dbo.tobdt(tt.CreatedOn) as datetime) Dates,pv.id,pv.name,dbo.GetEnumName('CreationEventType',CreationEventType) Events
,slf.Name,slf.Id

from thing t 
join ThingEvent te on te.ThingId=t.id
join ThingTransaction tt on tt.id=te.ThingTransactionId
join productvariant pv on pv.id=t.ProductVariantId
left join Shelf slf on te.ShelfId = slf.Id 
where t.id=119038452
group by t.id,tt.id,dbo.TSN(FromState) ,
dbo.TSN(ToState) ,
dbo.GetEnumName('ThingAction',TriggeringAction) ,
CAST(dbo.tobdt(tt.CreatedOn) as datetime),dbo.GetEnumName('CreationEventType',CreationEventType),pv.id,pv.name
,slf.Name,slf.Id
order by 7 asc

