-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 5 & 6 - Revenue Analysis by Period
-- Tables: Orders, OrderItems, Shipments
-- =============================================

USE urbanease_shop;

-- Query 5 - Daily Revenue Summary --
USE urbanease_shop;

SELECT
    DATE(o.placed_at) AS order_date,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.line_total) AS daily_revenue,
    AVG(oi.line_total) AS avg_order_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY DATE(o.placed_at)
ORDER BY order_date;

-- Query 6 - Monthly Revenue Trend for Fulfilled Orders --
USE urbanease_shop;

SELECT
    DATE_FORMAT(o.placed_at, '%Y-%m') AS month_year,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.line_total) AS total_revenue,
    AVG(oi.line_total) AS avg_order_value,
    SUM(oi.qty) AS total_items_sold
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.status = 'FULFILLED'
GROUP BY month_year
ORDER BY month_year;
