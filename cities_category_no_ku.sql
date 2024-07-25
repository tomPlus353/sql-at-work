SELECT
    *
FROM
    properties
WHERE
    city_id IN (
    SELECT
        c.id cid
    FROM
        cities c
    WHERE
        c.display_name NOT IN(
        SELECT
            pc.city
        FROM
            postcodes pc
    )
) AND properties.location NOT LIKE "%区%"
