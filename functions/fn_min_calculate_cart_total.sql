-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Function - Calculate Cart Total
-- Tables: Carts, CartItems, Coupons
-- Returns: Total amount for all items in cart
-- =============================================

USE urbanease_shop;

DELIMITER //

-- a function that calculates and returns the total value of all items in a given shopping cart.

CREATE FUNCTION fn_CalculateCartTotal(
    p_cart_id BIGINT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cart_total DECIMAL(12,2) DEFAULT 0.00;

    -- Sum up the total amount (quantity × price) for the specified cart
    SELECT 
        COALESCE(SUM(qty * unit_price), 0.00)
    INTO cart_total
    FROM CartItems
    WHERE cart_id = p_cart_id;

    -- Return the final calculated total for the cart
    RETURN cart_total;
END//

DELIMITER ;

-- Test the function
SELECT fn_CalculateCartTotal(1) AS cart_total;



