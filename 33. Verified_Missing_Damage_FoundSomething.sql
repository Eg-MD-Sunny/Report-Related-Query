--Verified Missing---(Run All Query Run for Must 2 Days--Highest 3 Days)

-- Verified Audit--1

SELECT *
FROM (
	SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) VerifiedDate, w.id WarehouseID,
	SUM(CASE WHEN sal.actionperformed is null AND sal.ObservedQuantity IS NOT NULL THEN sal.ActualQuantity ELSE 0 END) VerifiedAudit
	FROM shelfauditLog sal 
	JOIN Employee e ON e.id=sal.CreatedByEmployeeId
	JOIN Designation de ON de.id=e.DesignationID
	JOIN Warehouse w ON w.id=e.WarehouseID
	WHERE sal.CreatedOn >= '2022-04-30 00:00 +6:00'
	AND  sal.CreatedOn < '2022-05-02 00:00 +6:00'
	AND de.DesignationName like '%store%'
	AND sal.ActionPerformed is null 
	AND sal.ObservedQuantity IS NOT NULL
	GROUP BY CAST(dbo.ToBdt(sal.CreatedOn) AS date), w.id
) dt1
PIVOT
(
	SUM(VerifiedAudit) for WarehouseID IN ([1], [2], [3], [4],[5],[6],[7],[8],[9],[11],[12],[14],[15],[16],[18],[19],[21],[22],[23],[24],[32],[26],[27],[37], [40], [41], [44], [48], [45], [49] )
) pt1
ORDER BY 1


-- Damage------2													

SELECT *
FROM (
	SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) DamageDate, w.id WarehouseID,
	SUM(CASE WHEN sal.actionperformed IN (6) THEN sal.ActionQuantity ELSE 0 END) Missing_Damage_ExpiredCOUNT
	FROM shelfauditLog sal 
	JOIN Employee e ON e.id=sal.CreatedByEmployeeId
	JOIN Designation de ON de.id=e.DesignationID
	JOIN Warehouse w ON w.id=e.WarehouseID
	WHERE sal.CreatedOn >= '2022-04-30 00:00 +6:00'
	AND  sal.CreatedOn < '2022-05-02 00:00 +6:00'
	AND de.DesignationName like '%store%'
	GROUP BY CAST(dbo.ToBdt(sal.CreatedOn) AS date), w.id
) dt1
PIVOT
(
	SUM(Missing_Damage_ExpiredCOUNT) for WarehouseID IN ([1], [2], [3], [4],[5],[6],[7],[8],[9],[11],[12],[14],[15],[16],[18],[19],[21],[22],[23],[24],[32],[26],[27],[37], [40], [41], [44], [48], [45], [49] )
) pt1
ORDER BY 1


-- Expired	--3															

SELECT *
FROM (
	SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) ExpiredDate, w.id WarehouseID,
	SUM(CASE WHEN sal.actionperformed IN (7) THEN sal.ActionQuantity ELSE 0 END) Missing_Damage_ExpiredCOUNT
	FROM shelfauditLog sal 
	JOIN Employee e ON e.id=sal.CreatedByEmployeeId
	JOIN Designation de ON de.id=e.DesignationID
	JOIN Warehouse w ON w.id=e.WarehouseID
	WHERE sal.CreatedOn >= '2022-04-30 00:00 +6:00'
	AND  sal.CreatedOn < '2022-05-02 00:00 +6:00'
	AND de.DesignationName like '%store%'
	GROUP BY CAST(dbo.ToBdt(sal.CreatedOn) AS date), w.id
) dt1
PIVOT
(
	SUM(Missing_Damage_ExpiredCOUNT) for WarehouseID IN ([1], [2], [3], [4],[5],[6],[7],[8],[9],[11],[12],[14],[15],[16],[18],[19],[21],[22],[23],[24],[32],[26],[27],[37], [40], [41], [44], [48], [45], [49] )
) pt1
ORDER BY 1


-- FoundNewProducts--4

SELECT *
FROM (
	SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) FoundNewDate, w.id WarehouseID,
	SUM(CASE WHEN sal.actionperformed IN (34) THEN sal.ActionQuantity ELSE 0 END) FoundNewProducts
	FROM shelfauditLog sal 
	JOIN Employee e ON e.id=sal.CreatedByEmployeeId
	JOIN Designation de ON de.id=e.DesignationID
	JOIN Warehouse w ON w.id=e.WarehouseID
	WHERE sal.CreatedOn >= '2022-04-30 00:00 +6:00'
	AND  sal.CreatedOn < '2022-05-02 00:00 +6:00'
	AND de.DesignationName like '%store%'
	GROUP BY CAST(dbo.ToBdt(sal.CreatedOn) AS date), w.id
) dt1
PIVOT
(
	SUM(FoundNewProducts) for WarehouseID IN ([1], [2], [3], [4],[5],[6],[7],[8],[9],[11],[12],[14],[15],[16],[18],[19],[21],[22],[23],[24],[32],[26],[27],[37], [40], [41], [44], [48], [45], [49] )
) pt1
ORDER BY 1



