-- ============================================================
-- Author:       Bajwa, Achint Kaur
-- Create date:  November 2025
-- Function:     fn_CheckUserRole
-- Schema:       urbanease_shop
-- Description:  Determines whether a given user holds a specific role.
-- Tables:       Users, Roles, UserRoles
-- Returns:      TRUE (1) if user has the role, otherwise FALSE (0)
-- ============================================================

-- ============================================================
-- Business Objectives:
-- 1) Centralize role-validation logic so that multiple parts of the
--    system (procedures, triggers, queries, application layer) use
--    consistent access-control checks.
--
-- 2) Improve maintainability of authorization logic by allowing future
--    UI tools, admin dashboards, or APIs to validate user permissions
--    through a single reusable function.
--
-- 3) Ensure data integrity and reduce code duplication across stored
--    procedures that require easy verification of user privileges.
--
-- 4) Enable more secure workflow logic by supporting conditional
--    operations (e.g., only admins, managers, or auditors can perform
--    specific tasks).
-- ============================================================

USE urbanease_shop;

DROP FUNCTION IF EXISTS fn_CheckUserRole;
DELIMITER //

CREATE FUNCTION fn_CheckUserRole(
    p_user_id BIGINT,
    p_role_name VARCHAR(64)
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE has_role BOOLEAN DEFAULT FALSE;

    SELECT
        CASE WHEN COUNT(*) > 0 THEN TRUE ELSE FALSE END
        INTO has_role
    FROM UserRoles ur
    JOIN Roles r ON r.role_id = ur.role_id
    WHERE ur.user_id = p_user_id
      AND r.role_name = p_role_name;

    RETURN has_role;
END //

DELIMITER ;

-- Example tests:
-- SELECT fn_CheckUserRole(1, 'Admin');
-- SELECT fn_CheckUserRole(1, 'SuperAdmin');
