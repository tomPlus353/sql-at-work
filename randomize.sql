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
FROM (SELECT id FROM admins UNION SELECT id FROM users UNION SELECT id FROM members UNION SELECT id FROM customer_search_preferences) AS combined_ids;

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

-- Add kanesa test account
INSERT INTO `users`(
    `belong_company_id`,
    `user_role_id`,
    `display_name`,
    `email`,
    `password`,
    `created_at`,
    `updated_at`
)
VALUES(
    61,
    1,
    'カネサPのテスト',
    'hiroto.ito@kanesa-p.com',
    '$2a$12$euuZh5FIPZ2RIHrJUAKK3e8IbdyJm7adP6TEj.GI2SvZLVjPDDm3m',
    NOW(),
    NOW()
);



-- Update members table
UPDATE members m
JOIN temp_emails te ON m.id = te.id
SET m.email = te.email,
m.line_id = NULL;

-- Update customer search pref table
UPDATE customer_search_preferences c
JOIN temp_emails te ON c.id = te.id
SET c.customer_email = te.email;



-- Drop temporary table
DROP TEMPORARY TABLE temp_emails;
