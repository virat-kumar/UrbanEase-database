-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Query 1 - Inventory Status by Warehouse
-- Tables: ProductVariants, Warehouses, Inventory
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Get inventory status across all warehouses

/*
SELECT 
    w.name as warehouse_name,
    pv.sku,
    i.on_hand,
    i.reserved,
    (i.on_hand - i.reserved) as available
FROM Warehouses w
-- Add your JOINs and WHERE clauses
;
*/