/*
-- Verified Audit

SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) Date,shelfid ShelfID,s.Name ShelfName,pv.id PVID,pv.Name Product,e.BadgeId,
e.FullName,designationName Designation,sal.ObservedQuantity,sal.ActualQuantity,s.WarehouseID,w.Name Warehouse
FROM shelfauditLog sal 
JOIN shelf s ON s.id=sal.ShelfId
JOIN ProductVariant pv ON pv.id=sal.ObservedProductVariantID
JOIN Employee e ON e.id=sal.CreatedByEmployeeId
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN Designation de ON de.id=e.DesignationID
WHERE sal.ActionPerformed is null 
AND sal.ObservedQuantity IS NOT NULL
AND de.DesignationName like '%store%'
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)>=CONVERT (DATE,(DATEADD(MONTH,-1,dbo.ToBdt(GETDATE()))))
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)<CONVERT (DATE,dbo.ToBdt(GETDATE()))
ORDER BY 11 ASC,1 ASC,6 ASC


----Missing

SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS smalldatetime) Auditedon,shelfid ShelfID,s.Name ShelfName,pv.id PVID,pv.Name Product,e.BadgeId,
e.FullName,designationName Designation,sal.ActualQuantity,sal.actionquantity ActionQuantity,sal.CorrectedQuantity,s.WarehouseID,w.Name Warehouse
FROM shelfauditLog sal 
JOIN shelf s ON s.id=sal.ShelfId
JOIN ProductVariant pv ON pv.id=sal.ObservedProductVariantID
--JOIN product p ON p.id=pv.productid
JOIN Employee e ON e.id=sal.CreatedByEmployeeId
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN Designation de ON de.id=e.DesignationID
WHERE sal.ActionPerformed=5
AND de.DesignationName like '%store%'
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)>=CONVERT (DATE,(DATEADD(MONTH,-1,dbo.ToBdt(GETDATE()))))
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)<CONVERT (DATE,dbo.ToBdt(GETDATE()))
ORDER BY 12 ASC,1 ASC,6 ASC

--- Damage

SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS smalldatetime) Auditedon,shelfid ShelfID,s.Name ShelfName,pv.id PVID,pv.Name Product,e.BadgeId,
e.FullName,designationName Designation,sal.ActualQuantity,sal.actionquantity ActionQuantity,sal.CorrectedQuantity,s.WarehouseID,w.Name Warehouse
FROM shelfauditLog sal 
JOIN shelf s ON s.id=sal.ShelfId
JOIN ProductVariant pv ON pv.id=sal.ObservedProductVariantID
--JOIN product p ON p.id=pv.productid
JOIN Employee e ON e.id=sal.CreatedByEmployeeId
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN Designation de ON de.id=e.DesignationID
WHERE sal.ActionPerformed=6
AND de.DesignationName like '%store%'
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)>=CONVERT (DATE,(DATEADD(DAY,-1,dbo.ToBdt(GETDATE()))))
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)<CONVERT (DATE,dbo.ToBdt(GETDATE()))
ORDER BY 12 ASC,1 ASC,6 ASC

---Found SomeThing

SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS smalldatetime) Auditedon,shelfid ShelfID,s.Name ShelfName,pv.id PVID,pv.Name Product,e.BadgeId,
e.FullName,designationName Designation,sal.ActualQuantity,sal.actionquantity ActionQuantity,sal.CorrectedQuantity,s.WarehouseID,w.Name Warehouse
FROM shelfauditLog sal 
JOIN shelf s ON s.id=sal.ShelfId
JOIN ProductVariant pv ON pv.id=sal.ObservedProductVariantID
--JOIN product p ON p.id=pv.productid
JOIN Employee e ON e.id=sal.CreatedByEmployeeId
JOIN Warehouse w ON w.id=s.WarehouseID
JOIN Designation de ON de.id=e.DesignationID
WHERE sal.ActionPerformed=34
AND de.DesignationName like '%store%'
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)>=CONVERT (DATE,(DATEADD(DAY,-1,dbo.ToBdt(GETDATE()))))
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)<CONVERT (DATE,dbo.ToBdt(GETDATE()))
ORDER BY 12 ASC,1 ASC,6 ASC


----SUMmary
/*
SELECT CAST(dbo.ToBdt(sal.CreatedOn) AS date) Auditedon, w.id, w.Name,
SUM(CASE WHEN sal.actionperformed is null AND sal.ObservedQuantity IS NOT NULL THEN sal.ActualQuantity ELSE 0 END) VerifiedAudit,
SUM(CASE WHEN sal.actionperformed IN (5,6,7) THEN sal.ActionQuantity ELSE 0 END) Missing_Damage_ExpiredCOUNT,
SUM(CASE WHEN sal.actionperformed IN (34) THEN sal.ActionQuantity ELSE 0 END) FoundNewProducts
FROM shelfauditLog sal 
JOIN Employee e ON e.id=sal.CreatedByEmployeeId
JOIN Designation de ON de.id=e.DesignationID
JOIN Warehouse w ON w.id=e.WarehouseID
WHERE CAST(dbo.ToBdt(sal.CreatedOn) AS date)>=CONVERT (DATE,(DATEADD(DAY,-1,dbo.ToBdt(GETDATE()))))
AND CAST(dbo.ToBdt(sal.CreatedOn) AS date)<CONVERT (DATE,dbo.ToBdt(GETDATE()))
AND de.DesignationName like '%store%'
GROUP BY CAST(dbo.ToBdt(sal.CreatedOn) AS date), w.id, w.Name
ORDER BY 2 ASC

([1], [2], [3], [4],[5],[6],[7],[8],[9],[11],[12],[14],[15],[16],[18],[19],[21],[22],[23],[24],[32],[26],[27],[37], [40], [41], [44], [48], [45], [49])

*/


*/