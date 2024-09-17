SELECT 
pref.display_name as current_pref_name,
c.display_name as current_city_name, 
location,
geolonia_pref,
geolonia_city,
geolonia_town,
geolonia_addr
FROM properties p join cities c on p.city_id = c.id join prefectures pref on pref.id = c.prefecture_id
where geolonia_level <> 3
AND p.deleted_at IS NULL
AND p.publication_status_id NOT IN (4,5);
