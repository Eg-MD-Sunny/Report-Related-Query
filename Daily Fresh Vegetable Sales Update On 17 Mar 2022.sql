
--Report Time 12:01 am

--Daily Fresh Vegetables

---Dhaka-----------------1
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=1
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC


--Chattagram----------------2
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=2
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC


--Jashore----------------------3
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=3
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC



--Khulna----------------------4
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=4
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC



--Sylhet-----------------5
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=5
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC


--Rajshahi--------------------6
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=7
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC



--Gazipur--------------------7
SELECT pv.id,pv.Name,pv.weight Weights,COUNT(*) Quantity 
FROM ThingRequest tr
JOIN Shipment s ON s.id=tr.ShipmentID
JOIN ProductVariant pv ON pv.id=tr.ProductVariantID
JOIN ProductVariantCategoryMapping pvcm ON pvcm.ProductVariantID=pv.id
JOIN Warehouse W ON W.id=S.WarehouseID
WHERE ReconciledOn IS NOT NULL
	AND s.ReconciledOn >= '2022-03-20 00:00 +6:00' 
	AND s.ReconciledOn < '2022-03-21 00:00 +6:00'
	AND ShipmentStatus NOT IN (1,9,10)
AND pvcm.CategoryId=12
AND IsReturned=0
AND IsCancelled=0
AND HasFailedBeforeDispatch=0
AND IsMissingAfterDispatch=0
AND MetropolitanAreaID=6
GROUP BY pv.id,pv.Name,pv.weight
ORDER BY 4 DESC