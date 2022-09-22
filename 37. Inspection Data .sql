
--01.Missing Things (No Change)
SELECT CAST(dbo.ToBdt(tt.CreatedOn) AS smalldatetime) ReportedAt, w.Name Warehouse , pv.id PVID, pv.Name ProductName,  COUNT(*) QTY, AVG(t.CostPrice) Cost, SUM(t.CostPrice) Total, dbo.tsn(tt.FromState) PreviousState,dbo.Tsn(tt.ToState) ToState, CONCAT('CDBD ',e.BadgeId,' ',e.FullName) ReportedBy,
(CASE WHEN CatP.ProductVariantID=pv.id THEN 'Category P' ELSE 'Non-Perishable' END) Category
FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
--AND pv.ShelfType IN (5,9)
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
AND tt.ToState IN (16,32)
--AND pv.Name like '%Mango%'
--AND pv.ShelfType=5
GROUP BY CAST(dbo.ToBdt(tt.CreatedOn) AS smalldatetime), w.Name , pv.id , pv.Name , dbo.tsn(tt.FromState),dbo.Tsn(tt.ToState), CONCAT('CDBD ',e.BadgeId,' ',e.FullName), CatP.ProductVariantID, (CASE WHEN CatP.ProductVariantID=pv.id THEN 'Category P' ELSE 'Non-Perishable' END)
ORDER BY 1 ASC


--02.Inspection SUMmary- (perishable- missing)
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
  AND pv.ShelfType  IN (5,9) 
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
--AND tt.ToState IN (32) -- For Damage
AND tt.ToState IN (16) -- For Missing

GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--03.Inspection SUMmary- (perishable- Damage)
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
  AND pv.ShelfType  IN (5,9) 
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
AND tt.ToState IN (32) -- For Damage
--AND tt.ToState IN (16) -- For Missing

GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC


--04.Inspection SUMmary- (perishable- InIntakeProcessingZone)
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
  AND pv.ShelfType  IN (5,9) 
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
AND tt.FromState IN (2) --For InIntakeProcessingZone
AND tt.ToState IN (32) -- For Damage
--AND tt.ToState IN (16) -- For Missing

GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--05.Inspection SUMmary- (non-perishable-Missing AvailableInShelf )--Check
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value
 
FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
	AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
	AND pv.ShelfType NOT IN (5,9)
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
--AND tt.ToState IN (32) -- For Damage
AND tt.ToState IN (16) -- For Missing
 
GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--06.Inspection SUMmary- (non-perishable-FlaggedMissingInShel )
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
  AND pv.ShelfType NOT IN (5,9) 
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
--AND tt.ToState IN (32) -- For Damage
AND tt.ToState IN (16) -- For Missing

GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--07.Inspection SUMmary- (non-perishable-HeldInShelfForLocal )
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
  AND pv.ShelfType NOT IN (5,9) 
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
--AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
--AND tt.ToState IN (32) -- For Damage
AND tt.ToState IN (16) -- For Missing

GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--Inspection SUMmary_(Non-Perishable-Transferzone))----------------8
-- 08.InTransferZone SUMmary---8
SELECT  w.id WarehouseID,w.Name Warehouse , COUNT(*) ItemQuantity, SUM(t.CostPrice) Value
FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN (SELECT pv.Id ProductVariantID FROM ProductVariant pv WHERE pv.ShelfType IN (5,9)) CatP ON CatP.ProductVariantID=pv.Id
WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
AND pv.ShelfType NOT IN (5,9)
--AND CAST(dbo.ToBdt(tt.CreatedOn) AS Date) < '2021-01-15'
AND tt.FromState IN (1099511627776) -- InTransferZoneWithShelfAssignment
--AND tt.FromState IN (512,1024) --FlaggedMissingInShelf & FalggedDamageInShelf
--AND tt.FromState IN (256,34359738368) --AvailableInShelf & ExcessAvailableInShelf
--AND tt.FromState IN (8192) --HeldInShelfForLocal
--AND tt.FromState IN (2) --For InIntakeProcessingZone
--AND tt.ToState IN (32) -- For Damage
AND tt.ToState IN (16) -- For Missing
 
GROUP BY  w.Name ,w.Id
ORDER BY 1 ASC

--09.Zone Wise Non-perishable Damage Report- SUMmary--Dubble
SELECT CAST(dbo.ToBdt(tt.CreatedOn) AS date) ReportedAt,m.Name City,w2.Name SourcingWarehouse,
w.Name Warehouse , pv.id PVID, pv.Name ProductName, COUNT(*) QTY, AVG(t.CostPrice) Cost, SUM(t.CostPrice) Total,
dbo.tsn (tt.FromState) PreviousState,dbo.tsn (tt.ToState) ToState,
CONCAT('CDBD ',e.BadgeId,' ',e.FullName) ReportedBy,d.DesignationName

FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
JOIN Designation d ON d.id=e.DesignationID
JOIN MetropolitanArea m ON m.id=w.MetropolitanAreaID
JOIN Warehouse w2 ON w2.id=w.SourcesNonPerishablesFromWarehouseID

