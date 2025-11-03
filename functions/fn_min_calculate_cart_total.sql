-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Function - Calculate Cart Total
-- Tables: Carts, CartItems, Coupons
-- Returns: Total amount for all items in cart
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE FUNCTION fn_CalculateCartTotal(
    p_cart_id BIGINT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cart_total DECIMAL(12,2) DEFAULT 0.00;
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT SUM(qty * unit_price) INTO cart_total
    -- FROM CartItems
    -- WHERE cart_id = p_cart_id;
    
    RETURN cart_total;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_CalculateCartTotal(1);

