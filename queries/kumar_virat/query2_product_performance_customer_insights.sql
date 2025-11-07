-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 2 - Product Performance with Customer Reviews and Sales Analysis
-- Tables Used: Products (Pooja), ProductVariants (Virat), Categories (Pooja), Reviews (Diana),
--              OrderItems (Sneha), Orders (Sneha), Users (Bajwa), Inventory (Virat)
-- =============================================

-- BUSINESS USE CASE:
-- This query combines product catalog, customer reviews, sales data, and inventory to provide
-- a comprehensive product performance dashboard. It helps merchandising and marketing teams
-- identify bestsellers, underperformers, and opportunities for improvement.

-- REAL-WORLD SCENARIO:
-- Merchandising team uses this monthly to:
-- - Decide which products to feature in campaigns
-- - Identify products needing review solicitation
-- - Determine which items to discontinue
-- - Plan inventory investments based on customer satisfaction
-- - Optimize product mix by category

USE urbanease_shop;

SELECT 
    -- Category & Product Info (Pooja's tables)
    c.name AS category_name,
    p.product_id,
    p.title AS product_name,
    p.brand AS product_brand,
    p.is_active AS product_active,
    
    -- Variant Pricing (Virat's tables)
    COUNT(DISTINCT pv.variant_id) AS total_variants,
    MIN(pv.price) AS lowest_price_point,
    MAX(pv.price) AS highest_price_point,
    ROUND(AVG(pv.price), 2) AS average_price_point,
    
    -- Customer Reviews (Diana's tables)
    COUNT(DISTINCT r.review_id) AS total_reviews,
    ROUND(AVG(r.rating), 2) AS average_rating,
    SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS five_star_reviews,
    SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END) AS four_star_reviews,
    SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS three_star_reviews,
    SUM(CASE WHEN r.rating <= 2 THEN 1 ELSE 0 END) AS critical_reviews,
    
    -- Sales Performance (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders_containing_product,
    SUM(oi.qty) AS total_units_sold,
    ROUND(SUM(oi.qty * oi.unit_price), 2) AS total_revenue_generated,
    ROUND(AVG(oi.unit_price), 2) AS average_selling_price,
    
    -- Customer Reach (Bajwa + Sneha tables)
    COUNT(DISTINCT o.user_id) AS unique_customers_purchased,
    
    -- Current Inventory Position (Virat's tables)
    SUM(i.on_hand) AS total_stock_on_hand,
    SUM(i.reserved) AS total_stock_reserved,
    SUM(i.on_hand - i.reserved) AS total_available_stock,
    ROUND(SUM(i.on_hand * pv.price), 2) AS current_inventory_value,
    
    -- Review Health Metrics
    CASE 
        WHEN AVG(r.rating) IS NULL THEN 'NO REVIEWS'
        WHEN AVG(r.rating) >= 4.5 THEN 'EXCELLENT (4.5+)'
        WHEN AVG(r.rating) >= 4.0 THEN 'VERY GOOD (4.0-4.4)'
        WHEN AVG(r.rating) >= 3.5 THEN 'GOOD (3.5-3.9)'
        WHEN AVG(r.rating) >= 3.0 THEN 'AVERAGE (3.0-3.4)'
        ELSE 'BELOW AVERAGE (<3.0)'
    END AS review_rating_class,
    
    -- Review Volume Assessment
    CASE 
        WHEN COUNT(DISTINCT r.review_id) = 0 THEN 'CRITICAL: No Reviews - Needs Attention'
        WHEN COUNT(DISTINCT r.review_id) < 5 THEN 'LOW: Needs More Reviews'
        WHEN COUNT(DISTINCT r.review_id) < 10 THEN 'MODERATE: Building Credibility'
        WHEN COUNT(DISTINCT r.review_id) < 20 THEN 'GOOD: Strong Social Proof'
        ELSE 'EXCELLENT: High Engagement'
    END AS review_volume_status,
    
    -- Sales Performance Classification
    CASE 
        WHEN SUM(oi.qty) IS NULL OR SUM(oi.qty) = 0 THEN 'NO SALES'
        WHEN SUM(oi.qty) >= 50 THEN 'BESTSELLER'
        WHEN SUM(oi.qty) >= 20 THEN 'STRONG SELLER'
        WHEN SUM(oi.qty) >= 10 THEN 'MODERATE SELLER'
        WHEN SUM(oi.qty) >= 5 THEN 'SLOW MOVER'
        ELSE 'POOR PERFORMER'
    END AS sales_performance_tier,
    
    -- Stock Health vs Sales Velocity
    CASE 
        WHEN SUM(oi.qty) > 0 AND SUM(i.on_hand - i.reserved) = 0 
            THEN 'URGENT: Out of Stock & Selling'
        WHEN SUM(oi.qty) > 20 AND SUM(i.on_hand - i.reserved) < 50 
            THEN 'WARNING: High Sales, Low Stock'
        WHEN SUM(oi.qty) < 5 AND SUM(i.on_hand) > 100 
            THEN 'OVERSTOCKED: Low Sales, High Inventory'
        WHEN SUM(i.on_hand - i.reserved) > 0 AND SUM(oi.qty) > 10 
            THEN 'HEALTHY: Good Balance'
        ELSE 'MONITOR'
    END AS inventory_sales_alignment,
    
    -- Customer Satisfaction Score (combining rating and sales)
    CASE 
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 
            THEN 'STAR PRODUCT: High Rating & High Sales'
        WHEN AVG(r.rating) >= 4.0 AND SUM(oi.qty) >= 10 
            THEN 'SOLID PERFORMER: Good Rating & Good Sales'
        WHEN AVG(r.rating) IS NULL AND SUM(oi.qty) >= 20 
            THEN 'SELLING WELL: Needs Reviews for Credibility'
        WHEN AVG(r.rating) < 3.0 AND SUM(oi.qty) < 5 
            THEN 'PROBLEM PRODUCT: Poor Rating & Weak Sales'
        WHEN AVG(r.rating) >= 4.0 AND (SUM(oi.qty) IS NULL OR SUM(oi.qty) < 5) 
            THEN 'HIDDEN GEM: Good Rating but Low Visibility'
        ELSE 'NEEDS ANALYSIS'
    END AS product_health_status,
    
    -- Revenue Performance
    CASE 
        WHEN SUM(oi.qty * oi.unit_price) >= 10000 THEN 'TOP REVENUE DRIVER'
        WHEN SUM(oi.qty * oi.unit_price) >= 5000 THEN 'STRONG REVENUE CONTRIBUTOR'
        WHEN SUM(oi.qty * oi.unit_price) >= 1000 THEN 'MODERATE REVENUE'
        WHEN SUM(oi.qty * oi.unit_price) > 0 THEN 'MINOR REVENUE'
        ELSE 'NO REVENUE'
    END AS revenue_contribution,
    
    -- Strategic Actions Recommended
    CASE 
        WHEN AVG(r.rating) IS NULL AND SUM(oi.qty) > 0 
            THEN 'ACTION: Solicit reviews from recent buyers'
        WHEN AVG(r.rating) < 3.0 
            THEN 'ACTION: Investigate quality issues, consider removal'
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 
            THEN 'ACTION: Feature in marketing campaigns'
        WHEN SUM(i.on_hand - i.reserved) = 0 AND SUM(oi.qty) > 0 
            THEN 'ACTION: Emergency restock - high demand'
        WHEN SUM(oi.qty) < 5 AND SUM(i.on_hand) > 100 
            THEN 'ACTION: Run promotion or consider clearance'
        WHEN AVG(r.rating) >= 4.0 AND SUM(oi.qty) < 5 
            THEN 'ACTION: Increase visibility - good product, low sales'
        ELSE 'ACTION: Monitor performance trends'
    END AS recommended_action,
    
    -- Price-to-Rating Optimization
    CASE 
        WHEN AVG(pv.price) < 100 AND AVG(r.rating) >= 4.5 
            THEN 'OPPORTUNITY: Consider price increase'
        WHEN AVG(pv.price) > 500 AND AVG(r.rating) < 3.5 
            THEN 'RISK: High price, low satisfaction'
        WHEN AVG(pv.price) > 200 AND AVG(r.rating) >= 4.5 
            THEN 'PREMIUM JUSTIFIED: High price, high satisfaction'
        ELSE 'STANDARD PRICING'
    END AS pricing_strategy_insight

FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN ProductVariants pv ON p.product_id = pv.product_id AND pv.is_active = TRUE
LEFT JOIN Reviews r ON p.product_id = r.product_id
LEFT JOIN OrderItems oi ON pv.variant_id = oi.variant_id
LEFT JOIN Orders o ON oi.order_id = o.order_id 
    AND o.status IN ('PAID', 'FULFILLED') 
    AND o.placed_at >= DATE_SUB(NOW(), INTERVAL 90 DAY)
LEFT JOIN Inventory i ON pv.variant_id = i.variant_id

WHERE p.is_active = TRUE

GROUP BY 
    c.name, p.product_id, p.title, p.brand, p.is_active

ORDER BY 
    CASE 
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 THEN 1  -- Star products first
        WHEN SUM(oi.qty) > 0 AND SUM(i.on_hand - i.reserved) = 0 THEN 2  -- Out of stock sellers
        WHEN AVG(r.rating) < 3.0 THEN 3  -- Problem products
        ELSE 4
    END,
    total_revenue_generated DESC,
    average_rating DESC;

-- BUSINESS VALUE:
-- 1. Merchandising: Identifies products to promote or discontinue
-- 2. Marketing: Finds star products for campaigns
-- 3. Customer Success: Identifies products needing quality improvement
-- 4. Inventory Planning: Aligns stock with demand and satisfaction
-- 5. Pricing Strategy: Optimizes pricing based on customer feedback
-- 6. Executive Dashboard: Product portfolio health overview

