-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Function - Get Order Item Count
-- Tables: Orders, OrderItems, Shipments
-- Returns: Number of items in an order
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE FUNCTION fn_GetOrderItemCount(
    p_order_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE item_count INT DEFAULT 0;
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT COUNT(*) INTO item_count
    -- FROM OrderItems
    -- WHERE order_id = p_order_id;
    
    RETURN item_count;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_GetOrderItemCount(1);

