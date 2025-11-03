-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Stored Procedure - Update Inventory
-- Tables: ProductVariants, Warehouses, Inventory
-- Purpose: Update inventory levels (on_hand and reserved)
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE PROCEDURE sp_UpdateInventory(
    IN p_warehouse_id BIGINT,
    IN p_variant_id BIGINT,
    IN p_quantity_change INT,
    IN p_operation VARCHAR(20)  -- 'ADD_STOCK', 'REMOVE_STOCK', 'RESERVE', 'RELEASE'
)
BEGIN
    -- TODO: Implement your stored procedure logic here
    
    -- Example structure:
    -- CASE p_operation
    --     WHEN 'ADD_STOCK' THEN
    --         UPDATE Inventory SET on_hand = on_hand + p_quantity_change;
    --     WHEN 'RESERVE' THEN
    --         UPDATE Inventory SET reserved = reserved + p_quantity_change;
    -- END CASE;
    
    SELECT 'Procedure not implemented yet' as message;
END//

DELIMITER ;

-- Test the procedure
-- CALL sp_UpdateInventory(1, 1, 10, 'ADD_STOCK');

