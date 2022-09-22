select w.MetropolitanAreaId														[MID],
	   w.Id																		[WarehouseID],
	   w.Name																	[Warehouse],
	   pv.Id																	[PVID],
	   pv.Name																	[Product],
	   Count(tr.SalePrice)														[SaleQty],
	   Sum(tr.Mrp)																[MRP], 
	   Sum(t.CostPrice)															[CostPrice],
	   Sum(tr.SalePrice)														[SalePrice],
	   Sum(tr.SalePrice)-Sum(t.CostPrice)										[Profit],
	   (Sum(tr.SalePrice)-Sum(t.CostPrice))/Sum(t.CostPrice)					[CostMargin/ROI(ReturnOfInvestment)],
	   (Sum(tr.SalePrice)-Sum(t.CostPrice))/Sum(tr.SalePrice)					[SaleMargin/GP(GrossProfit)],
	   Format((Sum(tr.SalePrice)-Sum(t.CostPrice))/Sum(tr.SalePrice),'P')		[AnotherWay/SaleMargin/GP(GrossProfit)/ProfitMargin],
	   Sum(tr.SalePrice)														[Revenue/TotalSaleAmount],
	   (Sum(tr.Mrp)-Sum(tr.ListPrice))											[Offer],
	   (Sum(tr.Mrp)-Sum(tr.ListPrice))*100.00/Sum(tr.Mrp)						[OfferPercentage],
	   (Sum(tr.ListPrice)-Sum(tr.SalePrice))									[Discount],
	   (Sum(tr.ListPrice)-Sum(tr.SalePrice))*100.00/Sum(tr.ListPrice)			[DiscountPercentage],
	   Concat(Convert(decimal(10,2),(Sum(tr.ListPrice)-Sum(tr.SalePrice))*100.00/Sum(tr.ListPrice)),'%')		[DiscountPercentage],
	   Format((Sum(tr.ListPrice)-Sum(tr.SalePrice))/Sum(tr.ListPrice),'P')		[AnotherWay/DiscountPercentage],
	   (sum(tr.SalePrice) /count(distinct(s.OrderId)))						    [CartSize/BusketSize]


	   
	  -- Concat(Convert(decimal(10,2),((Sum(tr.ListPrice)-Sum(tr.SalePrice))*100.00/Cast(Sum(tr.ListPrice))as float),'%') 
      -- Concat(Convert(decimal(10,2),(Sum(tr.ListPrice)-Sum(tr.SalePrice)*100.00/Cast((Sum(tr.ListPrice))as float),'%')))
	  -- Concat(Convert(decimal(10,2),(Sum(tr.ListPrice)-Sum(tr.SalePrice))*100.00/Cast((Sum(tr.ListPrice))as float)),'%')
	   

from thing t
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on tr.ShipmentId = s.Id 
join ProductVariant pv on tr.ProductVariantId = pv.Id 
join Warehouse w on w.id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-04-07 00:00 +06:00'
and s.ReconciledOn < '2022-04-08 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and s.ShipmentStatus not in (1,9,10)
and tr.SalePrice > 0

group by w.MetropolitanAreaId,
	     w.Id,
	     w.Name,
	     pv.Id,
	     pv.Name

