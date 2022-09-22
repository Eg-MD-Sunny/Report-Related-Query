/*Get this output for Jan2022 & Feb2022 (ReconciledOn) only for Customers who are employees of Chaldal.
(Only take those orders whose actual sales amount is greater than 2000/-)*/


select Distinct s.OrderId Orderid,
       o.customerid Customerid, 
	   sum(tr.SalePrice) TotalSales,
       sum(case when tr.IsCancelled=1 then tr.saleprice else 0 end) CancelledfromcartAmount,
       sum(case when tr.IsReturned=1 then tr.saleprice else 0 end) ReturnAmount,
       sum(case when tr.HasFailedBeforeDispatch=1 then tr.saleprice else 0 end) Failledbeforedispatch,
       sum(case when tr.IsMissingAfterDispatch=1 then tr.saleprice else 0 end) Missingafterdispatch,
       sum(tr.SalePrice)-(sum(case when tr.IsCancelled=1 then tr.saleprice else 0 end)+sum(case when tr.IsReturned=1 then tr.saleprice else 0 end)+sum(case when tr.HasFailedBeforeDispatch=1 then tr.saleprice else 0 end)+sum(case when tr.IsMissingAfterDispatch=1 then tr.saleprice else 0 end))  Actualsales

  --   --sum(case when tr.IsReturned=0 or tr.HasFailedBeforeDispatch=0 or tr.IsCancelled=1  or tr.IsMissingAfterDispatch=0 then tr.saleprice else Null end) ActualAmount
	 ----sum(case when tr.IsReturned=0 or tr.HasFailedBeforeDispatch=0 or tr.IsCancelled=0  or tr.IsMissingAfterDispatch=0 
	 --         then tr.saleprice 
		--	  else Null end) ActualAmount


from [order] o
Join shipment s on o.id=s.OrderId
Join ThingRequest tr on s.id=tr.ShipmentId
Join Employee e on o.CustomerId=e.id

where s.ReconciledOn >='2022-01-01  00:00:00  +6:00' 
and s.ReconciledOn <'2022-03-01  00:00:00  +6:00'

Group by s.OrderId,
         o.customerid

having (sum(tr.SalePrice) - (sum(case when tr.IsCancelled=1 then tr.saleprice else 0 end) + sum(case when tr.IsReturned=1 then tr.saleprice else 0 end) +
        sum(case when tr.HasFailedBeforeDispatch=1 then tr.saleprice else 0 end) + sum(case when tr.IsMissingAfterDispatch=1 then tr.saleprice else 0 end))) >2000

Order by 8 desc