-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Sample Data for Inventory Table (35 entries)
-- Module: Inventory Management
-- Note: Requires Warehouses and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 inventory records across different warehouses and variants
-- Each record tracks on_hand and reserved quantities
INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved) VALUES
-- NYC Warehouse (warehouse_id = 1)
(1, 1, 45, 5),    -- MacBook Pro Space Gray
(1, 3, 120, 15),  -- iPhone Blue
(1, 5, 200, 25),  -- T-Shirt M Black
(1, 9, 30, 2),    -- Sofa Grey
(1, 11, 85, 10),  -- Face Serum

-- LA Warehouse (warehouse_id = 2)
(2, 2, 38, 4),    -- MacBook Pro Silver
(2, 4, 95, 12),   -- iPhone Natural
(2, 6, 180, 20),  -- T-Shirt L Blue
(2, 12, 60, 8),   -- Shampoo
(2, 15, 150, 18), -- Dumbbells

-- Chicago Warehouse (warehouse_id = 3)
(3, 7, 75, 9),    -- Dress S
(3, 8, 65, 7),    -- Dress M
(3, 10, 40, 3),   -- Wall Art
(3, 13, 110, 14), -- Multivitamin
(3, 16, 50, 5),   -- Tent

-- Houston Warehouse (warehouse_id = 4)
(4, 17, 140, 16), -- Shorts M
(4, 18, 125, 13), -- Shorts L
(4, 19, 90, 11),  -- Board Game
(4, 20, 70, 8),   -- Action Figure
(4, 21, 160, 19), -- Phone Mount

-- Phoenix Warehouse (warehouse_id = 5)
(5, 22, 55, 6),   -- Gloves
(5, 23, 200, 24), -- Novel
(5, 24, 80, 9),   -- Journal
(5, 25, 300, 35), -- Trail Mix
(5, 26, 250, 28), -- Yogurt

-- Philadelphia Warehouse (warehouse_id = 6)
(6, 27, 175, 21), -- Baby Onesie
(6, 28, 220, 26), -- Baby Wipes
(6, 29, 45, 5),   -- Necklace
(6, 30, 65, 7),   -- Earrings
(6, 31, 85, 10),  -- Oxford Shoes

-- San Antonio Warehouse (warehouse_id = 7)
(7, 32, 95, 11),  -- High Heels
(7, 33, 40, 4),   -- Dog Food
(7, 34, 55, 6),   -- Cat Tree
(7, 35, 15, 2);   -- Watercolor Set

-- Verify inserted data
SELECT COUNT(*) AS total_inventory_records FROM Inventory;
SELECT 
    w.name AS warehouse, 
    pv.sku, 
    i.on_hand, 
    i.reserved,
    (i.on_hand - i.reserved) AS available
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN ProductVariants pv ON i.variant_id = pv.variant_id
LIMIT 10;
