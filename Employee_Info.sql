SELECT E.ID [Employee ID],
       E.FullName [Name],
	   E.DesignationId [Designation ID],
	   D.DesignationName [Designation Name],
	   EA.FingerPrintedOn [Finger Print Time]
	   
FROM Employee E
JOIN Designation D ON D.Id = E.DesignationId 
JOIN EmployeeAttendance EA ON E.Id = EA.EmployeeId 

WHERE FingerPrintedOn >= '202-02-01 00:00 +06:00' 
AND FingerPrintedOn < '2022-02-02 00:00 +06:00'
AND d.DesignationName like '%Jr Data Analyst%'
AND e.TerminatedOn is not null

--select TOP 10 *
--from  EmployeeAttendance EA







