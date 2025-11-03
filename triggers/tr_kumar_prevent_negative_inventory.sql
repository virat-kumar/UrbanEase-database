-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Trigger - Prevent Negative Inventory
-- Tables: ProductVariants, Warehouses, Inventory
-- Purpose: Ensure available stock never goes negative
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Prevent negative available inventory
CREATE TRIGGER tr_PreventNegativeInventory
BEFORE UPDATE ON Inventory
FOR EACH ROW
BEGIN
    -- TODO: Implement your trigger logic here
    
    -- Example: Prevent overselling
    -- IF (NEW.on_hand - NEW.reserved) < 0 THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'Cannot reserve more than available stock';
    -- END IF;
    
    -- You could also:
    -- - Log inventory changes
    -- - Send low stock alerts
    -- - Update product availability
    
END//

DELIMITER ;

-- Test the trigger
-- UPDATE Inventory SET reserved = 100 WHERE variant_id = 1 AND warehouse_id = 1;

