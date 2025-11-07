-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Query 1 - User Login History
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

SELECT
  u.user_id,
  u.email,
  u.full_name,
  r.role_name,
  ur.assigned_at
FROM Users      AS u
JOIN UserRoles  AS ur ON ur.user_id = u.user_id
JOIN Roles      AS r  ON r.role_id  = ur.role_id
-- Optional filter to show only active accounts:
-- WHERE u.is_active = 1
ORDER BY u.user_id, ur.assigned_at, r.role_name;
