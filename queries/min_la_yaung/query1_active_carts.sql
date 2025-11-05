-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 1 - Active Shopping Carts with Items
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;


-- a query that gives a detailed snapshot of every active shopping cart 
-- showing who owns it, how many items and categories it contains, how valuable it is, and when it was last updated.
SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,          -- handles guest checkouts gracefully
    COUNT(DISTINCT ci.cart_item_id) AS total_items,            -- total unique items in cart
    SUM(ci.qty * ci.unit_price) AS total_cart_value,           -- total value = sum of quantity × unit price
    MAX(ci.added_at) AS last_item_added,                       -- most recent time an item was added
    GROUP_CONCAT(DISTINCT cat.name ORDER BY cat.name SEPARATOR ', ') AS categories_in_cart,  -- categories covered in this cart
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) > 500 THEN 'High Value'
        WHEN SUM(ci.qty * ci.unit_price) BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS spending_tier,                                       -- simple tiering system based on total value
    COUNT(DISTINCT pv.product_id) AS distinct_products,         -- unique product count (excluding variants)
    COUNT(DISTINCT pv.variant_id) AS variant_count              -- count of product variants in the cart
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
LEFT JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Categories cat ON p.category_id = cat.category_id
WHERE c.cart_id IN (
    SELECT DISTINCT cart_id 
    FROM CartItems 
    WHERE qty > 0
)
GROUP BY c.cart_id, user_name
HAVING total_items > 0
ORDER BY total_cart_value DESC, last_item_added DESC;