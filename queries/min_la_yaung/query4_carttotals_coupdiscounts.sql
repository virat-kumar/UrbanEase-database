-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/07/2025
-- Description: Query 4 - Cart Totals with coupon discounts
-- Tables: Carts, CartItems, Coupons
-- =============================================


USE urbanease_shop;
-- A query that calculates each cart’s subtotal, applies active coupon discounts, 
-- and shows the final total for both users and guests to evaluate coupon impact.
SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,
    COUNT(ci.cart_item_id) AS total_items,
    SUM(ci.qty * ci.unit_price) AS subtotal,
    cp.code AS coupon_code,
    cp.type AS coupon_type,
    cp.value AS coupon_value,
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT' THEN cp.value
        ELSE 0
    END AS discount_amount,
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (1 - cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT' THEN ROUND(SUM(ci.qty * ci.unit_price) - cp.value, 2)
        ELSE SUM(ci.qty * ci.unit_price)
    END AS final_total
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
LEFT JOIN Coupons cp ON cp.is_active = TRUE
GROUP BY c.cart_id, user_name, cp.code, cp.type, cp.value
HAVING subtotal >= 50
ORDER BY final_total DESC;