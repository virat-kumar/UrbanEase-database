-- =============================================
-- Author: Sneha Tiwari
-- Create date: [Date]
-- Description: Query 1 - Customer Order Summary
-- Tables: Users, Orders
-- =============================================
USE urbanease_shop;

SELECT 
    u.user_id,
    u.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.grand_total_amount) AS total_spent,
    MAX(o.placed_at) AS last_order_date
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_spent DESC;
