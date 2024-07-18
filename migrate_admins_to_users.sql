INSERT INTO users (belong_company_id, user_role_id, display_name, email, password, created_at, updated_at)
SELECT cm.id as new_belong_company_id, 1 as new_user_role_id, ad.display_name, ad.email, ad.password, ad.created_at, ad.updated_at
FROM admins ad
JOIN companies cm ON ad.id = cm.company_admin_id
WHERE ad.admin_role_id = 3 and ad.email NOT IN (SELECT email FROM users) ;