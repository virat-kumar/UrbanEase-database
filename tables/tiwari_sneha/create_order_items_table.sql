-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for OrderItems Table (35 entries)
-- Module: Order Management
-- Note: Requires Orders and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 order items (1-3 items per order)
INSERT INTO OrderItems (order_id, variant_id, qty, unit_price, tax_amount, discount_amount) VALUES
-- Order 1 items
(1, 1, 1, 2499.00, 199.92, 249.90),
(1, 11, 2, 24.99, 4.00, 5.00),

-- Order 2 items
(2, 3, 1, 1199.00, 95.92, 179.85),

-- Order 3 items
(3, 5, 2, 29.99, 4.80, 0.00),

-- Order 4 items
(4, 9, 1, 899.00, 71.92, 0.00),

-- Order 5 items
(5, 15, 1, 349.99, 28.00, 0.00),

-- Order 6 items
(6, 17, 2, 39.99, 6.40, 12.00),
(6, 19, 1, 44.99, 3.60, 6.75),

-- Order 7 items
(7, 23, 5, 14.99, 6.00, 0.00),

-- Order 8 items
(8, 25, 10, 8.99, 7.19, 0.00),

-- Order 9 items
(9, 27, 3, 19.99, 4.80, 0.00),

-- Order 10 items
(10, 2, 1, 3299.00, 263.92, 659.80),

-- Order 11 items
(11, 6, 1, 29.99, 2.40, 4.50),
(11, 13, 2, 19.99, 3.20, 6.00),
(11, 24, 1, 9.99, 0.80, 1.50),

-- Order 12 items
(12, 16, 1, 189.99, 15.20, 0.00),

-- Order 13 items
(13, 22, 1, 79.99, 6.40, 0.00),

-- Order 14 items
(14, 29, 1, 89.99, 7.20, 0.00),

-- Order 15 items
(15, 31, 1, 129.99, 10.40, 0.00),

-- Order 16 items
(16, 17, 3, 39.99, 9.60, 0.00),

-- Order 17 items
(17, 19, 1, 44.99, 3.60, 0.00),

-- Order 18 items
(18, 25, 10, 8.99, 7.19, 0.00),

-- Order 19 items
(19, 10, 1, 149.99, 12.00, 0.00),

-- Order 20 items
(20, 20, 2, 34.99, 5.60, 0.00),

-- Order 21 items
(21, 33, 4, 59.99, 19.20, 0.00),
(21, 30, 1, 19.99, 1.60, 0.00),

-- Order 22 items
(22, 35, 1, 54.99, 4.40, 0.00),

-- Order 23 items
(23, 24, 1, 29.99, 2.40, 0.00),

-- Order 24 items
(24, 26, 1, 199.99, 16.00, 30.00),

-- Order 25 items (cancelled)
(25, 9, 1, 899.00, 71.92, 0.00),

-- Order 26 items (cancelled)
(26, 1, 1, 2499.00, 199.92, 0.00);

-- Verify inserted data
SELECT COUNT(*) AS total_order_items FROM OrderItems;
SELECT 
    oi.order_item_id,
    oi.order_id,
    pv.sku,
    oi.qty,
    oi.unit_price,
    (oi.qty * oi.unit_price) AS line_total
FROM OrderItems oi
JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
LIMIT 10;
