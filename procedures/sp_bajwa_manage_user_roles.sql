-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Stored Procedure - Manage User Roles
-- Tables: Users, Roles, UserRoles
-- Purpose: Assign or remove roles from users
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE PROCEDURE sp_ManageUserRoles(
    IN p_user_id BIGINT,
    IN p_role_id INT,
    IN p_action VARCHAR(10)  -- 'ADD' or 'REMOVE'
)
BEGIN
    -- TODO: Implement your stored procedure logic here
    
    -- Example structure:
    -- IF p_action = 'ADD' THEN
    --     INSERT INTO UserRoles (user_id, role_id) VALUES (p_user_id, p_role_id);
    -- ELSEIF p_action = 'REMOVE' THEN
    --     DELETE FROM UserRoles WHERE user_id = p_user_id AND role_id = p_role_id;
    -- END IF;
    
    SELECT 'Procedure not implemented yet' as message;
END//

DELIMITER ;

-- Test the procedure
-- CALL sp_ManageUserRoles(1, 1, 'ADD');

