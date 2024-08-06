-- Create temporary table for emails
CREATE TEMPORARY TABLE temp_emails (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255)
);

-- Insert random emails into temporary table
INSERT INTO temp_emails (id,email)
SELECT combined_ids.id,
CONCAT(
  LCASE(SUBSTR(MD5(RAND()), 1, 8)), '@', 
  LCASE(SUBSTR(MD5(RAND()), 1, 5)), '.com'
) AS random_email
FROM (SELECT id FROM admins UNION SELECT id FROM users UNION SELECT id FROM members) AS combined_ids;

 -- Update admins table, excluding admin@admin.com
 INSERT INTO admins (admin_role_id,display_name,email, password)
 VALUES (1, "Dummy Admin", "admin@admin.com","$2a$12$lBTSyiZSjK6hspFjASfW3.GZZsNeSDkHdt9UAKIEp2AEsEwg.qlXa");

-- Update admins table, excluding admin@admin.com
UPDATE admins t
JOIN temp_emails te ON t.id = te.id
SET t.email = te.email
WHERE t.email != 'admin@admin.com';

-- Update users table
UPDATE users u
JOIN temp_emails te ON u.id = te.id
SET u.email = te.email;

-- Update members table
UPDATE members m
JOIN temp_emails te ON m.id = te.id
SET m.email = te.email,
m.line_id = NULL;

-- Drop temporary table
DROP TEMPORARY TABLE temp_emails;
