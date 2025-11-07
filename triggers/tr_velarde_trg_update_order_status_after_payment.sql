-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-07]
-- Trigger Name: trg_update_order_status_after_payment
-- Tables Involved: Payments, Orders
-- Purpose: Automatically update the related order status
--          whenever a payment record is inserted or updated.

-- Explanation:
-- 1. Trigger fires *after* a payment record is inserted.
-- 2. It checks the payment’s status (CAPTURED, REFUNDED, etc.).
-- 3. Updates the corresponding order’s status automatically.
-- 4. Ensures your Orders table always reflects the latest payment result.
-- ============================================================

USE urbanease_shop;

DELIMITER $$

CREATE TRIGGER trg_update_order_status_after_payment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    DECLARE new_status VARCHAR(20);

    -- =======================================================
    -- Determine the new order status based on payment status
    -- =======================================================
    IF NEW.status = 'CAPTURED' THEN
        SET new_status = 'PAID';
    ELSEIF NEW.status = 'AUTHORIZED' THEN
        SET new_status = 'PENDING_PAYMENT';
    ELSEIF NEW.status = 'REFUNDED' THEN
        SET new_status = 'REFUNDED';
    ELSEIF NEW.status = 'FAILED' THEN
        SET new_status = 'PAYMENT_FAILED';
    ELSE
        SET new_status = 'PENDING';
    END IF;

    -- =======================================================
    -- Update the related order record
    -- =======================================================
    UPDATE Orders
    SET 
        status = new_status,
        updated_at = UTC_TIMESTAMP()  -- update the timestamp
    WHERE 
        order_id = NEW.order_id;

    -- =======================================================
    -- 3️Optional Logging (if you have a log table)
    -- =======================================================
    -- INSERT INTO PaymentLogs (order_id, payment_id, action, logged_at)
    -- VALUES (NEW.order_id, NEW.payment_id, CONCAT('Payment status updated to ', NEW.status), UTC_TIMESTAMP());

END$$

DELIMITER ;

