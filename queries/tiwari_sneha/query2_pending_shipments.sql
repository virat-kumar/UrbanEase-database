-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 3 & 4 - Pending or In-Transit Shipments & Orders with Multiple Pending Shipments
-- Tables: Orders, OrderItems, Shipments
-- =============================================

USE urbanease_shop;

-- Query 3- Pending or In-Transit Shipments --
USE urbanease_shop;

SELECT
    o.order_id,
    u.email AS customer_email,
    s.shipment_id,
    s.carrier,
    s.tracking_no,
    s.status AS shipment_status,
    o.placed_at
FROM Shipments s
JOIN Orders o ON s.order_id = o.order_id
JOIN Users u ON o.user_id = u.user_id
WHERE s.status IN ('CREATED','PICKED','IN_TRANSIT')
ORDER BY s.shipment_id;

-- Query 4 - Orders with Multiple Pending Shipments --
USE urbanease_shop;

SELECT
    o.order_id,
    COUNT(s.shipment_id) AS pending_shipments_count,
    SUM(oi.qty) AS total_items,
    SUM(oi.line_total) AS total_order_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Shipments s ON o.order_id = s.order_id
WHERE s.status IN ('CREATED','PICKED','IN_TRANSIT')
GROUP BY o.order_id
HAVING COUNT(s.shipment_id) > 1
ORDER BY pending_shipments_count DESC, total_order_value DESC;
