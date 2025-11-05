-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 3 - Product Variant Pricing & Inventory Value Analysis
-- Tables: ProductVariants, Products, Categories, Warehouses, Inventory
-- =============================================

-- BUSINESS USE CASE:
-- This query provides strategic pricing and inventory valuation insights for:
-- 1. Financial reporting and balance sheet accuracy
-- 2. Pricing strategy optimization
-- 3. Product portfolio analysis
-- 4. Insurance and audit requirements
-- 5. Tax and regulatory compliance

-- REAL-WORLD SCENARIO:
-- The finance and merchandising teams use this query for:
-- - Monthly financial close to value inventory assets
-- - Pricing decisions: identify overpriced/underpriced items
-- - Product mix optimization: focus on high-value items
-- - Insurance claims: accurate inventory valuation
-- - Strategic planning: which products drive the most value
-- - Markdown/clearance decisions for slow-moving inventory

USE urbanease_shop;

SELECT 
    -- Category & Product Information
    c.name AS category,
    p.product_id,
    p.title AS product_name,
    p.brand,
    
    -- Variant Details
    pv.variant_id,
    pv.sku,
    pv.price AS unit_price,
    pv.currency,
    pv.is_active AS currently_selling,
    
    -- Inventory Aggregation Across All Warehouses
    COUNT(DISTINCT i.warehouse_id) AS warehouses_stocking,
    SUM(i.on_hand) AS total_units_all_warehouses,
    SUM(i.reserved) AS total_reserved_all_warehouses,
    SUM(i.on_hand - i.reserved) AS total_available_all_warehouses,
    
    -- Financial Metrics
    ROUND(SUM(i.on_hand * pv.price), 2) AS total_inventory_value,
    ROUND(SUM(i.reserved * pv.price), 2) AS reserved_inventory_value,
    ROUND(SUM((i.on_hand - i.reserved) * pv.price), 2) AS available_inventory_value,
    
    -- Per-Warehouse Average (for distribution analysis)
    ROUND(AVG(i.on_hand), 2) AS avg_stock_per_warehouse,
    ROUND(AVG(i.on_hand * pv.price), 2) AS avg_value_per_warehouse,
    
    -- Stock Distribution Metrics
    MAX(i.on_hand) AS max_stock_single_warehouse,
    MIN(i.on_hand) AS min_stock_single_warehouse,
    
    -- Business Intelligence Classifications
    CASE 
        WHEN pv.price < 50 THEN 'Budget ($0-$49)'
        WHEN pv.price < 200 THEN 'Mid-Range ($50-$199)'
        WHEN pv.price < 500 THEN 'Premium ($200-$499)'
        WHEN pv.price < 1000 THEN 'Luxury ($500-$999)'
        ELSE 'Ultra-Luxury ($1000+)'
    END AS price_tier,
    
    -- Inventory Value Classification
    CASE 
        WHEN SUM(i.on_hand * pv.price) >= 50000 THEN 'A - High Value Asset'
        WHEN SUM(i.on_hand * pv.price) >= 10000 THEN 'B - Significant Asset'
        WHEN SUM(i.on_hand * pv.price) >= 5000 THEN 'C - Moderate Asset'
        WHEN SUM(i.on_hand * pv.price) >= 1000 THEN 'D - Low Value Asset'
        ELSE 'E - Minimal Asset'
    END AS inventory_value_class,
    
    -- Stock Health by Value
    CASE 
        WHEN SUM(i.on_hand - i.reserved) = 0 THEN 'Out of Stock'
        WHEN SUM(i.on_hand - i.reserved) < 20 THEN 'Low Stock - High Risk'
        WHEN SUM(i.on_hand - i.reserved) < 100 THEN 'Moderate Stock'
        WHEN SUM(i.on_hand - i.reserved) < 300 THEN 'Healthy Stock'
        ELSE 'Overstocked - Consider Promotion'
    END AS stock_health_by_value,
    
    -- Turnover Potential (Reserved / On Hand ratio)
    ROUND(
        (SUM(i.reserved) / NULLIF(SUM(i.on_hand), 0) * 100), 
        2
    ) AS turnover_rate_percent,
    
    -- Strategic Recommendations
    CASE 
        WHEN SUM(i.on_hand - i.reserved) = 0 
            THEN 'URGENT: Restock immediately - losing sales'
        WHEN (SUM(i.reserved) / NULLIF(SUM(i.on_hand), 0)) > 0.30 
            THEN 'HIGH DEMAND: Consider increasing inventory'
        WHEN (SUM(i.reserved) / NULLIF(SUM(i.on_hand), 0)) < 0.05 AND SUM(i.on_hand) > 100
            THEN 'SLOW MOVING: Consider markdown or promotion'
        WHEN SUM(i.on_hand * pv.price) > 20000 AND SUM(i.on_hand) > 200
            THEN 'HIGH VALUE: Monitor carefully, consider insurance'
        ELSE 'STABLE: Continue monitoring'
    END AS strategic_recommendation,
    
    -- Pricing Strategy Insight
    CASE 
        WHEN pv.price < 50 AND SUM(i.on_hand) > 200
            THEN 'Volume Driver - Keep in stock for cross-sells'
        WHEN pv.price > 500 AND SUM(i.on_hand - i.reserved) < 10
            THEN 'High Margin - Prioritize restock'
        WHEN pv.price > 200 AND (SUM(i.reserved) / NULLIF(SUM(i.on_hand), 0)) > 0.25
            THEN 'Premium Performer - Consider price increase'
        WHEN pv.price < 100 AND (SUM(i.reserved) / NULLIF(SUM(i.on_hand), 0)) < 0.05
            THEN 'Low Performer - Review pricing or discontinue'
        ELSE 'Standard Pricing - Monitor trends'
    END AS pricing_strategy,
    
    -- Risk Level for Finance
    CASE 
        WHEN SUM(i.on_hand * pv.price) > 50000 
            THEN 'HIGH - Major balance sheet impact'
        WHEN SUM(i.on_hand * pv.price) > 10000 
            THEN 'MEDIUM - Significant exposure'
        ELSE 'LOW - Minimal impact'
    END AS financial_risk_level

FROM ProductVariants pv
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Categories c ON p.category_id = c.category_id
INNER JOIN Inventory i ON pv.variant_id = i.variant_id
INNER JOIN Warehouses w ON i.warehouse_id = w.warehouse_id

WHERE pv.is_active = TRUE

GROUP BY 
    c.name,
    p.product_id,
    p.title,
    p.brand,
    pv.variant_id,
    pv.sku,
    pv.price,
    pv.currency,
    pv.is_active

HAVING 
    SUM(i.on_hand) > 0  -- Only show variants with actual inventory

ORDER BY 
    total_inventory_value DESC,
    turnover_rate_percent DESC;

-- HOW THIS QUERY HELPS BUSINESS:
-- 1. Finance Team: Monthly inventory valuation for financial statements
-- 2. CFO/Executives: Strategic asset allocation and inventory investment decisions
-- 3. Merchandising: Identifies which products to promote vs. phase out
-- 4. Pricing Team: Data-driven pricing adjustments based on value and turnover
-- 5. Insurance: Accurate inventory value for coverage and claims
-- 6. Auditors: Compliance and verification of inventory assets
-- 7. Tax Department: Accurate inventory valuation for tax reporting
-- 8. Procurement: Prioritizes high-value items for better supplier negotiations
