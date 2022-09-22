

---Monthwise Active Employee Salary
SELECT c.id CustomerID
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE) JoinedOnOn
,ac.accounthead
,SUM(t.Amount) Amount
FROM accounting.account ac
JOIN accounting.txn t ON t.accountid = ac.id
JOIN accounting.event ev ON ev.id = t.eventid
JOIN customer c ON c.customerguid = ac.[owner]
JOIN Employee e ON c.Id = e.Id
JOIN Designation da ON e.DesignationId = da.Id
WHERE Cast(dbo.tobdt([When]) AS DATE) >= '2022-06-01'
AND Cast(dbo.tobdt([When]) AS DATE) < '2022-07-30'
AND ac.accounthead = 'Salary'
AND Memo NOT LIKE 'Salary paid on%'
AND e.BadgeId = 3200
GROUP BY c.id
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE)
,ac.accounthead


---Daywise Active Employee Salary
SELECT Cast(dbo.tobdt([When]) AS DATE),c.id CustomerID
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE) JoinedOnOn
,ac.accounthead
,SUM(t.Amount) Amount
FROM accounting.account ac
JOIN accounting.txn t ON t.accountid = ac.id
JOIN accounting.event ev ON ev.id = t.eventid
JOIN customer c ON c.customerguid = ac.[owner]
JOIN Employee e ON c.Id = e.Id
JOIN Designation da ON e.DesignationId = da.Id
WHERE Cast(dbo.tobdt([When]) AS DATE) >= '2022-08-01'
AND Cast(dbo.tobdt([When]) AS DATE) < '2022-09-01'
AND ac.accounthead = 'Salary'
AND Memo NOT LIKE 'Salary paid on%'
AND e.BadgeId = 4419
--AND e.BadgeId = 5107
GROUP BY c.id
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE),
Cast(dbo.tobdt([When]) AS DATE)
,ac.accounthead



--- Terminated Employee Salary Balance
SET ANSI_WARNINGS OFF
DECLARE @StartDate date = '2021-08-01';
DECLARE @EndDate date = '2021-09-01';
DECLARE @RunTime INT;
DECLARE @TerminatedEmployee TABLE (
ID INT IDENTITY(1, 1) PRIMARY KEY
,EmployeeID INT
,TerminatedOn DATE
);
DECLARE @TerminatedEmployeeMoneyBalance TABLE (
CustomerID INT
,BadgeID INT
,FullName NVARCHAR(64)
,DesignationName NVARCHAR(64)
,JoinedOn DATE
,TerminatedOn DATE
,AccountThead NVARCHAR(64)
,MoneyBalance INT
);
INSERT INTO @TerminatedEmployee
SELECT e.Id EmployeeID
,Cast(dbo.tobdt(e.TerminatedOn) AS DATE) TerminatedOn
FROM Employee e
WHERE e.TerminatedOn IS NOT NULL
AND Cast(dbo.tobdt(e.TerminatedOn) AS DATE) >= @StartDate
AND Cast(dbo.tobdt(e.TerminatedOn) AS DATE) < @EndDate
--select * from @TerminatedEmployee
SELECT @RunTime = count(ID)
FROM @TerminatedEmployee;
WHILE @RunTime >= 1
BEGIN
INSERT INTO @TerminatedEmployeeMoneyBalance
SELECT c.id CustomerID
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE) JoinedOnOn
,Cast(dbo.tobdt(e.TerminatedOn) AS DATE) TerminatedOn
,ac.accounthead
,SUM(t.Amount) Amount
FROM accounting.account ac
JOIN accounting.txn t ON t.accountid = ac.id
JOIN accounting.event ev ON ev.id = t.eventid
JOIN customer c ON c.customerguid = ac.[owner]
JOIN Employee e ON c.Id = e.Id
JOIN Designation da ON e.DesignationId = da.Id
WHERE Cast(dbo.tobdt([When]) AS DATE) >= @StartDate
AND Cast(dbo.tobdt([When]) AS DATE) <= (
SELECT TerminatedOn
FROM @TerminatedEmployee
WHERE ID = @RunTime
)
AND ac.accounthead = 'Salary'
AND Memo NOT LIKE 'Salary paid on%'
AND e.TerminatedOn IS NOT NULL
AND e.Id = (

SELECT EmployeeID
FROM @TerminatedEmployee
WHERE ID = @RunTime
)
GROUP BY c.id
,e.BadgeId
,e.FullName
,da.DesignationName
,Cast(dbo.tobdt(e.JoinedOn) AS DATE)
,Cast(dbo.tobdt(e.TerminatedOn) AS DATE)
,ac.accounthead
SET @RunTime = @RunTime - 1;
END
SELECT *
FROM @TerminatedEmployeeMoneyBalance
ORDER BY 6
