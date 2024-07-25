SELECT * from properties where city_id IN (SELECT id from cities where display_name = 仙台市) AND properties.location NOT LIKE %区%
