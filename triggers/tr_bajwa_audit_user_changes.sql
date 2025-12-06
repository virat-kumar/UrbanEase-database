-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Trigger - Audit User Changes
-- Tables: Users, Roles, UserRoles
-- Purpose: Log or validate user changes before/after updates
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Example: Update timestamp on user modification
CREATE TRIGGER tr_AuditUserChanges
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    -- TODO: Implement your trigger logic here
    
    -- Example: Automatically update the updated_at timestamp
    -- SET NEW.updated_at = UTC_TIMESTAMP();
    
    -- You could also:
    -- - Validate email format
    -- - Log changes to an audit table
    -- - Prevent certain fields from being changed
    
END//

DELIMITER ;

-- Test the trigger
-- UPDATE Users SET full_name = 'New Name' WHERE user_id = 1;

