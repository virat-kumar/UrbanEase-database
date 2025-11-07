-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for Orders Table (35 entries)
-- Module: Order Management
-- Note: Requires Users, Coupons, and Addresses tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 orders with various statuses and amounts
INSERT INTO Orders (user_id, status, subtotal_amount, discount_amount, shipping_amount, tax_amount, coupon_id, shipping_address_id, billing_address_id, placed_at) VALUES
-- PAID orders (completed)
(2, 'PAID', 2548.98, 254.90, 15.00, 203.92, 1, 1, 1, '2024-10-15 10:30:00'),
(3, 'PAID', 1199.00, 179.85, 0.00, 95.92, 2, 2, 2, '2024-10-18 14:20:00'),
(4, 'PAID', 59.98, 0.00, 8.99, 4.80, NULL, 3, 3, '2024-10-20 09:15:00'),
(5, 'PAID', 899.00, 0.00, 49.99, 71.92, NULL, 4, 4, '2024-10-22 11:45:00'),
(6, 'PAID', 349.99, 0.00, 12.99, 28.00, NULL, 5, 5, '2024-10-25 16:30:00'),
(7, 'PAID', 124.97, 18.75, 0.00, 10.00, 2, 6, 6, '2024-10-28 13:10:00'),
(8, 'PAID', 74.95, 0.00, 5.99, 6.00, NULL, 7, 7, '2024-11-01 10:05:00'),
(9, 'PAID', 89.90, 0.00, 7.99, 7.19, NULL, 8, 8, '2024-11-02 15:20:00'),
(10, 'PAID', 59.97, 0.00, 6.99, 4.80, NULL, 9, 9, '2024-11-03 09:40:00'),

-- FULFILLED orders (delivered/completed)
(11, 'FULFILLED', 3299.00, 659.80, 0.00, 263.92, 3, 10, 10, '2024-09-15 11:20:00'),
(12, 'FULFILLED', 79.97, 12.00, 8.99, 6.40, 1, 11, 11, '2024-09-20 14:35:00'),
(13, 'FULFILLED', 189.99, 0.00, 15.99, 15.20, NULL, 12, 12, '2024-09-25 10:15:00'),
(14, 'FULFILLED', 79.99, 0.00, 9.99, 6.40, NULL, 13, 13, '2024-10-01 16:45:00'),
(15, 'FULFILLED', 89.99, 0.00, 0.00, 7.20, NULL, 14, 14, '2024-10-05 13:25:00'),
(16, 'FULFILLED', 129.99, 0.00, 12.99, 10.40, NULL, 15, 15, '2024-10-10 09:50:00'),

-- PENDING orders (payment pending)
(17, 'PENDING', 119.98, 0.00, 10.99, 9.60, NULL, 16, 16, '2024-11-06 10:30:00'),
(18, 'PENDING', 44.99, 0.00, 5.99, 3.60, NULL, 17, 17, '2024-11-06 14:15:00'),
(19, 'PENDING', 89.95, 13.49, 0.00, 7.20, 2, 18, 18, '2024-11-07 08:20:00'),
(20, 'PENDING', 149.99, 0.00, 11.99, 12.00, NULL, 19, 19, '2024-11-07 11:45:00'),

-- More PAID orders (recent)
(21, 'PAID', 69.98, 0.00, 7.99, 5.60, NULL, 20, 20, '2024-11-04 12:30:00'),
(22, 'PAID', 259.96, 0.00, 0.00, 20.80, NULL, 21, 21, '2024-11-04 15:50:00'),
(23, 'PAID', 54.99, 0.00, 6.99, 4.40, NULL, 22, 22, '2024-11-05 09:10:00'),
(24, 'PAID', 29.99, 0.00, 4.99, 2.40, NULL, 23, 23, '2024-11-05 13:35:00'),
(25, 'PAID', 199.98, 30.00, 10.99, 16.00, 2, 24, 24, '2024-11-05 16:20:00'),

-- CANCELLED orders
(26, 'CANCELLED', 899.00, 0.00, 49.99, 71.92, NULL, 25, 25, '2024-10-12 10:00:00'),
(27, 'CANCELLED', 2499.00, 0.00, 0.00, 199.92, NULL, 26, 26, '2024-10-16 14:25:00'),

-- REFUNDED orders
(28, 'REFUNDED', 79.99, 0.00, 9.99, 6.40, NULL, 27, 27, '2024-09-10 11:30:00'),
(29, 'REFUNDED', 149.99, 22.50, 11.99, 12.00, 2, 28, 28, '2024-09-28 15:45:00'),

-- More recent PAID orders
(30, 'PAID', 399.00, 0.00, 29.99, 31.92, NULL, 29, 29, '2024-11-06 09:15:00'),
(31, 'PAID', 699.00, 0.00, 0.00, 55.92, NULL, 30, 30, '2024-11-06 12:40:00'),
(32, 'PAID', 199.99, 30.00, 15.99, 16.00, 2, 1, 1, '2024-11-06 16:05:00'),
(33, 'PAID', 34.99, 0.00, 5.99, 2.80, NULL, 2, 2, '2024-11-07 10:20:00'),
(34, 'PAID', 149.99, 0.00, 12.99, 12.00, NULL, 3, 3, '2024-11-07 13:50:00'),
(35, 'PAID', 299.99, 45.00, 0.00, 24.00, 2, 4, 4, '2024-11-07 15:30:00');

-- Verify inserted data
SELECT COUNT(*) AS total_orders FROM Orders;
SELECT 
    order_id,
    user_id,
    status,
    subtotal_amount,
    discount_amount,
    grand_total_amount,
    placed_at
FROM Orders
ORDER BY placed_at DESC
LIMIT 10;
