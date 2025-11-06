-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Create Shipments Table
-- Module: Order Management & Fulfillment
-- Note: Requires Orders and Warehouses tables to exist first
-- =============================================
USE urbanease_shop;

-- =====================================================
-- Warehouses Table (required for Shipments)
-- =====================================================


CREATE TABLE Warehouses (
    warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,       
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE Warehouses
ADD COLUMN location VARCHAR(255) AFTER name,
ADD COLUMN contact_person VARCHAR(100) AFTER location;
DESCRIBE Warehouses;

INSERT INTO Warehouses (name, location, code, city, state_region, country_code)
VALUES
('Dallas Fulfillment Center', '123 Industrial Dr, Dallas, TX', 'DFC001', 'Dallas', 'TX', 'US'),
('Plano Warehouse', '456 Commerce Blvd, Plano, TX', 'PLW002', 'Plano', 'TX', 'US'),
('Richardson Distribution Hub', '789 Logistics Ln, Richardson, TX', 'RDH003', 'Richardson', 'TX', 'US');

-- =====================================================
-- Shipments Table
-- =====================================================
CREATE TABLE IF NOT EXISTS Shipments (
    shipment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    warehouse_id BIGINT NULL,
    carrier VARCHAR(80) NOT NULL,
    tracking_no VARCHAR(120) NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('CREATED','PICKED','IN_TRANSIT','DELIVERED','CANCELLED')),
    shipped_at DATETIME NULL,
    delivered_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),

    CONSTRAINT FK_Ship_Order FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Ship_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comment
ALTER TABLE Shipments COMMENT = 'Tracks order shipments with warehouse, carrier, and status';

-- Indexes for performance
CREATE INDEX IX_Shipments_Order  ON Shipments(order_id);
CREATE INDEX IX_Shipments_Status ON Shipments(status);

-- =====================================================
-- Sample Shipment Data (matching Orders 16-30)
-- =====================================================
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at, delivered_at)
VALUES
(16, 1, 'FedEx', 'FDX1001TX', 'IN_TRANSIT', '2025-11-02 09:15:00', NULL),
(17, 1, 'UPS', 'UPS2001TX', 'DELIVERED', '2025-10-30 13:00:00', '2025-11-02 16:00:00'),
(18, 2, 'DHL', 'DHL3001TX', 'CREATED', NULL, NULL),
(19, 2, 'FedEx', 'FDX4001TX', 'PICKED', '2025-11-03 10:00:00', NULL),
(20, 1, 'USPS', 'USPS5001TX', 'DELIVERED', '2025-10-28 11:30:00', '2025-10-30 15:30:00'),
(21, 3, 'UPS', 'UPS6001TX', 'IN_TRANSIT', '2025-11-04 08:45:00', NULL),
(22, 1, 'FedEx', 'FDX7001TX', 'DELIVERED', '2025-10-26 12:00:00', '2025-10-29 14:00:00'),
(23, 3, 'DHL', 'DHL8001TX', 'PICKED', '2025-11-05 09:30:00', NULL),
(24, 1, 'UPS', 'UPS9001TX', 'IN_TRANSIT', '2025-11-05 10:45:00', NULL),
(25, 2, 'USPS', 'USPS1001TX', 'CREATED', NULL, NULL),
(26, 3, 'FedEx', 'FDX1101TX', 'DELIVERED', '2025-10-27 08:30:00', '2025-10-30 17:10:00'),
(27, 1, 'DHL', 'DHL1201TX', 'CANCELLED', NULL, NULL),
(28, 2, 'UPS', 'UPS1301TX', 'IN_TRANSIT', '2025-11-04 07:00:00', NULL),
(29, 3, 'USPS', 'USPS1401TX', 'PICKED', '2025-11-03 11:20:00', NULL),
(30, 2, 'FedEx', 'FDX1501TX', 'DELIVERED', '2025-10-29 10:10:00', '2025-11-01 13:30:00');

-- =====================================================
-- Example Query to view shipments with order & warehouse info
-- =====================================================
SELECT 
    s.shipment_id,
    o.order_id,
    u.email AS customer,
    w.name AS warehouse,
    s.carrier,
    s.tracking_no,
    s.status,
    s.shipped_at,
    s.delivered_at
FROM Shipments s
JOIN Orders o ON s.order_id = o.order_id
JOIN Users u ON o.user_id = u.user_id
LEFT JOIN Warehouses w ON s.warehouse_id = w.warehouse_id
ORDER BY s.shipment_id;
