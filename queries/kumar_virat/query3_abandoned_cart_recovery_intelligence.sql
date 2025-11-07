-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 3 - Abandoned Cart Recovery with Customer & Inventory Intelligence
-- Tables Used: Carts (Min), CartItems (Min), Users (Bajwa), ProductVariants (Virat),
--              Products (Pooja), Inventory (Virat), Coupons (Min), Orders (Sneha)
-- =============================================

-- BUSINESS USE CASE:
-- This query identifies high-value abandoned carts and provides actionable intelligence
-- for recovery campaigns. It combines cart data with customer history, product availability,
-- and coupon strategies to maximize conversion rates.

-- REAL-WORLD SCENARIO:
-- Marketing team runs this query 3x daily to:
-- - Send personalized cart recovery emails with dynamic coupons
-- - Prioritize which abandoned carts to target first
-- - Ensure products are still in stock before sending reminders
-- - Customize messaging based on customer purchase history
-- - Calculate ROI of recovery campaigns

USE urbanease_shop;

SELECT 
    -- Cart Identification
    c.cart_id,
    c.created_at AS cart_created_date,
    c.updated_at AS cart_last_modified,
    DATEDIFF(NOW(), c.updated_at) AS days_since_last_activity,
    TIMESTAMPDIFF(HOUR, c.updated_at, NOW()) AS hours_since_last_activity,
    
    -- Customer Information (Bajwa's tables)
    CASE 
        WHEN c.user_id IS NULL THEN 'Guest'
        ELSE 'Registered'
    END AS customer_type,
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS customer_active_status,
    DATE_FORMAT(u.created_at, '%Y-%m-%d') AS customer_since,
    DATEDIFF(NOW(), u.created_at) AS customer_age_days,
    
    -- Cart Contents (Min + Virat + Pooja tables)
    COUNT(DISTINCT ci.cart_item_id) AS total_items_in_cart,
    SUM(ci.qty) AS total_units_in_cart,
    GROUP_CONCAT(DISTINCT p.title ORDER BY (ci.qty * ci.unit_price) DESC SEPARATOR ' | ') AS products_in_cart,
    GROUP_CONCAT(DISTINCT p.brand SEPARATOR ', ') AS brands_in_cart,
    GROUP_CONCAT(DISTINCT pv.sku SEPARATOR ', ') AS skus_in_cart,
    
    -- Cart Value Analysis
    ROUND(SUM(ci.qty * ci.unit_price), 2) AS cart_total_value,
    ROUND(AVG(ci.unit_price), 2) AS average_item_price,
    ROUND(MAX(ci.unit_price), 2) AS highest_priced_item,
    ROUND(MIN(ci.unit_price), 2) AS lowest_priced_item,
    
    -- Inventory Availability Check (Virat's tables)
    SUM(CASE 
        WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1
        ELSE 0
    END) AS items_in_stock_count,
    SUM(CASE 
        WHEN IFNULL(inv.on_hand - inv.reserved, 0) < ci.qty THEN 1
        ELSE 0
    END) AS items_out_of_stock_count,
    
    -- Customer Purchase History (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS previous_orders_count,
    ROUND(COALESCE(SUM(o.grand_total_amount), 0), 2) AS lifetime_purchase_value,
    MAX(o.placed_at) AS last_order_date,
    DATEDIFF(NOW(), MAX(o.placed_at)) AS days_since_last_order,
    
    -- Cart Abandonment Classification
    CASE 
        WHEN DATEDIFF(NOW(), c.updated_at) = 0 THEN 'TODAY - Fresh Abandonment'
        WHEN DATEDIFF(NOW(), c.updated_at) = 1 THEN 'YESTERDAY - 24hr Window'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 3 THEN 'RECENT - 2-3 Days (Prime for Recovery)'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 7 THEN 'STALE - 4-7 Days'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 14 THEN 'VERY STALE - 8-14 Days'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 30 THEN 'OLD - 15-30 Days'
        ELSE 'EXPIRED - >30 Days'
    END AS abandonment_age_category,
    
    -- Cart Value Tier
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 1000 THEN 'PREMIUM ($1000+)'
        WHEN SUM(ci.qty * ci.unit_price) >= 500 THEN 'HIGH VALUE ($500-$999)'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 THEN 'MEDIUM-HIGH ($200-$499)'
        WHEN SUM(ci.qty * ci.unit_price) >= 100 THEN 'MEDIUM ($100-$199)'
        WHEN SUM(ci.qty * ci.unit_price) >= 50 THEN 'LOW-MEDIUM ($50-$99)'
        ELSE 'LOW VALUE (<$50)'
    END AS cart_value_tier,
    
    -- Recovery Priority Score (1-10, 10 being highest)
    CASE 
        -- High value, recent abandonment, items in stock, existing customer
        WHEN SUM(ci.qty * ci.unit_price) >= 500 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            AND c.user_id IS NOT NULL
            THEN 10
        -- High value, recent, in stock
        WHEN SUM(ci.qty * ci.unit_price) >= 300 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) >= COUNT(ci.cart_item_id) * 0.8
            THEN 9
        -- Medium-high value, very recent
        WHEN SUM(ci.qty * ci.unit_price) >= 200 AND DATEDIFF(NOW(), c.updated_at) <= 1 THEN 8
        -- High value but older
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND DATEDIFF(NOW(), c.updated_at) <= 7 THEN 7
        -- Medium value, recent
        WHEN SUM(ci.qty * ci.unit_price) >= 100 AND DATEDIFF(NOW(), c.updated_at) <= 3 THEN 6
        -- Registered customer, decent value
        WHEN c.user_id IS NOT NULL AND SUM(ci.qty * ci.unit_price) >= 100 THEN 5
        -- Recent but low value
        WHEN DATEDIFF(NOW(), c.updated_at) <= 1 THEN 4
        -- Guest cart, low value
        WHEN c.user_id IS NULL AND SUM(ci.qty * ci.unit_price) < 50 THEN 2
        -- Very old carts
        WHEN DATEDIFF(NOW(), c.updated_at) > 14 THEN 1
        ELSE 3
    END AS recovery_priority_score,
    
    -- Customer Segment for Targeting
    CASE 
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) >= 3 
            THEN 'LOYAL CUSTOMER - High Trust'
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) BETWEEN 1 AND 2 
            THEN 'REPEAT BUYER - Medium Trust'
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) = 0 
            THEN 'NEW REGISTERED - Building Relationship'
        WHEN c.user_id IS NULL 
            THEN 'GUEST - Needs Registration Incentive'
        ELSE 'UNKNOWN'
    END AS customer_segment,
    
    -- Recommended Recovery Strategy
    CASE 
        -- High value loyal customers
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND COUNT(DISTINCT o.order_id) >= 3 
            THEN 'VIP: Personal email + Phone call + Free shipping + 15% off'
        -- High value new customers
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND COUNT(DISTINCT o.order_id) = 0 
            THEN 'HIGH POTENTIAL: Email + 20% first order discount + Free shipping'
        -- Medium value, items in stock, recent
        WHEN SUM(ci.qty * ci.unit_price) >= 200 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            THEN 'TIMELY: Email + 10% discount + Urgency message (24hr)'
        -- Out of stock issues
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) < ci.qty THEN 1 ELSE 0 END) > 0 
            THEN 'INVENTORY: Notify when back in stock + Waitlist'
        -- Guest carts
        WHEN c.user_id IS NULL AND SUM(ci.qty * ci.unit_price) >= 100 
            THEN 'GUEST RECOVERY: Email + Register & Save 10% incentive'
        -- Stale carts
        WHEN DATEDIFF(NOW(), c.updated_at) BETWEEN 7 AND 14 
            THEN 'LAST CHANCE: Email + 15% off + Limited time offer'
        -- Low priority
        ELSE 'LOW PRIORITY: Basic reminder email only'
    END AS recommended_recovery_tactic,
    
    -- Suggested Coupon Type (from Min's Coupons table logic)
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 500 THEN 'Offer SAVE15 or MEGA50 coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 THEN 'Offer SAVE15 or DEAL25 coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 100 THEN 'Offer WELCOME10 or GET10OFF coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 50 THEN 'Offer WELCOME10 or SAVE5 coupon'
        ELSE 'Offer SAVE5 coupon or free shipping'
    END AS suggested_coupon_strategy,
    
    -- Stock Availability Status
    CASE 
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            THEN 'ALL IN STOCK - Ready to fulfill'
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) >= COUNT(ci.cart_item_id) * 0.5
            THEN 'PARTIALLY IN STOCK - Some items available'
        ELSE 'MOSTLY OUT OF STOCK - Notify when available'
    END AS inventory_availability_status,
    
    -- Estimated Recovery Value (cart value * probability)
    ROUND(
        SUM(ci.qty * ci.unit_price) * 
        CASE 
            WHEN DATEDIFF(NOW(), c.updated_at) <= 1 THEN 0.35  -- 35% conversion within 24hrs
            WHEN DATEDIFF(NOW(), c.updated_at) <= 3 THEN 0.25  -- 25% conversion 2-3 days
            WHEN DATEDIFF(NOW(), c.updated_at) <= 7 THEN 0.15  -- 15% conversion 4-7 days
            WHEN DATEDIFF(NOW(), c.updated_at) <= 14 THEN 0.05 -- 5% conversion 8-14 days
            ELSE 0.02  -- 2% conversion after 14 days
        END, 
        2
    ) AS estimated_recovery_value,
    
    -- Action Urgency
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND DATEDIFF(NOW(), c.updated_at) <= 1 
            THEN 'URGENT: Contact within 2 hours'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 AND DATEDIFF(NOW(), c.updated_at) <= 3 
            THEN 'HIGH: Contact within 12 hours'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 3 
            THEN 'MEDIUM: Contact within 24 hours'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 7 
            THEN 'LOW: Contact within 3 days'
        ELSE 'MINIMAL: Optional contact'
    END AS action_urgency

FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON c.cart_id = ci.cart_id
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN (
    SELECT variant_id, SUM(on_hand) AS on_hand, SUM(reserved) AS reserved
    FROM Inventory
    GROUP BY variant_id
) inv ON pv.variant_id = inv.variant_id
LEFT JOIN Orders o ON c.user_id = o.user_id AND o.status IN ('PAID', 'FULFILLED')

WHERE 
    -- Cart was updated in last 30 days (not too old)
    c.updated_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    -- Cart was not converted to order (check by lack of recent order with same products)
    AND NOT EXISTS (
        SELECT 1 FROM Orders o2
        INNER JOIN OrderItems oi ON o2.order_id = oi.order_id
        WHERE o2.user_id = c.user_id 
        AND oi.variant_id = ci.variant_id
        AND o2.placed_at >= c.updated_at
    )
    -- Cart has been inactive for at least 3 hours (abandoned)
    AND TIMESTAMPDIFF(HOUR, c.updated_at, NOW()) >= 3

GROUP BY 
    c.cart_id, c.created_at, c.updated_at, c.user_id,
    u.user_id, u.full_name, u.email, u.phone, u.is_active, u.created_at

HAVING 
    cart_total_value > 0  -- Only carts with value

ORDER BY 
    recovery_priority_score DESC,
    cart_total_value DESC,
    days_since_last_activity ASC;

-- BUSINESS VALUE:
-- 1. Marketing: Prioritized list for cart recovery campaigns
-- 2. Sales: Identifies high-value opportunities for personal outreach
-- 3. Customer Success: Personalizes recovery messaging based on customer history
-- 4. Inventory: Ensures stock availability before sending reminders
-- 5. Finance: Estimates potential revenue from recovery efforts
-- 6. Analytics: Tracks abandonment patterns and recovery ROI