WHERE tt.CreatedOn> ='2022-02-23 00:00 +6:00'
AND tt.CreatedOn < '2022-02-24 00:00 +6:00'
AND tt.ToState IN (64)
AND pv.ShelfType NOT IN (5,9)
GROUP BY CAST(dbo.ToBdt(tt.CreatedOn) AS date), w.Name , pv.id , pv.Name ,
dbo.tsn (tt.FromState),dbo.tsn (tt.ToState),
CONCAT('CDBD ',e.BadgeId,' ',e.FullName),d.DesignationName,m.Name,w2.Name
ORDER BY 3 ASC, 8 DESC


--Inspection SUMmary_(Non-Perishable-Damage))----------10--Check
--10.Nonperishable damage SUMmary---

SELECT CAST(dbo.ToBdt(tt.CreatedOn) AS date) ReportedAt,w2.Name SourcingWarehouse,     
 COUNT(*) QTY, SUM(t.CostPrice) Total
 
FROM ThingTransaction tt
JOIN ThingEvent te ON te.ThingTransactionID=tt.id
JOIN Thing t ON t.id=te.ThingID
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Employee e ON tt.CreatedByCustomerID=e.Id
JOIN Warehouse w ON te.WarehouseID=w.Id
JOIN Designation d ON d.id=e.DesignationID
JOIN MetropolitanArea m ON m.id=w.MetropolitanAreaID
JOIN Warehouse w2 ON w2.id=w.SourcesNonPerishablesFromWarehouseID
 
WHERE tt.CreatedOn  >= '2022-02-23 00:00 +6:00'
AND tt.CreatedOn  < '2022-02-24 00:00 +6:00'
--CONCAT(CONVERT(VARCHAR, dbo.ToBdt ( getdate()-1 ), 23),' 00:00 +6:00')
AND tt.ToState IN (64)
AND pv.id NOT IN (5,9)


GROUP BY CAST(dbo.ToBdt(tt.CreatedOn) AS date) ,w2.Name
 
ORDER BY 2 ASC


--11.Shelving Pending --- All Data
SELECT CAST(dbo.ToBdt(t.LastActionOn) AS date) Date, w.id WarehouseID, W.Name WarehouseName,pv.id PVID,pv.Name ProductName, COUNT(*)AS Quantity,w2.Name SourcingWarehouseName
FROM Thing T
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Warehouse w ON w.id=t.WarehouseID
JOIN Warehouse w2 ON w2.id=w.SourcesNonPerishablesFromWarehouseID
WHERE T.FlagIsActive IS NOT NULL
AND CurrentState IN (dbo.TSV('InTransferZoneWithShelfAssignment'),dbo.TSV('InTransferZoneWithNoShelfAssigned'))
AND CAST(dbo.ToBdt(t.LastActionOn) AS date) != CAST(SWITCHOFFSET(getdate(),'+06:00') AS DATE)
--AND w.id=25
GROUP BY pv.id,pv.Name,w.id,w.Name,CAST(dbo.ToBdt(t.LastActionOn) AS date),w2.Name
ORDER BY 1 ASC, 2 ASC

--12.Shelving Pending --- SUMmary
SELECT CAST(dbo.ToBdt(t.LastActionOn) AS date) Date,w2.Name SourcingWarehouseName, W.Name WarehouseName, COUNT(DISTINCT pv.id) TotalPendingItem,COUNT(pv.id) TotalPendingQTY
FROM Thing T
JOIN ProductVariant pv ON pv.id=t.ProductVariantID
JOIN Warehouse w ON w.id=t.WarehouseID
JOIN Warehouse w2 ON w2.id=w.SourcesNonPerishablesFromWarehouseID
WHERE T.FlagIsActive IS NOT NULL
AND CurrentState IN (dbo.TSV('InTransferZoneWithShelfAssignment'),dbo.TSV('InTransferZoneWithNoShelfAssigned'))
AND CAST(dbo.ToBdt(t.LastActionOn) AS date)!= CAST(SWITCHOFFSET(getdate(),'+06:00') AS DATE)
--AND w.id=25
GROUP BY w.id,w.Name,CAST(dbo.ToBdt(t.LastActionOn) AS date),w2.Name
ORDER BY 1 ASC




/*

--Max-MIN Thing Id
SELECT
MAX(te.ThingID) Max_T,
MIN(te.ThingID) Min_T,
MAX(tt.Id) Max_TT,
MIN(tt.Id) Min_TT

FROM ThingEvent te
JOIN ThingTransaction tt ON tt.id=te.ThingTransactionID

WHERE tt.CreatedOn >='2022-02-23 00:00:00 +6:00'
AND tt.CreatedOn <'2022-02-24 00:00:01 +6:00'
AND tt.ToState IN (64)



AND te.ThingID <= 133245178 ----------Max_T
AND te.ThingID >= 45986616 -----------Min_T
AND tt.Id <= 206726603 -------------Max_TT
AND tt.Id >= 206487559 -------------Min_TT

*/