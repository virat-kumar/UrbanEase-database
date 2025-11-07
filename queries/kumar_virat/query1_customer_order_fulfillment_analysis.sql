-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 1 - End-to-End Customer Order Fulfillment Analysis
-- Tables Used: Users (Bajwa), Orders (Sneha), OrderItems (Sneha), Shipments (Sneha), 
--              ProductVariants (Virat), Products (Pooja), Warehouses (Virat), Payments (Diana)
-- =============================================

-- BUSINESS USE CASE:
-- This query provides a complete customer order lifecycle view for operations teams
-- to track fulfillment performance, identify bottlenecks, and improve customer satisfaction.
-- It combines user data, order processing, inventory allocation, shipping, and payment status.

-- REAL-WORLD SCENARIO:
-- Operations managers use this query daily to:
-- - Monitor order-to-delivery time across different warehouses
-- - Identify delayed shipments and take corrective action
-- - Track which customers receive fastest service
-- - Analyze payment and fulfillment correlation
-- - Optimize warehouse allocation based on customer location

USE urbanease_shop;

SELECT 
    -- Customer Information (Bajwa's tables)
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS customer_active_status,
    
    -- Order Information (Sneha's tables)
    o.order_id,
    o.status AS order_status,
    o.placed_at AS order_date,
    DATE_FORMAT(o.placed_at, '%Y-%m-%d') AS order_date_formatted,
    o.subtotal_amount,
    o.discount_amount,
    o.shipping_amount,
    o.tax_amount,
    o.grand_total_amount,
    
    -- Order Item Details (Sneha + Virat + Pooja tables)
    COUNT(DISTINCT oi.order_item_id) AS total_line_items,
    SUM(oi.qty) AS total_units_ordered,
    GROUP_CONCAT(DISTINCT p.title SEPARATOR ', ') AS products_ordered,
    GROUP_CONCAT(DISTINCT p.brand SEPARATOR ', ') AS brands_ordered,
    
    -- Payment Information (Diana's tables)
    pay.provider AS payment_provider,
    pay.status AS payment_status,
    pay.paid_at AS payment_date,
    DATEDIFF(pay.paid_at, o.placed_at) AS days_to_payment,
    
    -- Shipment Information (Sneha + Virat tables)
    s.shipment_id,
    w.name AS fulfillment_warehouse,
    CONCAT(w.city, ', ', w.state_region) AS warehouse_location,
    s.carrier AS shipping_carrier,
    s.tracking_no AS tracking_number,
    s.status AS shipment_status,
    s.shipped_at AS ship_date,
    s.delivered_at AS delivery_date,
    
    -- Performance Metrics
    DATEDIFF(s.shipped_at, o.placed_at) AS days_order_to_ship,
    DATEDIFF(s.delivered_at, s.shipped_at) AS days_ship_to_delivery,
    DATEDIFF(s.delivered_at, o.placed_at) AS total_fulfillment_days,
    
    -- SLA Performance Classification
    CASE 
        WHEN s.delivered_at IS NULL AND s.status = 'DELIVERED' THEN 'Data Issue'
        WHEN s.delivered_at IS NULL THEN 'In Progress'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 2 THEN 'EXCELLENT (<=2 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 5 THEN 'GOOD (3-5 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 7 THEN 'ACCEPTABLE (6-7 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 10 THEN 'SLOW (8-10 days)'
        ELSE 'CRITICAL DELAY (>10 days)'
    END AS delivery_performance,
    
    -- Order Value Classification
    CASE 
        WHEN o.grand_total_amount >= 1000 THEN 'HIGH VALUE'
        WHEN o.grand_total_amount >= 500 THEN 'MEDIUM-HIGH VALUE'
        WHEN o.grand_total_amount >= 200 THEN 'MEDIUM VALUE'
        WHEN o.grand_total_amount >= 100 THEN 'LOW-MEDIUM VALUE'
        ELSE 'LOW VALUE'
    END AS order_value_tier,
    
    -- Fulfillment Status Analysis
    CASE 
        WHEN o.status = 'FULFILLED' AND s.status = 'DELIVERED' THEN 'Complete & Delivered'
        WHEN o.status = 'PAID' AND s.status = 'IN_TRANSIT' THEN 'Paid & In Transit'
        WHEN o.status = 'PAID' AND s.status = 'PICKED' THEN 'Paid & Ready to Ship'
        WHEN o.status = 'PAID' AND s.status = 'CREATED' THEN 'Paid & Awaiting Pickup'
        WHEN o.status = 'PENDING' THEN 'Payment Pending'
        WHEN o.status = 'CANCELLED' THEN 'Order Cancelled'
        WHEN o.status = 'REFUNDED' THEN 'Order Refunded'
        ELSE 'Status Mismatch - Review Needed'
    END AS fulfillment_pipeline_status,
    
    -- Risk Flags
    CASE 
        WHEN o.status = 'PAID' AND pay.status != 'CAPTURED' THEN 'RISK: Payment Not Captured'
        WHEN o.status = 'PAID' AND s.status = 'CREATED' AND DATEDIFF(NOW(), o.placed_at) > 2 THEN 'RISK: Delayed Pickup'
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) > 7 THEN 'RISK: Transit Delay'
        WHEN o.grand_total_amount > 500 AND s.carrier = 'USPS' THEN 'WATCH: High Value USPS'
        ELSE 'Normal'
    END AS risk_flag,
    
    -- Customer Satisfaction Predictor
    CASE 
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) <= 3 
            THEN 'High Satisfaction Expected'
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) <= 7 
            THEN 'Moderate Satisfaction Expected'
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) > 7 
            THEN 'Low Satisfaction - Follow Up Needed'
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) <= 3 
            THEN 'On Track'
        WHEN s.status IN ('CREATED', 'PICKED') AND DATEDIFF(NOW(), o.placed_at) > 2 
            THEN 'At Risk - Expedite Needed'
        ELSE 'Monitor Closely'
    END AS satisfaction_predictor

FROM Orders o
INNER JOIN Users u ON o.user_id = u.user_id
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipments s ON o.order_id = s.order_id
LEFT JOIN Warehouses w ON s.warehouse_id = w.warehouse_id

WHERE 
    o.placed_at >= DATE_SUB(NOW(), INTERVAL 90 DAY)  -- Last 90 days
    AND o.status NOT IN ('CANCELLED', 'REFUNDED')      -- Exclude cancelled orders

GROUP BY 
    u.user_id, u.full_name, u.email, u.phone, u.is_active,
    o.order_id, o.status, o.placed_at, o.subtotal_amount, o.discount_amount, 
    o.shipping_amount, o.tax_amount, o.grand_total_amount,
    pay.provider, pay.status, pay.paid_at,
    s.shipment_id, w.name, w.city, w.state_region,
    s.carrier, s.tracking_no, s.status, s.shipped_at, s.delivered_at

ORDER BY 
    CASE 
        WHEN o.status = 'PAID' AND s.status = 'CREATED' AND DATEDIFF(NOW(), o.placed_at) > 2 THEN 1
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) > 7 THEN 2
        WHEN o.status = 'PENDING' THEN 3
        ELSE 4
    END,
    o.placed_at DESC;

-- BUSINESS VALUE:
-- 1. Operations: Identifies bottlenecks in fulfillment pipeline
-- 2. Customer Service: Proactively addresses delayed orders
-- 3. Warehouse Management: Evaluates warehouse performance
-- 4. Finance: Correlates payment status with fulfillment
-- 5. Executive Dashboard: Overall fulfillment health metrics

