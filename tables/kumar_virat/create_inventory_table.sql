-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Create Inventory Table
-- Module: Product Variants & Inventory Management
-- Note: Requires Warehouses and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Inventory;

CREATE TABLE Inventory (
  warehouse_id BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  on_hand      INT    NOT NULL CHECK (on_hand >= 0),
  reserved     INT    NOT NULL DEFAULT 0 CHECK (reserved >= 0),
  PRIMARY KEY (warehouse_id, variant_id),
  CONSTRAINT FK_Inv_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
  CONSTRAINT FK_Inv_Variant   FOREIGN KEY (variant_id)   REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Inventory COMMENT = 'Inventory levels per warehouse and product variant';

-- Create index for variant lookups
CREATE INDEX IX_Inventory_Variant ON Inventory(variant_id);

-- Verify table creation
DESC Inventory;

-- Example: Insert sample inventory records
/*
-- Assuming warehouse_id = 1 (NYC) and variant_id = 1 (iPhone 128GB Black)
INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved) VALUES 
  (1, 1, 100, 5),   -- NYC: 100 units, 5 reserved
  (2, 1, 75, 2),    -- LAX: 75 units, 2 reserved
  (3, 1, 50, 0),    -- CHI: 50 units, none reserved
  (1, 2, 80, 3);    -- NYC: 80 units of variant 2, 3 reserved
*/

-- Example: Query to see available inventory
-- SELECT 
--   w.name as warehouse,
--   pv.sku,
--   i.on_hand,
--   i.reserved,
--   (i.on_hand - i.reserved) as available
-- FROM Inventory i
-- JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
-- JOIN ProductVariants pv ON i.variant_id = pv.variant_id
-- WHERE (i.on_hand - i.reserved) > 0;

