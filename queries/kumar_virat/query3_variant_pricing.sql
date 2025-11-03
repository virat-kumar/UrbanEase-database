-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Query 3 - Product Variant Pricing Analysis
-- Tables: ProductVariants, Warehouses, Inventory
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Analyze variant pricing and total inventory value

/*
SELECT 
    pv.sku,
    pv.price,
    pv.currency,
    SUM(i.on_hand) as total_stock,
    (pv.price * SUM(i.on_hand)) as inventory_value
FROM ProductVariants pv
-- Add your JOINs and WHERE clauses
;
*/

