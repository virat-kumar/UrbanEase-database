-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 4 - Order Fulfillment & Shipment Tracking
-- Tables: Orders, Shipments, Payments, Users
-- =============================================

USE urbanease_shop;

SELECT 
    o.order_id,
    u.full_name AS customer_name,
    o.status AS order_status,
    COALESCE(s.status, 'NOT_SHIPPED') AS shipment_status,
    p.status AS payment_status,
    o.grand_total_amount,
    s.carrier,
    s.tracking_no,
    s.shipped_at,
    s.delivered_at
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
LEFT JOIN Shipments s ON o.order_id = s.order_id
LEFT JOIN Payments p ON o.order_id = p.order_id
ORDER BY o.placed_at DESC;
