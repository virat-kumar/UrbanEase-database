-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 1 & 2 - Order Summary with Details
-- Tables: Orders, OrderItems, Shipments
-- =============================================

USE urbanease_shop;

-- Query 1- Order_Summary_With_Items_And_Shipments --

SELECT
    o.order_id,
    u.email AS customer_email,
    o.status AS order_status,
    COUNT(oi.order_item_id) AS total_items,           -- number of different products in order
    SUM(oi.qty) AS total_quantity,                   -- total quantity across all items
    SUM(oi.line_total) AS total_order_value,         -- total monetary value
    MAX(s.shipped_at) AS last_shipment_date,         -- latest shipment date
    GROUP_CONCAT(DISTINCT s.status) AS shipment_statuses  -- all shipment statuses for this order
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
LEFT JOIN Shipments s ON o.order_id = s.order_id
GROUP BY o.order_id, u.email, o.status
ORDER BY o.order_id DESC;


-- Query 2 - Top5_HighValue_Orders_With_Pending_Shipments --

USE urbanease_shop;

SELECT
    o.order_id,
    u.email AS customer_email,
    o.status AS order_status,
    SUM(oi.line_total) AS total_order_value,
    COUNT(oi.order_item_id) AS total_items,
    GROUP_CONCAT(DISTINCT s.status) AS shipment_statuses,
    MAX(s.shipped_at) AS last_shipment_date
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Shipments s ON o.order_id = s.order_id
WHERE s.status IN ('CREATED','PICKED','IN_TRANSIT')   -- only pending shipments
GROUP BY o.order_id, u.email, o.status
ORDER BY total_order_value DESC
LIMIT 5;

