-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Query 3 - Active Users with Multiple Roles
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

SELECT
  u.user_id,
  u.email,
  u.full_name,
  GROUP_CONCAT(DISTINCT r.role_name ORDER BY r.role_name SEPARATOR ', ') AS roles,
  COUNT(DISTINCT r.role_id) AS role_count
FROM Users      AS u
LEFT JOIN UserRoles AS ur ON ur.user_id = u.user_id
LEFT JOIN Roles     AS r  ON r.role_id  = ur.role_id
WHERE u.is_active = 1                      -- use 1 for cross-platform boolean
GROUP BY u.user_id, u.email, u.full_name
HAVING role_count > 1                      -- only show users with >1 role
ORDER BY role_count DESC, u.user_id;

-- COMMENTS
-- 1) Lists only active users who hold more than one distinct role.
-- 2) GROUP_CONCAT(DISTINCT ...) ensures duplicate roles are not repeated.
-- 3) COUNT(DISTINCT r.role_id) enables HAVING role_count>1 filtering.
-- 4) Uses numeric 1 for BOOLEAN to avoid TRUE/FALSE portability issues.
-- 5) ORDER BY role_count DESC shows users with the most roles first.
-- 6) Helpful indexes:
--      CREATE INDEX idx_userroles_user ON UserRoles(user_id);
--      CREATE INDEX idx_userroles_role ON UserRoles(role_id);
--      CREATE INDEX idx_users_active   ON Users(is_active);
