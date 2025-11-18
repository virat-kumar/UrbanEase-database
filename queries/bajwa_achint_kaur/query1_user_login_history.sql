-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
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

-- ============================================================
-- COMMENTS:
-- 1) This query retrieves each user's profile information along 
--    with their assigned roles and the timestamp of assignment.
--
-- 2) JOINs:
--       • Users ↔ UserRoles to link users with their role mappings
--       • UserRoles ↔ Roles to fetch role names
--
-- 3) ORDER BY ensures user records are organized chronologically
--    based on when roles were assigned and grouped by user.
--
-- 4) The optional filter (u.is_active = 1) can be used to limit
--    the report to only active accounts.
--
-- 5) Useful for:
--       • Admin dashboards showing account activity
--       • Auditing role assignment history
--       • Verifying if users were set up correctly
-- ============================================================
