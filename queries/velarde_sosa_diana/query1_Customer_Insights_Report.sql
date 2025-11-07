-- ==========================================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-06]
-- Description: Query 1 City-Level Customer Insights Report
-- Tables Used: Users, Addresses, Orders, Payments, Reviews
-- ----------------------------------------------------------
-- Purpose:
--   Generate regional performance insights including:
--   - Payment totals and success rate
--   - Average payment and order values
--   - Review participation and average ratings
--   - Monthly trends per city
-- ==========================================================

USE urbanease_shop;

SELECT 
    -- Geographic Information
    a.city AS City,
    a.state_region AS State,

    -- Monthly Trend (based on order placement date)
    DATE_FORMAT(o.placed_at, '%Y-%m') AS Month,

    -- Customer Activity
    COUNT(DISTINCT u.user_id) AS Total_Customers,    -- number of unique customers
    COUNT(DISTINCT o.order_id) AS Total_Orders,      -- total orders placed

    -- Payment Information
    ROUND(SUM(p.amount), 2) AS Total_Payment_Amount, -- total money paid
    ROUND(AVG(p.amount), 2) AS Avg_Payment_Amount,   -- average payment per transaction

    -- Payment Status Analysis
    SUM(CASE WHEN p.status = 'FAILED' THEN 1 ELSE 0 END) AS Failed_Payments,
    SUM(CASE WHEN p.status = 'CAPTURED' THEN 1 ELSE 0 END) AS Successful_Payments,
    ROUND(
        (SUM(CASE WHEN p.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(p.payment_id), 0)) * 100, 2
    ) AS Payment_Success_Rate,  -- success % of all payments

    -- Order Information
    ROUND(SUM(o.grand_total), 2) AS Total_Sales,     -- total sales amount
    ROUND(AVG(o.grand_total), 2) AS Avg_Order_Value, -- average order value

    -- Review Insights
    COUNT(DISTINCT r.review_id) AS Total_Reviews,    -- total number of reviews written
    ROUND(AVG(r.rating), 2) AS Avg_Product_Rating,   -- average star rating
    ROUND(
        (COUNT(DISTINCT r.review_id) / NULLIF(COUNT(DISTINCT u.user_id), 0)) * 100, 2
    ) AS Review_Participation_Rate,  -- % of customers who wrote at least one review

    -- Reporting Window
    MIN(o.placed_at) AS First_Order_Date,
    MAX(o.placed_at) AS Last_Order_Date

FROM Users u
    JOIN Addresses a 
        ON u.user_id = a.user_id
    JOIN Orders o 
        ON u.user_id = o.user_id
    LEFT JOIN Payments p 
        ON o.order_id = p.order_id
    LEFT JOIN Reviews r 
        ON u.user_id = r.user_id

-- ==========================================================
-- Optional Time Filter (uncomment for last 6 months)
-- WHERE o.placed_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
-- ==========================================================

GROUP BY 
    a.city, 
    a.state_region,
    DATE_FORMAT(o.placed_at, '%Y-%m')  -- monthly grouping

HAVING 
    SUM(p.amount) > 0  -- only include cities with payment activity

ORDER BY 
    a.state_region ASC,
    a.city ASC,
    Month DESC;
