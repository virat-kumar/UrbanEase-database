-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 4 - Comprehensive Revenue & Profitability Dashboard
-- Tables Used: Orders (Sneha), OrderItems (Sneha), Payments (Diana), ProductVariants (Virat),
--              Products (Pooja), Categories (Pooja), Users (Bajwa), Coupons (Min), Shipments (Sneha)
-- =============================================

-- BUSINESS USE CASE:
-- This query provides executive-level financial insights by combining orders, payments,
-- product costs, discounts, and shipping to calculate true profitability metrics.
-- It helps CFO and finance teams understand revenue streams, margins, and cost drivers.

-- REAL-WORLD SCENARIO:
-- Finance team uses this for:
-- - Monthly financial reporting and board presentations
-- - Identifying most/least profitable product categories
-- - Analyzing discount impact on margins
-- - Calculating customer acquisition cost vs. lifetime value
-- - Optimizing pricing and promotional strategies

USE urbanease_shop;

SELECT 
    -- Time Period Analysis
    DATE_FORMAT(o.placed_at, '%Y-%m') AS order_month,
    DATE_FORMAT(o.placed_at, '%Y-Q%q') AS order_quarter,
    YEAR(o.placed_at) AS order_year,
    DAYNAME(o.placed_at) AS order_day_of_week,
    
    -- Category Performance (Pooja's tables)
    c.name AS product_category,
    
    -- Order Metrics (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT o.user_id), 2) AS orders_per_customer,
    
    -- Order Status Distribution
    SUM(CASE WHEN o.status = 'PAID' THEN 1 ELSE 0 END) AS orders_paid,
    SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) AS orders_fulfilled,
    SUM(CASE WHEN o.status = 'PENDING' THEN 1 ELSE 0 END) AS orders_pending,
    SUM(CASE WHEN o.status = 'CANCELLED' THEN 1 ELSE 0 END) AS orders_cancelled,
    SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) AS orders_refunded,
    
    -- Revenue Metrics
    ROUND(SUM(o.subtotal_amount), 2) AS gross_merchandise_value,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts_given,
    ROUND(SUM(o.shipping_amount), 2) AS total_shipping_charged,
    ROUND(SUM(o.tax_amount), 2) AS total_tax_collected,
    ROUND(SUM(o.grand_total_amount), 2) AS total_revenue,
    
    -- Average Order Metrics
    ROUND(AVG(o.subtotal_amount), 2) AS avg_order_subtotal,
    ROUND(AVG(o.grand_total_amount), 2) AS avg_order_value,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount_per_order,
    
    -- Product & Unit Metrics (Virat + Sneha tables)
    SUM(oi.qty) AS total_units_sold,
    ROUND(AVG(oi.unit_price), 2) AS avg_unit_selling_price,
    COUNT(DISTINCT p.product_id) AS unique_products_sold,
    COUNT(DISTINCT pv.variant_id) AS unique_variants_sold,
    
    -- Discount Analysis (Min's tables - coupon impact)
    COUNT(DISTINCT o.coupon_id) AS orders_with_coupons,
    ROUND(
        (COUNT(DISTINCT o.coupon_id) / COUNT(DISTINCT o.order_id) * 100), 
        2
    ) AS coupon_usage_rate_percent,
    ROUND(
        (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100), 
        2
    ) AS avg_discount_rate_percent,
    
    -- Payment Success Metrics (Diana's tables)
    COUNT(DISTINCT CASE WHEN pay.status = 'CAPTURED' THEN pay.payment_id END) AS successful_payments,
    COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) AS failed_payments,
    COUNT(DISTINCT CASE WHEN pay.status = 'REFUNDED' THEN pay.payment_id END) AS refunded_payments,
    ROUND(
        (COUNT(DISTINCT CASE WHEN pay.status = 'CAPTURED' THEN pay.payment_id END) / 
         NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100), 
        2
    ) AS payment_success_rate_percent,
    
    -- Payment Provider Distribution
    SUM(CASE WHEN pay.provider = 'Stripe' THEN pay.amount ELSE 0 END) AS stripe_revenue,
    SUM(CASE WHEN pay.provider = 'PayPal' THEN pay.amount ELSE 0 END) AS paypal_revenue,
    SUM(CASE WHEN pay.provider = 'Square' THEN pay.amount ELSE 0 END) AS square_revenue,
    
    -- Shipping Performance (Sneha's Shipments table)
    COUNT(DISTINCT s.shipment_id) AS total_shipments,
    SUM(CASE WHEN s.status = 'DELIVERED' THEN 1 ELSE 0 END) AS shipments_delivered,
    ROUND(
        AVG(CASE 
            WHEN s.delivered_at IS NOT NULL AND s.shipped_at IS NOT NULL 
            THEN DATEDIFF(s.delivered_at, s.shipped_at)
            ELSE NULL
        END), 
        2
    ) AS avg_delivery_days,
    
    -- Profitability Metrics (Estimates)
    -- Net Revenue = Total Revenue - Discounts
    ROUND(SUM(o.grand_total_amount) - SUM(o.discount_amount), 2) AS net_revenue_after_discounts,
    
    -- Revenue Per Unit
    ROUND(
        SUM(o.grand_total_amount) / NULLIF(SUM(oi.qty), 0), 
        2
    ) AS revenue_per_unit_sold,
    
    -- Discount Efficiency (Revenue impact)
    ROUND(
        (SUM(o.grand_total_amount) / NULLIF(SUM(o.discount_amount), 0)), 
        2
    ) AS revenue_dollars_per_discount_dollar,
    
    -- Category Performance Indicators
    CASE 
        WHEN SUM(o.grand_total_amount) >= 50000 THEN 'TOP REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 20000 THEN 'HIGH REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 10000 THEN 'MEDIUM REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 5000 THEN 'LOW-MEDIUM REVENUE CATEGORY'
        ELSE 'LOW REVENUE CATEGORY'
    END AS category_revenue_tier,
    
    -- Discount Strategy Assessment
    CASE 
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 20 
            THEN 'HIGH DISCOUNT DEPENDENCY - Review Strategy'
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 10 
            THEN 'MODERATE DISCOUNTING - Acceptable'
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 5 
            THEN 'LOW DISCOUNTING - Healthy Margins'
        ELSE 'MINIMAL DISCOUNTING - Premium Pricing'
    END AS discount_strategy_health,
    
    -- Order Fulfillment Efficiency
    CASE 
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 80 
            THEN 'EXCELLENT FULFILLMENT (>80%)'
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 60 
            THEN 'GOOD FULFILLMENT (60-80%)'
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 40 
            THEN 'NEEDS IMPROVEMENT (40-60%)'
        ELSE 'POOR FULFILLMENT (<40%)'
    END AS fulfillment_performance,
    
    -- Payment Processing Health
    CASE 
        WHEN (COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) / 
              NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100) > 10 
            THEN 'HIGH FAILURE RATE - Check Payment Gateway'
        WHEN (COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) / 
              NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100) > 5 
            THEN 'ELEVATED FAILURE RATE - Monitor Closely'
        ELSE 'HEALTHY PAYMENT PROCESSING'
    END AS payment_processing_health,
    
    -- Return/Refund Rate Analysis
    CASE 
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 10 
            THEN 'HIGH RETURN RATE - Quality Issue'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 5 
            THEN 'ELEVATED RETURNS - Investigate'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 2 
            THEN 'NORMAL RETURN RATE'
        ELSE 'LOW RETURN RATE - Excellent'
    END AS return_rate_assessment,
    
    -- Growth Indicators
    CASE 
        WHEN COUNT(DISTINCT o.order_id) >= 50 THEN 'HIGH VOLUME PERIOD'
        WHEN COUNT(DISTINCT o.order_id) >= 20 THEN 'MEDIUM VOLUME PERIOD'
        WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 'LOW VOLUME PERIOD'
        ELSE 'MINIMAL VOLUME PERIOD'
    END AS order_volume_classification,
    
    -- Strategic Recommendations
    CASE 
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 15 
            AND AVG(o.grand_total_amount) < 100 
            THEN 'STRATEGY: Reduce discounts, focus on value perception'
        WHEN AVG(o.grand_total_amount) >= 500 
            AND (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) < 5 
            THEN 'STRATEGY: Premium segment - maintain pricing power'
        WHEN COUNT(DISTINCT o.user_id) < 20 
            THEN 'STRATEGY: Focus on customer acquisition'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 8 
            THEN 'STRATEGY: Investigate product quality/fit issues'
        WHEN (COUNT(DISTINCT pay.payment_id) / NULLIF(COUNT(DISTINCT o.order_id), 0)) < 0.95 
            THEN 'STRATEGY: Improve payment gateway or offer more payment options'
        ELSE 'STRATEGY: Scale current operations'
    END AS strategic_recommendation

FROM Orders o
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipments s ON o.order_id = s.order_id

WHERE 
    o.placed_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)  -- Last 6 months
    AND o.status NOT IN ('CANCELLED')  -- Exclude cancelled orders

GROUP BY 
    DATE_FORMAT(o.placed_at, '%Y-%m'),
    DATE_FORMAT(o.placed_at, '%Y-Q%q'),
    YEAR(o.placed_at),
    DAYNAME(o.placed_at),
    c.name

ORDER BY 
    order_year DESC,
    order_month DESC,
    total_revenue DESC;

-- BUSINESS VALUE:
-- 1. CFO/Finance: Comprehensive P&L insights and margin analysis
-- 2. Executives: Strategic decision-making on pricing and promotions
-- 3. Category Managers: Category performance benchmarking
-- 4. Marketing: ROI on discount campaigns and promotional strategies
-- 5. Operations: Fulfillment efficiency and bottleneck identification
-- 6. Investors: Business health and growth trajectory metrics

