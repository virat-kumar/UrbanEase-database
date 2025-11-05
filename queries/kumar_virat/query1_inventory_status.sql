-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 1 - Comprehensive Inventory Status Dashboard
-- Tables: ProductVariants, Products, Warehouses, Inventory
-- =============================================

-- BUSINESS USE CASE:
-- This query provides a comprehensive inventory dashboard for warehouse managers
-- and inventory planners to make informed decisions about:
-- 1. Stock distribution across warehouses
-- 2. Inventory health and availability
-- 3. Reorder priorities based on stock levels
-- 4. Warehouse capacity utilization

-- REAL-WORLD SCENARIO:
-- Every morning, the inventory manager runs this query to:
-- - Identify which products are well-stocked vs. running low
-- - Determine if stock needs to be transferred between warehouses
-- - Plan procurement for the day/week ahead
-- - Optimize warehouse space allocation

USE urbanease_shop;

SELECT 
    -- Warehouse Information
    w.warehouse_id,
    w.name AS warehouse_name,
    w.code AS warehouse_code,
    CONCAT(w.city, ', ', w.state_region) AS warehouse_location,
    
    -- Product Information
    p.product_id,
    p.title AS product_name,
    p.brand,
    pv.variant_id,
    pv.sku,
    pv.price,
    pv.currency,
    
    -- Stock Metrics
    i.on_hand AS total_stock,
    i.reserved AS reserved_stock,
    (i.on_hand - i.reserved) AS available_stock,
    
    -- Business Intelligence Metrics
    ROUND((i.reserved / NULLIF(i.on_hand, 0) * 100), 2) AS reservation_rate_percent,
    ROUND((i.on_hand * pv.price), 2) AS inventory_value,
    
    -- Stock Health Classification
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 THEN 'OUT OF STOCK'
        WHEN (i.on_hand - i.reserved) < 10 THEN 'CRITICAL LOW'
        WHEN (i.on_hand - i.reserved) < 50 THEN 'LOW STOCK'
        WHEN (i.on_hand - i.reserved) < 100 THEN 'MEDIUM STOCK'
        WHEN (i.on_hand - i.reserved) < 200 THEN 'HEALTHY STOCK'
        ELSE 'HIGH STOCK'
    END AS stock_status,
    
    -- Action Required Flag
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 THEN 'URGENT: Restock Immediately'
        WHEN (i.on_hand - i.reserved) < 10 THEN 'HIGH: Reorder Now'
        WHEN (i.on_hand - i.reserved) < 50 THEN 'MEDIUM: Plan Restock'
        ELSE 'LOW: Monitor'
    END AS action_priority,
    
    -- Fulfillment Capacity
    CASE 
        WHEN (i.on_hand - i.reserved) >= 100 THEN 'Can fulfill large orders'
        WHEN (i.on_hand - i.reserved) >= 50 THEN 'Can fulfill medium orders'
        WHEN (i.on_hand - i.reserved) >= 10 THEN 'Limited to small orders'
        ELSE 'Cannot fulfill orders'
    END AS fulfillment_capacity

FROM Inventory i
INNER JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
INNER JOIN ProductVariants pv ON i.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id

WHERE pv.is_active = TRUE  -- Only show active products

ORDER BY 
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 THEN 1
        WHEN (i.on_hand - i.reserved) < 10 THEN 2
        WHEN (i.on_hand - i.reserved) < 50 THEN 3
        ELSE 4
    END,
    w.warehouse_id,
    p.title;

-- HOW THIS QUERY HELPS BUSINESS:
-- 1. Operations Team: Prioritizes restocking based on action_priority
-- 2. Finance Team: Tracks inventory value per warehouse for accounting
-- 3. Sales Team: Knows fulfillment capacity before promising delivery dates
-- 4. Procurement Team: Uses stock_status to plan purchase orders
-- 5. Warehouse Managers: Optimizes space based on stock levels
