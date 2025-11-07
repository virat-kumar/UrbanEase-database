-- =============================================
-- Author: Min, La Yaung
-- Create date: November 2025
-- Description: Sample Data for CartItems Table (35 entries)
-- Module: Shopping Cart
-- Note: Requires Carts and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 cart items (1-3 items per cart)
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price, added_at) VALUES
-- Cart 1 items
(1, 1, 1, 2499.00, '2024-11-01 10:05:00'),
(1, 11, 2, 24.99, '2024-11-07 14:30:00'),

-- Cart 2 items
(2, 3, 1, 1199.00, '2024-11-02 11:20:00'),
(2, 21, 3, 24.99, '2024-11-07 15:45:00'),

-- Cart 3 items
(3, 5, 2, 29.99, '2024-11-03 09:35:00'),

-- Cart 4 items
(4, 7, 1, 79.99, '2024-11-04 14:25:00'),
(4, 12, 1, 12.99, '2024-11-07 16:10:00'),

-- Cart 5 items
(5, 9, 1, 899.00, '2024-11-05 08:50:00'),

-- Cart 6 items
(6, 15, 1, 349.99, '2024-11-05 16:35:00'),

-- Cart 7 items
(7, 17, 2, 39.99, '2024-11-06 10:25:00'),
(7, 19, 1, 44.99, '2024-11-07 13:20:00'),

-- Cart 8 items
(8, 23, 5, 14.99, '2024-11-06 13:45:00'),

-- Cart 9 items
(9, 25, 10, 8.99, '2024-11-06 15:15:00'),

-- Cart 10 items
(10, 27, 3, 19.99, '2024-11-06 18:25:00'),

-- Cart 11 items (abandoned)
(11, 2, 1, 3299.00, '2024-10-28 10:10:00'),

-- Cart 12 items (abandoned)
(12, 6, 1, 29.99, '2024-10-29 11:40:00'),
(12, 13, 2, 19.99, '2024-10-29 11:45:00'),

-- Cart 13 items (abandoned)
(13, 16, 1, 189.99, '2024-10-30 14:30:00'),

-- Cart 14 items (abandoned)
(14, 22, 1, 79.99, '2024-10-31 09:25:00'),

-- Cart 15 items (abandoned)
(15, 29, 1, 89.99, '2024-11-01 16:50:00'),

-- Cart 16 items (old abandoned)
(16, 31, 1, 129.99, '2024-10-20 10:15:00'),

-- Cart 17 items (old abandoned)
(17, 33, 2, 59.99, '2024-10-21 12:40:00'),

-- Cart 18 items (old abandoned)
(18, 35, 1, 54.99, '2024-10-22 15:20:00'),

-- Cart 20 items (guest)
(20, 5, 3, 29.99, '2024-11-07 09:30:00'),

-- Cart 21 items (guest)
(21, 19, 1, 44.99, '2024-11-07 10:45:00'),
(21, 25, 5, 8.99, '2024-11-07 11:15:00'),

-- Cart 25 items
(25, 10, 1, 149.99, '2024-11-03 10:35:00'),

-- Cart 28 items
(28, 20, 2, 34.99, '2024-11-05 09:50:00'),

-- Cart 33 items
(33, 32, 1, 89.99, '2024-11-07 12:50:00'),

-- Cart 34 items
(34, 30, 1, 49.99, '2024-11-07 14:15:00');

-- Verify inserted data
SELECT COUNT(*) AS total_cart_items FROM CartItems;
SELECT 
    ci.cart_item_id,
    ci.cart_id,
    pv.sku,
    ci.qty,
    ci.unit_price,
    (ci.qty * ci.unit_price) AS line_total
FROM CartItems ci
JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
LIMIT 10;
