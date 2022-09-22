-- delivered

select w.id WarehouseId,w.name Warehouse,count(s.id) Delivered
from shipment s
join Warehouse w on w.id=s.WarehouseId

where ReconciledOn is not null 
and s.ReconciledOn >='2021-10-01 00:00 +6:00'
and s.ReconciledOn <'2021-11-01 00:00 +6:00'

and w.id not in (22,23,24,25,37)
group by w.id,w.Name
order by 1 asc,3 desc


-- CancelledAfterPickup+

select w.id WarehouseId,w.name Warehouse,count(s.id) CancelledAfterPickup
from shipment s
join CancelledShipmentAfterPickup csap on csap.id=s.id
join Warehouse w on w.id=s.WarehouseId

where csap.CreatedOn >='2021-10-01 00:00 +6:00'
and csap.CreatedOn <'2021-11-01 00:00 +6:00'
and w.id not in (22,23,24,25,37)
group by w.id,w.Name

order by 1 asc,3 desc


--Third-Party Count

-- Store all trackingRefs from a specified date into a Common Table Expression
DECLARE @trackingRefs TABLE (TrackingRef NVARCHAR(64));
WITH QUERY AS
(
SELECT TrackingRef
  FROM [egg1].[transport].[ReconciledTripsDeliveryHistory] as [left]
  WHERE DeliveryTripActionOn >= '2021-10-01 00:00 +6:00' and DeliveryTripActionOn < '2021-11-01 00:00 +6:00'
  AND TaskStateFormatted ='TPD/DelegatedToDelivery/FailedToDeliver'
)
INSERT INTO @trackingRefs
SELECT TrackingRef from Query;
-- End Common Table Expression

-- Use a cursor to read row by row and fetch the warehouse name
DECLARE @tRef_StateId TABLE (TrackingRef NVARCHAR(64), StateId INT);
DECLARE @tRef NVARCHAR(64)
DECLARE @stateId INT
DECLARE trackingRef_cursor CURSOR FOR
SELECT TrackingRef FROM @trackingRefs

OPEN trackingRef_cursor

FETCH NEXT FROM trackingRef_cursor
INTO @tRef

WHILE @@FETCH_STATUS = 0
BEGIN
    
    --PRINT @tRef
    SET @stateId = (SELECT [Key] FROM FREETEXTTABLE(Transport.State,[EncodedRef],@tRef))
    INSERT INTO @tRef_StateId VALUES (@tRef, @stateId)


    FETCH NEXT FROM trackingRef_cursor
    INTO @tRef
END
CLOSE trackingRef_cursor
DEALLOCATE trackingRef_cursor

--SELECT * FROM @tRef_StateId

SELECT COUNT(*) as ThirdPartyTaskCount, ManagingHub FROM transport.IndexEntry ie
WHERE StateMachine = 1 
AND [Key] = 'HighLevelStatus' 
AND ValueStr <> 'Failed' 
-- Ensure non Chaldal GUID (there are other ways to ensure it's third party). Actually the StateId guarantees it's a third party
AND OrgGuid <> '0EDD17AD-7AF3-431D-8EC8-49DA39637431'
AND StateId IN (SELECT StateId FROM @tRef_StateId)
GROUP BY ManagingHub
