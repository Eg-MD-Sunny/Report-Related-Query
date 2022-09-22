--Market Purchase ( Bought Information )

SELECT  CAST(dbo.ToBdt(tss.CreatedOn) AS DATE) PurchaseDate,
        e.BadgeId,
		e.FullName,
		de.DesignationName,
        t.ProductVariantID ID,
		pv.Name Product,
		te.WarehouseID,
		w.Name WarehouseName,
		pv.Mrp AS MRP,
        COUNT(*) MarketPurchaseQuantity, 
        SUM(t.costprice) CostAmount,t.MarketPurchaseInvoiceId

FROM ThingTransaction tss 
JOIN ThingEvent te ON tss.id = te.ThingTransactionID 
JOIN Thing t ON t.id = te.ThingID 
JOIN ProductVariant pv ON pv.id = t.ProductVariantID
JOIN Warehouse w ON te.WarehouseID=w.Id
LEFT JOIN Employee e ON e.id=tss.CreatedByCustomerID
LEFT JOIN Designation de ON de.id=e.DesignationID

WHERE tss.CreatedOn >= '2022-04-26 00:00 +6:00'
AND tss.CreatedOn < '2022-04-27 00:00 +6:00'
AND FromState IN ( 262144, 536870912 ) 
AND ToState IN ( 65536,16777216,268435456 ) 
AND pv.deleted = 0 
AND t.CostPrice IS NOT NULL

GROUP BY e.BadgeId,
         e.FullName,
		 de.DesignationName,
		 t.ProductVariantID,
		 pv.Name,
		 pv.Mrp,
		 te.WarehouseID,
		 w.Name,
		 CAST(dbo.ToBdt(tss.CreatedOn) AS DATE),
		 t.MarketPurchaseInvoiceId

--ORDER BY 7 ASC,10 DESC

