-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 2 - Low Stock Alert System with Reorder Recommendations
-- Tables: ProductVariants, Products, Warehouses, Inventory
-- =============================================

-- BUSINESS USE CASE:
-- This query serves as an automated alert system for procurement and inventory teams
-- to identify products requiring immediate attention. It helps:
-- 1. Prevent stockouts that lead to lost sales
-- 2. Calculate optimal reorder quantities
-- 3. Prioritize which items to restock first
-- 4. Identify products at risk across multiple locations

-- REAL-WORLD SCENARIO:
-- The procurement manager runs this query every 4 hours to:
-- - Generate purchase orders for suppliers
-- - Allocate emergency stock transfers between warehouses
-- - Alert sales team about products that shouldn't be promoted
-- - Send notifications to suppliers about urgent needs
-- - Prepare for seasonal demand spikes

USE urbanease_shop;

SELECT 
    -- Priority Ranking
    ROW_NUMBER() OVER (ORDER BY 
        CASE 
            WHEN (i.on_hand - i.reserved) = 0 THEN 1
            WHEN (i.on_hand - i.reserved) < 5 THEN 2
            WHEN (i.on_hand - i.reserved) < 10 THEN 3
            ELSE 4
        END,
        (pv.price * i.reserved) DESC
    ) AS priority_rank,
    
    -- Alert Level
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 THEN '🚨 CRITICAL'
        WHEN (i.on_hand - i.reserved) <= 5 THEN '⚠️  URGENT'
        WHEN (i.on_hand - i.reserved) <= 10 THEN '⚡ WARNING'
        WHEN (i.on_hand - i.reserved) <= 25 THEN '📊 WATCH'
        ELSE '✓ OK'
    END AS alert_level,
    
    -- Product Details
    p.product_id,
    p.title AS product_name,
    p.brand,
    pv.sku,
    pv.price,
    
    -- Warehouse Information
    w.warehouse_id,
    w.name AS warehouse_name,
    CONCAT(w.city, ', ', w.state_region) AS location,
    
    -- Current Stock Situation
    i.on_hand AS current_stock,
    i.reserved AS reserved_orders,
    (i.on_hand - i.reserved) AS available_now,
    
    -- Business Impact Metrics
    ROUND((pv.price * i.reserved), 2) AS pending_order_value,
    ROUND((pv.price * (i.on_hand - i.reserved)), 2) AS available_inventory_value,
    
    -- Risk Assessment
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 AND i.reserved > 0 
            THEN 'IMMEDIATE: Cannot fulfill pending orders'
        WHEN (i.on_hand - i.reserved) < 5 
            THEN 'HIGH RISK: May run out within 24 hours'
        WHEN (i.on_hand - i.reserved) <= 10 
            THEN 'MODERATE RISK: May run out within 3-5 days'
        WHEN (i.on_hand - i.reserved) <= 25 
            THEN 'LOW RISK: Monitor closely'
        ELSE 'STABLE'
    END AS risk_assessment,
    
    -- Reorder Recommendations
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 
            THEN GREATEST(100, i.reserved * 3)  -- Emergency reorder
        WHEN (i.on_hand - i.reserved) <= 5 
            THEN GREATEST(75, i.reserved * 2)   -- Urgent reorder
        WHEN (i.on_hand - i.reserved) <= 10 
            THEN GREATEST(50, (i.on_hand + i.reserved))  -- Standard reorder
        ELSE 25  -- Safety stock
    END AS suggested_reorder_qty,
    
    -- Financial Impact
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 
            THEN ROUND(pv.price * GREATEST(100, i.reserved * 3), 2)
        WHEN (i.on_hand - i.reserved) <= 5 
            THEN ROUND(pv.price * GREATEST(75, i.reserved * 2), 2)
        WHEN (i.on_hand - i.reserved) <= 10 
            THEN ROUND(pv.price * GREATEST(50, (i.on_hand + i.reserved)), 2)
        ELSE ROUND(pv.price * 25, 2)
    END AS estimated_reorder_cost,
    
    -- Days Until Stockout (assuming steady demand)
    CASE 
        WHEN i.reserved = 0 THEN 'N/A - No active demand'
        WHEN (i.on_hand - i.reserved) <= 0 THEN '0 days - OUT NOW'
        ELSE CONCAT(
            ROUND((i.on_hand - i.reserved) / NULLIF(i.reserved, 0) * 7, 1),
            ' days'
        )
    END AS estimated_days_until_stockout,
    
    -- Action Items
    CASE 
        WHEN (i.on_hand - i.reserved) = 0 
            THEN '1. Create emergency PO | 2. Contact supplier | 3. Check other warehouses'
        WHEN (i.on_hand - i.reserved) <= 5 
            THEN '1. Expedite reorder | 2. Reserve from other locations | 3. Alert sales team'
        WHEN (i.on_hand - i.reserved) <= 10 
            THEN '1. Standard reorder | 2. Monitor daily | 3. Update forecasts'
        WHEN (i.on_hand - i.reserved) <= 25 
            THEN '1. Plan reorder | 2. Review demand trends'
        ELSE 'Monitor weekly'
    END AS recommended_actions

FROM Inventory i
INNER JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
INNER JOIN ProductVariants pv ON i.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id

WHERE 
    pv.is_active = TRUE
    AND (i.on_hand - i.reserved) <= 25  -- Only show items with <= 25 available
    
ORDER BY 
    priority_rank;

-- HOW THIS QUERY HELPS BUSINESS:
-- 1. Procurement: Generates daily purchase order priorities
-- 2. Finance: Calculates immediate cash flow needs for inventory
-- 3. Operations: Prevents stockouts and maintains service levels
-- 4. Sales: Knows which items to avoid promoting due to low stock
-- 5. Customer Service: Sets realistic delivery expectations
-- 6. Management: Tracks inventory health KPIs and risk exposure
