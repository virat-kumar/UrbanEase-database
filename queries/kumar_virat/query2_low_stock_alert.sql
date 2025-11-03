-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Query 2 - Low Stock Alert
-- Tables: ProductVariants, Warehouses, Inventory
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Find products with low stock (available < threshold)

/*
SELECT 
    pv.sku,
    w.name as warehouse_name,
    i.on_hand,
    i.reserved,
    (i.on_hand - i.reserved) as available
FROM ProductVariants pv
-- Add your JOINs and WHERE clauses
-- WHERE (i.on_hand - i.reserved) < 10  -- Example threshold
;
*/

