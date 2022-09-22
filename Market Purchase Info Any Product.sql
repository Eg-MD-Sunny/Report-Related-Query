select w.id WID,
       w.name WarehouseName,
       pv.ID PVID,
       pv.name PVName,
	   PVAR.IsMarketPurchasable MarketPurchase


from ProductVariantAvailabilityRestriction PVAR
JOIN ProductVariant pv on pv.Id = PVAR.ProductVariantId 
join Warehouse w on w.id = PVAR.WarehouseId 

where PVAR.IsMarketPurchasable = 1
and pv.Id in (20124)

