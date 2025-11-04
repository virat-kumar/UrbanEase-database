-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Stored Procedure - Checkout Cart
-- Tables: Carts, CartItems, Coupons
-- Purpose: Convert cart to order and apply coupons
-- =============================================

USE urbanease_shop;

DELIMITER //

--  a procedure that handles the checkout process for a given cart by validating items, checking coupons, and calculating the final total.

CREATE PROCEDURE sp_CheckoutCart(
    IN p_cart_id BIGINT,
    IN p_coupon_code VARCHAR(40)
)
checkout_proc: BEGIN  --  Label the block so we can use LEAVE checkout_proc
    DECLARE v_subtotal DECIMAL(12,2) DEFAULT 0;
    DECLARE v_discount DECIMAL(12,2) DEFAULT 0;
    DECLARE v_total DECIMAL(12,2) DEFAULT 0;
    DECLARE v_coupon_type VARCHAR(20);
    DECLARE v_coupon_value DECIMAL(12,2);
    DECLARE v_coupon_valid BOOLEAN DEFAULT FALSE;

    -- check if the given cart exists and has at least one item
    IF NOT EXISTS (SELECT 1 FROM CartItems WHERE cart_id = p_cart_id) THEN
        SELECT CONCAT('Cart ID ', p_cart_id, ' is empty or does not exist.') AS message;
        LEAVE checkout_proc; 
    END IF;

    -- calculate the subtotal for the cart (sum of qty × price)
    SELECT SUM(qty * unit_price)
    INTO v_subtotal
    FROM CartItems
    WHERE cart_id = p_cart_id;

    -- validate coupon code if provided (check if active and within valid dates)
    IF p_coupon_code IS NOT NULL AND p_coupon_code <> '' THEN
        SELECT type, value, 
               (NOW() BETWEEN starts_at AND IFNULL(expires_at, NOW())) AS is_valid
        INTO v_coupon_type, v_coupon_value, v_coupon_valid
        FROM Coupons
        WHERE code = p_coupon_code AND is_active = TRUE
        LIMIT 1;

        IF v_coupon_valid IS NULL OR v_coupon_valid = FALSE THEN
            SELECT CONCAT('Coupon "', p_coupon_code, '" is invalid or expired.') AS message;
            SET v_coupon_type = NULL;
            SET v_coupon_value = 0;
            SET v_coupon_valid = FALSE;
        END IF;
    END IF;

    -- apply discount based on coupon type (PERCENT or AMOUNT)
    IF v_coupon_valid THEN
        IF v_coupon_type = 'PERCENT' THEN
            SET v_discount = ROUND(v_subtotal * (v_coupon_value / 100), 2);
        ELSEIF v_coupon_type = 'AMOUNT' THEN
            SET v_discount = ROUND(v_coupon_value, 2);
        END IF;
    END IF;

    -- calculate final total after applying discount
    SET v_total = ROUND(v_subtotal - v_discount, 2);

    -- display checkout summary for user verification
    SELECT 
        p_cart_id AS cart_id,
        v_subtotal AS subtotal,
        COALESCE(p_coupon_code, 'None') AS applied_coupon,
        COALESCE(v_coupon_type, 'N/A') AS coupon_type,
        v_discount AS discount_amount,
        v_total AS final_total,
        CONCAT('Checkout summary for cart ', p_cart_id, ' generated successfully.') AS message;
END checkout_proc//

DELIMITER ;

-- Test the procedure 
CALL sp_CheckoutCart(1, 'SAVE10');   -- valid cart + valid coupon
CALL sp_CheckoutCart(2, 'INVALID');  -- valid cart + invalid coupon
CALL sp_CheckoutCart(999, NULL);     -- nonexistent cart
CALL sp_CheckoutCart(3, NULL);       -- valid cart + no coupon

