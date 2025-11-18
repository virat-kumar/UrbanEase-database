-- ============================================================
-- Author:       Bajwa, Achint Kaur
-- Create date:  2025-11
-- Procedure:    sp_ManageUserRoles
-- Schema:       urbanease_shop
-- Description:  Stored Procedure - Manage User Roles
-- Tables:       Users, Roles, UserRoles
-- Purpose:      Assign or remove roles for users with validation
-- ============================================================

-- ============================================================
-- Business Objectives:
-- 1) Provide a centralized method for administrators to assign or remove
--    user roles without manually modifying the UserRoles table.
-- 2) Enforce data integrity by ensuring that duplicate role assignments
--    are not created, and invalid removals do not cause errors.
-- 3) Ensure consistent access control across the system by validating
--    user and role existence before updating access privileges.
-- 4) Return clear, human-readable messages that indicate the result of
--    the action (for use in dashboards, tools, or debugging).
-- ============================================================

USE urbanease_shop;

DROP PROCEDURE IF EXISTS sp_ManageUserRoles;
DELIMITER //

CREATE PROCEDURE sp_ManageUserRoles(
    IN p_user_id BIGINT,
    IN p_role_id INT,
    IN p_action VARCHAR(10)      -- Accepts 'ADD' or 'REMOVE'
)
BEGIN
    DECLARE v_action VARCHAR(10);
    DECLARE v_user_exists INT DEFAULT 0;
    DECLARE v_role_exists INT DEFAULT 0;
    DECLARE v_has_role INT DEFAULT 0;
    DECLARE v_role_name VARCHAR(100);

    -- Normalize input
    SET v_action = UPPER(TRIM(p_action));

    -- Validate action
    IF v_action NOT IN ('ADD', 'REMOVE') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid action. Use ADD or REMOVE.';
    END IF;

    -- Validate user existence
    SELECT COUNT(*) INTO v_user_exists
    FROM Users
    WHERE user_id = p_user_id;

    IF v_user_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User ID does not exist.';
    END IF;

    -- Validate role existence
    SELECT COUNT(*), MAX(role_name)
    INTO v_role_exists, v_role_name
    FROM Roles
    WHERE role_id = p_role_id;

    IF v_role_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Role ID does not exist.';
    END IF;

    -- Check if role is already assigned
    SELECT COUNT(*) INTO v_has_role
    FROM UserRoles
    WHERE user_id = p_user_id AND role_id = p_role_id;

    -- Perform action
    IF v_action = 'ADD' THEN
        IF v_has_role = 0 THEN
            INSERT INTO UserRoles (user_id, role_id, assigned_at)
            VALUES (p_user_id, p_role_id, NOW());
        END IF;

    ELSEIF v_action = 'REMOVE' THEN
        IF v_has_role = 1 THEN
            DELETE FROM UserRoles
            WHERE user_id = p_user_id AND role_id = p_role_id;
        END IF;
    END IF;

    -- Return clear feedback
    SELECT
        CONCAT(
            'User ID ', p_user_id, ': ',
            CASE
                WHEN v_action = 'ADD' AND v_has_role = 0 THEN CONCAT('Role "', v_role_name, '" assigned successfully.')
                WHEN v_action = 'ADD' AND v_has_role = 1 THEN CONCAT('Role "', v_role_name, '" was already assigned.')
                WHEN v_action = 'REMOVE' AND v_has_role = 1 THEN CONCAT('Role "', v_role_name, '" removed successfully.')
                WHEN v_action = 'REMOVE' AND v_has_role = 0 THEN CONCAT('Role "', v_role_name, '" was not assigned.')
            END
        ) AS message;

END //
DELIMITER ;

-- Test the procedure:
-- CALL sp_ManageUserRoles(1, 1, 'ADD');
-- CALL sp_ManageUserRoles(1, 1, 'REMOVE');
