-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 1 - Active Shopping Carts with Items
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;


-- a query that shows all active carts that have at least one item,
-- listing each user’s name, total cart value, and the last time something was added.

SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,
    COUNT(ci.cart_item_id) AS total_items,
    SUM(ci.qty * ci.unit_price) AS total_value,
    MAX(ci.added_at) AS last_updated
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
GROUP BY c.cart_id, user_name
HAVING total_items > 0
ORDER BY last_updated DESC;

