-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Function - Check if User has Specific Role
-- Tables: Users, Roles, UserRoles
-- Returns: TRUE if user has the role, FALSE otherwise
-- =============================================

USE urbanease_shop;

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
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT COUNT(*) > 0 INTO has_role
    -- FROM UserRoles ur
    -- JOIN Roles r ON ur.role_id = r.role_id
    -- WHERE ur.user_id = p_user_id AND r.role_name = p_role_name;
    
    RETURN has_role;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_CheckUserRole(1, 'Admin');

