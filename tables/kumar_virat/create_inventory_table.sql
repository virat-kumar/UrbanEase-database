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

-- =============================================
-- Sample Data: 50 Inventory Entries
-- Links Warehouses to ProductVariants with stock levels
-- Scenarios: High stock, Low stock, Reserved, Out of stock
-- =============================================

INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved) VALUES 
  -- Warehouse 1 (NYC) - High volume distribution center (10 entries)
  (1, 1, 250, 35),      -- iPhone 15 128GB Black: High stock, active sales
  (1, 4, 180, 22),      -- Galaxy S24 128GB Gray: Healthy stock
  (1, 8, 120, 15),      -- MacBook Air M3 8GB: Premium item
  (1, 13, 95, 12),      -- AirPods Pro 2 White: Popular accessory
  (1, 24, 450, 65),     -- Nike T-Shirt M Black: Fast moving
  (1, 32, 8, 7),        -- Levis Jeans 32 Blue: LOW STOCK - only 1 available!
  (1, 19, 75, 10),      -- Dyson V15 Standard: Healthy appliance stock
  (1, 40, 320, 48),     -- Nike Air Max 10 Black: High demand footwear
  (1, 47, 0, 0),        -- Water Bottle Blue: OUT OF STOCK
  (1, 16, 165, 20),     -- Samsung T7 1TB: Good electronics stock
  
  -- Warehouse 2 (Los Angeles) - West Coast hub (10 entries)
  (2, 2, 210, 28),      -- iPhone 15 256GB Black: High stock
  (2, 5, 95, 12),       -- Galaxy S24 256GB Black: Medium stock
  (2, 10, 88, 11),      -- Dell XPS i7: Premium laptop
  (2, 14, 65, 8),       -- AirPods Pro 2 Black: Steady sales
  (2, 25, 380, 55),     -- Nike T-Shirt L Black: Very high stock
  (2, 33, 42, 5),       -- Levis Jeans 34 Black: Medium stock
  (2, 21, 4, 4),        -- Instant Pot 6QT: CRITICAL - 0 available!
  (2, 41, 190, 25),     -- Nike Air Max 11 White: Healthy stock
  (2, 48, 275, 40),     -- Water Bottle Black: High stock
  (2, 12, 3, 2),        -- Lenovo T14: LOW - only 1 available
  
  -- Warehouse 3 (Chicago) - Central distribution (10 entries)
  (3, 3, 145, 18),      -- iPhone 15 128GB Silver: Good stock
  (3, 6, 72, 9),        -- Pixel 8 128GB White: Medium stock
  (3, 9, 105, 14),      -- MacBook Air M3 16GB: Premium stock
  (3, 15, 58, 7),       -- Logitech MX3S Black: Accessory stock
  (3, 26, 0, 0),        -- Nike T-Shirt M White: OUT OF STOCK
  (3, 34, 88, 11),      -- Nike Shorts M Black: Athletic wear
  (3, 20, 125, 16),     -- Dyson V15 Pro: High-end appliance
  (3, 42, 215, 30),     -- Adidas Ultraboost 10: Premium footwear
  (3, 45, 160, 22),     -- Yoga Mat Purple: Fitness equipment
  (3, 17, 6, 5),        -- Samsung T7 2TB: LOW - only 1 available!
  
  -- Warehouse 4 (Dallas) - Texas regional hub (5 entries)
  (4, 7, 95, 12),       -- Pixel 8 256GB Black: Medium stock
  (4, 11, 52, 7),       -- Dell XPS i5: Entry laptop stock
  (4, 22, 0, 0),        -- Instant Pot 8QT: OUT OF STOCK
  (4, 35, 68, 9),       -- Nike Shorts L Gray: Steady stock
  (4, 43, 142, 19),     -- Adidas Ultraboost 11: Good footwear stock
  
  -- Warehouse 18 (Seattle) - Northwest tech hub (5 entries)
  (18, 1, 185, 24),     -- iPhone 15 128GB Black: High demand
  (18, 8, 95, 13),      -- MacBook Air M3 8GB: Tech city stock
  (18, 18, 78, 10),     -- Logitech MX3S White: Tech accessory
  (18, 23, 45, 6),      -- Ninja Blender: Kitchen appliance
  (18, 46, 225, 32),    -- Yoga Mat Blue: Fitness enthusiasts
  
  -- Warehouse 10 (San Jose) - Silicon Valley (5 entries)
  (10, 9, 110, 15),     -- MacBook Air M3 16GB: High tech demand
  (10, 10, 92, 12),     -- Dell XPS i7: Business laptops
  (10, 16, 88, 11),     -- Samsung T7 1TB: Storage needs
  (10, 27, 5, 4),       -- Adidas Hoodie M Gray: LOW - only 1 available
  (10, 44, 2, 2),       -- Vans Old Skool: CRITICAL - 0 available!
  
  -- Warehouse 33 (Atlanta) - Southeast distribution (5 entries)
  (33, 4, 155, 20),     -- Galaxy S24 128GB Gray: Southern market
  (33, 28, 92, 12),     -- Adidas Hoodie L Black: Clothing stock
  (33, 36, 115, 15),    -- Chinos 32 Khaki: Business casual
  (33, 47, 285, 42),    -- Water Bottle Blue: Hydration products
  (33, 50, 195, 28);    -- Water Bottle Black: Popular item

-- =============================================
-- Verification Queries
-- =============================================

-- Count total inventory records
SELECT COUNT(*) as total_inventory_records FROM Inventory;

-- Summary by warehouse
SELECT 
  warehouse_id,
  COUNT(*) as variant_count,
  SUM(on_hand) as total_units,
  SUM(reserved) as total_reserved,
  SUM(on_hand - reserved) as total_available
FROM Inventory
GROUP BY warehouse_id
ORDER BY warehouse_id;

-- Critical low stock alert (less than 5 available)
SELECT 
  warehouse_id,
  variant_id,
  on_hand,
  reserved,
  (on_hand - reserved) as available
FROM Inventory
WHERE (on_hand - reserved) < 5
ORDER BY (on_hand - reserved) ASC;

-- Out of stock items
SELECT 
  warehouse_id,
  variant_id,
  on_hand,
  reserved
FROM Inventory
WHERE on_hand = 0 OR (on_hand - reserved) = 0
ORDER BY warehouse_id, variant_id;

-- Stock level categories
SELECT 
  CASE 
    WHEN (on_hand - reserved) = 0 THEN 'Out of Stock'
    WHEN (on_hand - reserved) < 10 THEN 'Critical Low'
    WHEN (on_hand - reserved) < 50 THEN 'Low Stock'
    WHEN (on_hand - reserved) < 100 THEN 'Medium Stock'
    WHEN (on_hand - reserved) < 200 THEN 'Healthy Stock'
    ELSE 'High Stock'
  END as stock_level,
  COUNT(*) as count
FROM Inventory
GROUP BY stock_level
ORDER BY 
  CASE stock_level
    WHEN 'Out of Stock' THEN 1
    WHEN 'Critical Low' THEN 2
    WHEN 'Low Stock' THEN 3
    WHEN 'Medium Stock' THEN 4
    WHEN 'Healthy Stock' THEN 5
    WHEN 'High Stock' THEN 6
  END;

