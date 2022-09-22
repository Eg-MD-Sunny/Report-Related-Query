select w.Id,w.Name,w.IsActive ,w.ShortName,ma.Id, ma.Name

from Warehouse w
join MetropolitanArea ma on ma.Id = w.MetropolitanAreaId 
where w.IsActive = 1
and w.DistributionNetworkId = 1

order by 5