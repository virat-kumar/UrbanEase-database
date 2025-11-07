-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 2 - Top Selling Products by Revenue
-- Tables: OrderItems, ProductVariants, Products
-- =============================================

USE urbanease_shop;

SELECT 
    p.product_id,
    p.title AS product_name,
    SUM(oi.qty * oi.unit_price) AS total_revenue,
    SUM(oi.qty) AS total_units_sold
FROM OrderItems oi
JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
JOIN Products p ON pv.product_id = p.product_id
GROUP BY p.product_id, p.title
ORDER BY total_revenue DESC
LIMIT 10;
