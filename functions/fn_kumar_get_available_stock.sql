-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Function - Get Available Stock
-- Tables: ProductVariants, Warehouses, Inventory
-- Returns: Available stock (on_hand - reserved) for a variant
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE FUNCTION fn_GetAvailableStock(
    p_variant_id BIGINT,
    p_warehouse_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE available_stock INT DEFAULT 0;
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT (on_hand - reserved) INTO available_stock
    -- FROM Inventory
    -- WHERE variant_id = p_variant_id AND warehouse_id = p_warehouse_id;
    
    RETURN available_stock;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_GetAvailableStock(1, 1);

