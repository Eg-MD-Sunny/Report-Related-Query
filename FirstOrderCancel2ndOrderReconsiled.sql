select 
	s.OrderId
	,count(s.Id)
	,count(case when s.OrderIdSuffix = 'A' and s.ShipmentStatus in (9) then s.Id end) 
	,count(case when s.OrderIdSuffix <> 'A' and s.ShipmentStatus in (8) then s.Id end) 
	,SUM(case when s.OrderIdSuffix = 'A' and s.ShipmentStatus in (9) then s.WarehouseId end) WC1
	,SUM(case when s.OrderIdSuffix = 'B' and s.ShipmentStatus in (8) then s.WarehouseId end) WD2
	,SUM(case when s.OrderIdSuffix = 'C' and s.ShipmentStatus in (8) then s.WarehouseId end) WD3

from Shipment s
--join Warehouse w on s.WarehouseId = w.Id
where 
	s.DeliveryWindowEnd >= '2021-11-25 00:00 +6:00'

group by s.OrderId
having count(s.Id) > 1
and count(case when s.OrderIdSuffix = 'A' and s.ShipmentStatus in (9) then s.Id end) = 1
and count(case when s.OrderIdSuffix <> 'A' and s.ShipmentStatus in (8) then s.Id end) >= 1
order by 2 desc


select * from Warehouse

