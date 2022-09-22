
--Daily Order Fulfilment
-- Fulfilment--------------------1
-- Note : Ontime Delivered % = (Ontime Delivery + TwoHourEarlyDelivery) / TotalShipment

SELECT w.id WID,w.Name Warehouse,
(CASE 
WHEN w.id IN (1,2,4,7,11,12,16,26,27,45) THEN 'West' 
WHEN w.id IN (22,23,24) THEN 'CTG' 
WHEN w.id IN (25) THEN ' JSR' 
WHEN w.id IN (37) THEN '  Khulna' 
WHEN w.id IN (40) THEN '   Sylhet' 
WHEN w.id IN (44) THEN '     Rajshahi'
WHEN w.id IN (48) THEN '      Gazipur'
ELSE 'East'  END) Location,
CONCAT( CONVERT(decimal(10,3),(COUNT(*)-SUM(CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END))*100.00/CAST(COUNT(*) AS float)),'%' ) FulfilledPercentage,
COUNT(DISTINCT s.id) ShipmentDelivered,
CONCAT( CONVERT(decimal(10,3),(COUNT(DISTINCT ( CASE WHEN ( EstimatedDeliveredOn>=(DATEADD(hour,-2, DeliveryWindowStart)) AND EstimatedDeliveredOn<=DeliveryWindowEnd ) THEN s.id END ) ))*100.00/CAST(COUNT(DISTINCT s.id) AS float)),'%') [OntimeDelivery%]
--Round ( (COUNT (DISTINCT s.id) * ( COUNT (*) - SUM ( CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END ) ) / CAST ( COUNT (*) AS float ) ) , 0 ) Scores

FROM ThingRequest tr
JOIN Shipment s ON tr.ShipmentID=s.id
JOIN Warehouse w ON w.id=s.WarehouseID

WHERE ReconciledOn IS NOT NULL
AND ReconciledOn between '2022-03-20 05:00:00.000  +6:00' 
AND						'2022-03-21 00:30:00.000  +6:00'

GROUP BY w.id,w.Name
ORDER BY 3 DESC, 1 ASC



--Delivery Efficiency (Row Data)----------------------2
SELECT w.id WID,w.Name Warehouse,
(CASE 
WHEN w.id IN (1,2,4,7,11,12,16,26,27,45) THEN 'West' 
WHEN w.id IN (22,23,24) THEN 'CTG' 
WHEN w.id IN (25) THEN ' JSR' 
WHEN w.id IN (37) THEN '  Khulna' 
WHEN w.id IN (40) THEN '   Sylhet' 
WHEN w.id IN (44) THEN '     Rajshahi'
WHEN w.id IN (48) THEN '      Gazipur'
ELSE 'East'  END) Location,
AVg (DATEDIFF(minute,CAST (dbo.ToBdt(ss.CreatedOn) AS smalldatetime), CAST (dbo.ToBdt(s.EstimatedDeliveredOn )AS smalldatetime)))DeliveryEfficiency

FROM Shipment s 
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN ShipmentStateTransition ss ON  ss.ShipmentID=s.id

WHERE ReconciledOn IS NOT NULL
AND EstimatedDeliveredOn IS NOT NULL
AND ReconciledOn between '2022-03-20 05:00:00.000  +6:00' 
AND						'2022-03-21 00:30:00.000  +6:00'
AND ss.TriggeringAction=6

GROUP BY w.id,w.Name
ORDER BY 3 DESC, 1 ASC



--50tk+ Profit Shipment (Row Data)-----------------3

SELECT  w.id WID, w.Name Warehouse,
	    (CASE  
		WHEN w.id IN (1,2,4,7,11,12,16,26,27,45) THEN 'West' 
		WHEN w.id IN (22,23,24) THEN 'CTG' 
		WHEN w.id IN (25) THEN ' JSR'
		WHEN w.id IN (37) THEN ' KH'
		WHEN w.id IN (40) THEN ' SY'
		WHEN w.id IN (44) THEN ' RJ'
		WHEN w.id IN (48) THEN ' GZ'
		ELSE 'East' END ) Location,
		( s.id ) ShipmentDelivered,
		(SUM ( SalePrice ) - SUM( CostPrice ) )Profit
