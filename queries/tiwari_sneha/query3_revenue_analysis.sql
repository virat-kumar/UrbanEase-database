-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 3 - Coupon Performance Report
-- Tables: Coupons, Orders
-- =============================================

USE urbanease_shop;

SELECT 
    c.code AS coupon_code,
    COUNT(o.order_id) AS times_used,
    SUM(o.discount_amount) AS total_discount_given,
    SUM(o.subtotal_amount) AS total_sales_before_discount,
    ROUND((SUM(o.discount_amount) / SUM(o.subtotal_amount)) * 100, 2) AS avg_discount_pct
FROM Coupons c
JOIN Orders o ON c.coupon_id = o.coupon_id
GROUP BY c.code
ORDER BY total_discount_given DESC;
