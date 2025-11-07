-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Query 2 - Users by Role
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

-- (Optional) show more sample emails if many users share a role
-- SET SESSION group_concat_max_len = 8192;

SELECT
  r.role_name,
  COUNT(DISTINCT ur.user_id) AS user_count,                          -- de-duplicate users per role
  COALESCE(
    GROUP_CONCAT(DISTINCT u.email ORDER BY u.email SEPARATOR ', '),  -- readable examples
    '—'
  ) AS example_users
FROM Roles      AS r
LEFT JOIN UserRoles AS ur ON ur.role_id = r.role_id
LEFT JOIN Users     AS u  ON u.user_id  = ur.user_id
-- Uncomment to count only active accounts:
-- WHERE u.is_active = 1 OR u.user_id IS NULL
GROUP BY r.role_id, r.role_name
ORDER BY user_count DESC, r.role_name;

-- COMMENTS
-- 1) COUNT(DISTINCT ur.user_id) prevents overcounting if data ever contains duplicates.
-- 2) GROUP_CONCAT(DISTINCT ...) lists unique emails per role; COALESCE shows '—' when no users.
-- 3) Add the WHERE line to exclude inactive users from counts while keeping roles with zero users.
-- 4) If your role gets many users, bump GROUP_CONCAT length (see SET statement above).
-- 5) Helpful indexes (if not already present):
--      CREATE INDEX idx_userroles_role ON UserRoles(role_id);
--      CREATE INDEX idx_userroles_user ON UserRoles(user_id);
--      CREATE UNIQUE INDEX uq_roles_name ON Roles(role_name);