FROM ThingRequest tr
JOIN Shipment s ON tr.ShipmentID=s.id
JOIN Thing t ON tr.AssignedThingID=t.id
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN Warehouse w ON w.id=s.WarehouseID

WHERE ReconciledOn IS NOT NULL
AND ReconciledOn between '2022-03-20 05:00:00.000  +6:00' AND  '2022-03-21 00:30:00.000  +6:00'
AND ShipmentStatus NOT IN (1,9,10)
AND SalePrice>0
AND	IsReturned = 0
AND	tr.IsCancelled = 0
AND	tr.HasFailedBeforeDispatch = 0
AND	tr.IsMissingAfterDispatch = 0

GROUP BY w.id,w.Name,
        (CASE 
		 WHEN w.id IN (1,2,4,7,11,12,15,16,21,26,27,45) THEN 'West' 
         WHEN w.id IN (22,23,24) THEN 'CTG' 
         WHEN w.id IN (25) THEN ' JSR'
		 WHEN w.id IN (37) THEN ' KH'
		 WHEN w.id IN (40) THEN ' SY'
		 WHEN w.id IN (44) THEN ' RJ'
		 WHEN w.id IN (48) THEN ' GZ'
         ELSE 'East' END ),
		 ( s.id )
HAVING (SUM ( SalePrice ) - SUM( CostPrice ) )  >= 50
ORDER BY 3 DESC, 1 ASC


/*
SELECT w.id WID,w.Name Warehouse,
	(CASE WHEN w.id IN (1,2,4,7,11,12,15,16,21) THEN 'West' ELSE 'East' END) Location,
	CONCAT(
		CONVERT(decimal(10,3),(COUNT(*)-SUM(CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END))*100.00/CAST(COUNT(*) AS float)),'%'
		  ) FulfilledPercentage,
	COUNT(DISTINCT s.id) ShipmentDelivered, 
	Round ( (COUNT (DISTINCT s.id) * ( COUNT (*) - SUM ( CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END ) ) / CAST ( COUNT (*) AS float ) ) , 0 ) Scores

FROM Shipment s
	JOIN Warehouse w ON w.id=s.WarehouseID
	JOIN ThingRequest tr ON tr.ShipmentID=s.id
WHERE	ReconciledOn IS NOT NULL
	AND CAST(ReconciledOn AS datetime) between '2021-05-11 05:00:00.000' AND  '2021-05-05 01:00:00.000'
GROUP BY w.id,w.Name
ORDER BY 3 DESC, 1 ASC

--		SELECT getdate()
--		SELECT top 10 ReconciledOn FROM Shipment ORDER BY 1 DESC

SELECT w.id WID,w.Name Warehouse,
(CASE WHEN w.id IN (1,2,4,7,11,12,15,16,21) THEN 'West' ELSE 'East' END) Location,
CONCAT(
CONVERT(decimal(10,3),(COUNT(*)-SUM(CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END))*100.00/CAST(COUNT(*) AS float)),'%') FulfilledPercentage,
COUNT(DISTINCT s.id) ShipmentDelivered, 
Round((COUNT(DISTINCT s.id)*(COUNT(*)-SUM(CASE WHEN tr.HasFailedBeforeDispatch=1 THEN 1 ELSE 0 END))/CAST(COUNT(*) AS float)),0) Scores
FROM Shipment s
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN ThingRequest tr ON tr.ShipmentID=s.id
WHERE ReconciledOn IS NOT NULL
AND CAST(ReconciledOn AS DATE) = '2021-03-08'
GROUP BY w.id,w.Name
ORDER BY 3 DESC, 1 ASC

*/