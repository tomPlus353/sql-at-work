-- Create temporary table for emails
CREATE TEMPORARY TABLE temp_emails (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255)
);

-- Insert random emails into temporary table
INSERT INTO temp_emails (email)
SELECT CONCAT(
  LCASE(SUBSTR(MD5(RAND()), 1, 8)), '@', 
  LCASE(SUBSTR(MD5(RAND()), 1, 5)), '.com'
) AS random_email
FROM (SELECT id FROM admins UNION SELECT id FROM users UNION SELECT id FROM members) AS combined_ids;
