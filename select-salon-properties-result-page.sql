SELECT
    p.property_title
FROM
    properties p
WHERE
	p.deleted_at IS NULL AND
    p.publication_status_id IN (2,3) AND
    p.latitude IS NOT NULL AND
-- condition to check one property
  --  p.property_title = "大阪市福島区 福島３丁目(新福島駅) の貸店舗 1階/10階建" AND
    p.id IN(
    SELECT
        property_id
    FROM
        properties_stations
    WHERE
--target one station, update as necessary
        station_id = 1162505
) AND 
-- filter for salon property type 
p.id IN(
    SELECT
        pst.property_id
    FROM
        properties_store_types pst
    WHERE
        pst.store_type_id IN(1, 2, 8, 9)
);
