select s.WarehouseId [Warehouse ID], 
       s.OrderId [OrderID],
	   e.BadgeId [CDBD],
	   d.DesignationName [DesignationName], 
	   e.FullName [Name],
	   s.ShipmentStatus [ShipmentStatus]

from CancelledShipmentAfterPickup csap
join Shipment s on s.Id = csap.Id 
join Warehouse w on w.Id = s.WarehouseId 
join employee e on e.id = w.ActionByCustomerId
join Designation d on d.Id = e.DesignationId 


where csap.CreatedOn >= '2022-02-11'
and csap.CreatedOn  < '2022-02-12'
and w.Id = 2



