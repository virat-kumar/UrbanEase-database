-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-06]
-- Description: Query 3 - Product Reviews and Ratings Analysis
-- Tables: Addresses, Payments, Reviews (+ Users, Orders, Products)

-- Purpose:
--   Analyze how customer satisfaction (via reviews) 
--   relates to regions (Addresses) and payment performance.
--
-- Includes:
--   Average product ratings by region
--   Count of reviews per product
--   Relationship between payment success and review activity
--   Optional grouping by state and city
-- =============================================

USE urbanease_shop;

SELECT
    -- Regional Information
    a.state_region AS State,
    a.city AS City,

    -- Product and Review Metrics
    pdt.title AS Product_Title,
    COUNT(r.review_id) AS Total_Reviews,                   -- total reviews written
    ROUND(AVG(r.rating), 2) AS Avg_Rating,                 -- average product rating
    SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS Five_Star_Reviews,
    SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END) AS One_Star_Reviews,

    -- Payment Insights for Reviewers
    COUNT(DISTINCT pay.payment_id) AS Related_Payments,     -- total payments linked to reviewers
    ROUND(SUM(pay.amount), 2) AS Total_Payment_Amount,      -- total payment value from reviewers
    ROUND(AVG(pay.amount), 2) AS Avg_Payment_Amount,        -- average payment value
    ROUND(
        (SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(pay.payment_id), 0)) * 100, 2
    ) AS Payment_Success_Rate,                              -- percentage of successful payments

    -- Engagement and Quality
    COUNT(DISTINCT r.user_id) AS Reviewers_Count,           -- number of unique users who left reviews
    ROUND(
        COUNT(r.review_id) / NULLIF(COUNT(DISTINCT r.user_id), 0), 2
    ) AS Avg_Reviews_Per_User,                              -- average reviews per user
    MAX(r.created_at) AS Last_Review_Date,                  -- most recent review date

    -- Timeframe
    MIN(pay.created_at) AS First_Payment_Date,
    MAX(pay.created_at) AS Last_Payment_Date

FROM Reviews r
    JOIN Users u 
        ON r.user_id = u.user_id
    JOIN Addresses a 
        ON u.user_id = a.user_id
    LEFT JOIN Orders o 
        ON o.user_id = u.user_id
    LEFT JOIN Payments pay 
        ON pay.order_id = o.order_id
    JOIN Products pdt 
        ON r.product_id = pdt.product_id

-- ==========================================================
-- Optional Filter Examples:
-- WHERE r.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)     -- only recent reviews
-- WHERE a.country_code = 'US'                                 -- limit to US users
-- WHERE pay.provider = 'Stripe'                               -- analyze by payment provider
-- ==========================================================

GROUP BY 
    a.state_region, 
    a.city, 
    pdt.title

HAVING 
    COUNT(r.review_id) > 0   -- include only products with reviews

ORDER BY 
    a.state_region ASC,
    a.city ASC,
    Avg_Rating DESC;


