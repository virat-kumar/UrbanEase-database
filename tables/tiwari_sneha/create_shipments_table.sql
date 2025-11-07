-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for Shipments Table (30 entries)
-- Module: Order Fulfillment
-- Note: Requires Orders and Warehouses tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 30 shipments with various statuses
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at, delivered_at, created_at) VALUES
-- DELIVERED shipments (completed)
(1, 1, 'UPS', '1Z999AA10123456784', 'DELIVERED', '2024-10-16 09:00:00', '2024-10-18 14:30:00', '2024-10-15 15:00:00'),
(2, 2, 'FedEx', '773459876543210', 'DELIVERED', '2024-10-19 10:30:00', '2024-10-21 11:45:00', '2024-10-18 16:00:00'),
(3, 3, 'USPS', '9400110200830123456789', 'DELIVERED', '2024-10-21 08:15:00', '2024-10-24 16:20:00', '2024-10-20 14:30:00'),
(4, 1, 'UPS', '1Z999AA10234567895', 'DELIVERED', '2024-10-23 11:00:00', '2024-10-26 13:10:00', '2024-10-22 17:00:00'),
(5, 4, 'FedEx', '773459876654321', 'DELIVERED', '2024-10-26 09:30:00', '2024-10-29 15:40:00', '2024-10-25 18:00:00'),
(6, 2, 'DHL', '1234567890', 'DELIVERED', '2024-10-29 10:00:00', '2024-10-31 12:20:00', '2024-10-28 15:30:00'),
(7, 5, 'USPS', '9400110200830234567890', 'DELIVERED', '2024-11-02 08:45:00', '2024-11-04 14:15:00', '2024-11-01 12:00:00'),
(8, 3, 'UPS', '1Z999AA10345678906', 'DELIVERED', '2024-11-03 11:20:00', '2024-11-05 16:30:00', '2024-11-02 17:30:00'),
(9, 6, 'FedEx', '773459876765432', 'DELIVERED', '2024-11-04 09:00:00', '2024-11-06 10:45:00', '2024-11-03 13:00:00'),

-- FULFILLED orders (older deliveries)
(11, 1, 'UPS', '1Z999AA10111111111', 'DELIVERED', '2024-09-16 10:00:00', '2024-09-19 14:20:00', '2024-09-15 16:00:00'),
(12, 7, 'FedEx', '773459876222222', 'DELIVERED', '2024-09-21 11:30:00', '2024-09-24 15:40:00', '2024-09-20 17:00:00'),
(13, 2, 'USPS', '9400110200830333333333', 'DELIVERED', '2024-09-26 08:00:00', '2024-09-29 12:10:00', '2024-09-25 14:00:00'),
(14, 8, 'DHL', '1234567891', 'DELIVERED', '2024-10-02 09:30:00', '2024-10-05 13:25:00', '2024-10-01 18:30:00'),
(15, 3, 'UPS', '1Z999AA10444444444', 'DELIVERED', '2024-10-06 10:00:00', '2024-10-09 16:50:00', '2024-10-05 15:00:00'),
(16, 9, 'FedEx', '773459876555555', 'DELIVERED', '2024-10-11 11:00:00', '2024-10-14 14:30:00', '2024-10-10 16:00:00'),

-- IN_TRANSIT shipments (on the way)
(21, 1, 'UPS', '1Z999AA10666666666', 'IN_TRANSIT', '2024-11-05 09:00:00', NULL, '2024-11-04 16:00:00'),
(22, 10, 'FedEx', '773459876777777', 'IN_TRANSIT', '2024-11-05 10:30:00', NULL, '2024-11-04 18:00:00'),
(23, 2, 'USPS', '9400110200830888888888', 'IN_TRANSIT', '2024-11-06 08:15:00', NULL, '2024-11-05 13:00:00'),
(24, 4, 'DHL', '1234567892', 'IN_TRANSIT', '2024-11-06 11:00:00', NULL, '2024-11-05 17:00:00'),
(25, 3, 'UPS', '1Z999AA10999999999', 'IN_TRANSIT', '2024-11-06 09:30:00', NULL, '2024-11-05 19:00:00'),

-- PICKED shipments (ready to ship)
(30, 5, 'FedEx', '773459876000000', 'PICKED', NULL, NULL, '2024-11-06 14:00:00'),
(31, 6, 'UPS', '1Z999AA10000000001', 'PICKED', NULL, NULL, '2024-11-06 16:00:00'),
(32, 1, 'USPS', '9400110200830000000001', 'PICKED', NULL, NULL, '2024-11-06 18:00:00'),

-- CREATED shipments (just created, awaiting pickup)
(33, 7, 'DHL', '1234567893', 'CREATED', NULL, NULL, '2024-11-07 10:00:00'),
(34, 2, 'UPS', '1Z999AA10000000002', 'CREATED', NULL, NULL, '2024-11-07 14:00:00'),

-- CANCELLED shipment
(26, 8, 'UPS', '1Z999AA10CANCELLED', 'CANCELLED', NULL, NULL, '2024-10-12 15:00:00'),

-- REFUNDED orders - delivered but refunded
(28, 3, 'FedEx', '773459876REFUND1', 'DELIVERED', '2024-09-11 10:00:00', '2024-09-14 15:20:00', '2024-09-10 16:00:00'),
(29, 9, 'USPS', '9400110200830REFUND2', 'DELIVERED', '2024-09-29 09:00:00', '2024-10-02 13:45:00', '2024-09-28 18:00:00'),

-- More recent deliveries
(10, 4, 'DHL', '1234567894', 'DELIVERED', '2024-11-04 10:30:00', '2024-11-06 12:00:00', '2024-11-03 15:00:00');

-- Verify inserted data
SELECT COUNT(*) AS total_shipments FROM Shipments;
SELECT 
    s.shipment_id,
    s.order_id,
    w.name AS warehouse,
    s.carrier,
    s.tracking_no,
    s.status,
    s.shipped_at,
    s.delivered_at
FROM Shipments s
JOIN Warehouses w ON s.warehouse_id = w.warehouse_id
ORDER BY s.created_at DESC
LIMIT 10;
