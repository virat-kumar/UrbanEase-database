-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-07]
-- Procedure Name: sp_analyze_customer_performance
-- Tables Involved: Users, Orders, Payments, Reviews
-- Purpose: Generate a performance summary for a single user

-- Explanation:
-- 1. Accepts a user ID and computes various KPIs:
--    - Number of orders
--    - Number of payments
--    - Total and average payment amounts
--    - Number of reviews and average rating
-- 2. Combines data from multiple tables (Orders, Payments, Reviews).
-- 3. Returns a single result with a “Customer_Tier” classification.
-- 4. Uses COALESCE to safely handle users with no payments or reviews.
-- ============================================================

USE urbanease_shop;

DELIMITER $$

CREATE PROCEDURE sp_analyze_customer_performance(IN p_user_id BIGINT)
BEGIN
    DECLARE total_orders INT DEFAULT 0;
    DECLARE total_payments INT DEFAULT 0;
    DECLARE total_amount DECIMAL(12,2) DEFAULT 0.00;
    DECLARE avg_payment DECIMAL(12,2) DEFAULT 0.00;
    DECLARE total_reviews INT DEFAULT 0;
    DECLARE avg_rating DECIMAL(3,2) DEFAULT 0.00;

    -- =======================================================
    -- Calculate orders and total payment information
    -- =======================================================
    SELECT 
        COUNT(DISTINCT o.order_id),
        COUNT(DISTINCT p.payment_id),
        COALESCE(SUM(p.amount), 0.00),
        COALESCE(AVG(p.amount), 0.00)
    INTO 
        total_orders, total_payments, total_amount, avg_payment
    FROM 
        Orders o
        LEFT JOIN Payments p ON o.order_id = p.order_id
    WHERE 
        o.user_id = p_user_id
        AND (p.status = 'CAPTURED' OR p.status = 'AUTHORIZED');

    -- =======================================================
    -- Calculate review information
    -- =======================================================
    SELECT 
        COUNT(r.review_id),
        COALESCE(AVG(r.rating), 0.00)
    INTO 
        total_reviews, avg_rating
    FROM 
        Reviews r
    WHERE 
        r.user_id = p_user_id;

    -- =======================================================
    -- Return a single summarized result set
    -- =======================================================
    SELECT 
        u.user_id AS User_ID,
        u.full_name AS Customer_Name,
        total_orders AS Total_Orders,
        total_payments AS Total_Payments,
        total_amount AS Total_Spent,
        avg_payment AS Avg_Payment,
        total_reviews AS Total_Reviews,
        avg_rating AS Avg_Rating,
        CASE
            WHEN total_amount >= 10000 THEN 'VIP Customer'
            WHEN total_amount BETWEEN 5000 AND 9999 THEN 'Frequent Buyer'
            ELSE 'Regular Customer'
        END AS Customer_Tier
    FROM 
        Users u
    WHERE 
        u.user_id = p_user_id;
END$$

DELIMITER ;

-- Example Usage:
CALL sp_analyze_customer_performance(3);
