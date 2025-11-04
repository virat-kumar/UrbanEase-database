-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 2 - Abandoned Carts Analysis
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;

-- a query that finds carts inactive for less than or exactly 7 days, including potential revenue.

SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,
    DATEDIFF(NOW(), c.updated_at) AS days_inactive,
    COUNT(ci.cart_item_id) AS total_items,
    SUM(ci.qty * ci.unit_price) AS potential_revenue
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
LEFT JOIN CartItems ci ON ci.cart_id = c.cart_id
GROUP BY c.cart_id, user_name, c.updated_at
HAVING days_inactive <=7 AND total_items > 0
ORDER BY days_inactive DESC;

