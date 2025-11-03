-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Create Shipments Table
-- Module: Order Management & Fulfillment
-- Note: Requires Orders and Warehouses tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Shipments;

CREATE TABLE Shipments (
  shipment_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT      NOT NULL,
  warehouse_id BIGINT      NULL,
  carrier      VARCHAR(80) NOT NULL,
  tracking_no  VARCHAR(120) NULL,
  status       VARCHAR(20) NOT NULL CHECK (status IN ('CREATED','PICKED','IN_TRANSIT','DELIVERED','CANCELLED')),
  shipped_at   DATETIME NULL,
  delivered_at DATETIME NULL,
  created_at   DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  CONSTRAINT FK_Ship_Order     FOREIGN KEY (order_id)     REFERENCES Orders(order_id),
  CONSTRAINT FK_Ship_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Shipments COMMENT = 'Shipment tracking for order fulfillment';

-- Create indexes for lookups
CREATE INDEX IX_Shipments_Order ON Shipments(order_id);
CREATE INDEX IX_Shipments_Status ON Shipments(status);

-- Verify table creation
DESC Shipments;

-- Example: Insert sample shipments
/*
-- Assuming order_id = 1, warehouse_id = 1
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at) VALUES 
  (1, 1, 'FedEx', '1234567890', 'IN_TRANSIT', '2024-11-01 10:00:00'),
  (2, 2, 'UPS', '0987654321', 'DELIVERED', '2024-10-28 14:30:00');
*/

-- Example: Query to see shipment tracking
-- SELECT 
--   s.shipment_id,
--   o.order_id,
--   u.email as customer,
--   s.carrier,
--   s.tracking_no,
--   s.status,
--   s.shipped_at,
--   s.delivered_at
-- FROM Shipments s
-- JOIN Orders o ON s.order_id = o.order_id
-- JOIN Users u ON o.user_id = u.user_id
-- ORDER BY s.created_at DESC;

