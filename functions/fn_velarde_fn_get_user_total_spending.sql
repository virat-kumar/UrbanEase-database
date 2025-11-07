-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-07]
-- Function Name: fn_get_user_total_spending
-- Tables Involved: Users, Orders, Payments
-- Purpose: Calculate the total amount a user has spent
--          across all successfully captured payments.

-- Explanation:
-- 1. Input: A user ID (p_user_id).
-- 2. Joins Orders and Payments to find all payments from that user.
-- 3. Filters only payments with status = 'CAPTURED' (successful).
-- 4. Uses COALESCE to return 0.00 if no payments exist.
-- 5. Returns the total amount spent as DECIMAL(12,2).
-- ============================================================

USE urbanease_shop;

DELIMITER $$

CREATE FUNCTION fn_get_user_total_spending(p_user_id BIGINT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(12,2) DEFAULT 0.00;

    -- =======================================================
    -- Calculate total spending using JOINs
    -- =======================================================
    SELECT 
        COALESCE(SUM(p.amount), 0.00)
    INTO 
        total_spent
    FROM 
        Payments p
        INNER JOIN Orders o ON p.order_id = o.order_id
    WHERE 
        o.user_id = p_user_id
        AND p.status = 'CAPTURED';  -- Only count successful payments

    -- =======================================================
    -- Return total amount spent
    -- =======================================================
    RETURN total_spent;
END$$

DELIMITER ;

-- Example Usage:
-- Get total spending for user with ID = 3
SELECT fn_get_user_total_spending(3) AS Total_Spending;



