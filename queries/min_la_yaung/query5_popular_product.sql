-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/07/2025
-- Description: Query 5 - Most Popular Products in Carts
-- Tables: CartItems, ProductVariants, Products, Categories
-- =============================================


USE urbanease_shop;

-- A query that identifies the most popular products added to carts 
-- by counting how often each product appears and the total quantity added.
SELECT 
    p.product_id,
    p.title AS product_name,
    c.name AS category_name,
    COUNT(ci.cart_item_id) AS times_in_cart,
    SUM(ci.qty) AS total_qty_added,
    ROUND(AVG(ci.unit_price), 2) AS avg_price
FROM CartItems ci
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
INNER JOIN Categories c ON p.category_id = c.category_id
GROUP BY p.product_id, p.title, c.name
ORDER BY total_qty_added DESC, times_in_cart DESC
LIMIT 10;