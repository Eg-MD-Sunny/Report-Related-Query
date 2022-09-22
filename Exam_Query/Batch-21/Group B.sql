-- Need Customer state wise actual sales qty for perishable and non perishable
-- For Mar 2022
-- Take only those products whose selling price greater than 500
-- The Qty of perishable sales should be more than 500


select  dbo.GetEnumName('CustomerState',CustomerState) [CustomerStateName],
		Count(Case	When pv.ShelfType in (5,9) 
				then tr.SalePrice 
		 else null end
		) [Perishable Sales],
		Count(Case	When pv.ShelfType not in (5,9) 
				then tr.SalePrice 
		 else null end
		) [NonPerishable Sales],
		Count(tr.SalePrice) [TotalSaleQty]

from ThingRequest tr
join Shipment s on  s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join [Order] o on o.Id = s.OrderId 
join Customer c on c.Id = o.CustomerId 

where s.ReconciledOn is not null
and s.ReconciledOn >='2022-03-01 00:00 +06:00'
and s.ReconciledOn < '2022-04-01 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and tr.SalePrice > 500

group by dbo.GetEnumName('CustomerState',CustomerState)
having Count(Case	When pv.ShelfType in (5,9) 
				then tr.SalePrice 
		 else null end
		) > 500
Order by 4 desc

