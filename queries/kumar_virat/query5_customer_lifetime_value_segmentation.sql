-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 5 - Customer Lifetime Value & RFM Segmentation Analysis
-- Tables Used: Users (Bajwa), UserRoles (Bajwa), Orders (Sneha), OrderItems (Sneha),
--              Payments (Diana), Reviews (Diana), Carts (Min), Addresses (Diana)
-- =============================================

-- BUSINESS USE CASE:
-- This query implements RFM (Recency, Frequency, Monetary) analysis combined with
-- engagement metrics to segment customers and calculate lifetime value. It enables
-- targeted marketing, personalized experiences, and customer retention strategies.

-- REAL-WORLD SCENARIO:
-- Marketing and CRM teams use this for:
-- - Identifying VIP customers for exclusive offers
-- - Segmenting customers for email marketing campaigns
-- - Calculating customer acquisition cost (CAC) payback periods
-- - Predicting churn risk and implementing retention programs
-- - Personalizing product recommendations and pricing

USE urbanease_shop;

SELECT 
    -- Customer Identity (Bajwa's tables)
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS account_active,
    DATE_FORMAT(u.created_at, '%Y-%m-%d') AS registration_date,
    DATEDIFF(NOW(), u.created_at) AS customer_age_days,
    ROUND(DATEDIFF(NOW(), u.created_at) / 30.0, 1) AS customer_age_months,
    
    -- Customer Role (Bajwa's tables)
    GROUP_CONCAT(DISTINCT r.role_name SEPARATOR ', ') AS user_roles,
    CASE 
        WHEN GROUP_CONCAT(DISTINCT r.role_name) LIKE '%VIPCustomer%' THEN 'VIP Member'
        WHEN GROUP_CONCAT(DISTINCT r.role_name) LIKE '%Customer%' THEN 'Regular Customer'
        ELSE 'Other'
    END AS membership_tier,
    
    -- RFM: RECENCY - Days since last order (Sneha's tables)
    MAX(o.placed_at) AS last_order_date,
    DATEDIFF(NOW(), MAX(o.placed_at)) AS days_since_last_order,
    CASE 
        WHEN MAX(o.placed_at) IS NULL THEN 0
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5  -- Very Recent
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4  -- Recent
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3  -- Moderate
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2  -- Old
        ELSE 1  -- Very Old
    END AS recency_score,
    
    -- RFM: FREQUENCY - Number of orders (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COUNT(DISTINCT o.order_id) / NULLIF(DATEDIFF(NOW(), u.created_at) / 30.0, 0), 2) AS avg_orders_per_month,
    CASE 
        WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5  -- Very Frequent
        WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4   -- Frequent
        WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3   -- Moderate
        WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2   -- Infrequent
        ELSE 1  -- No Orders
    END AS frequency_score,
    
    -- RFM: MONETARY - Total spent (Sneha + Diana tables)
    ROUND(SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END), 2) AS lifetime_value,
    ROUND(AVG(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE NULL END), 2) AS avg_order_value,
    CASE 
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2
        ELSE 1
    END AS monetary_score,
    
    -- Composite RFM Score
    CONCAT(
        CASE 
            WHEN MAX(o.placed_at) IS NULL THEN 0
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2
            ELSE 1
        END,
        CASE 
            WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5
            WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4
            WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3
            WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2
            ELSE 1
        END,
        CASE 
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2
            ELSE 1
        END
    ) AS rfm_score,
    
    -- Purchase Behavior Metrics
    SUM(oi.qty) AS total_units_purchased,
    COUNT(DISTINCT pv.product_id) AS unique_products_purchased,
    MIN(o.placed_at) AS first_order_date,
    DATEDIFF(MAX(o.placed_at), MIN(o.placed_at)) AS customer_lifespan_days,
    
    -- Payment Behavior (Diana's tables)
    SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) AS successful_payments,
    SUM(CASE WHEN pay.status = 'FAILED' THEN 1 ELSE 0 END) AS failed_payments,
    ROUND(
        (SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100), 
        2
    ) AS payment_success_rate,
    
    -- Engagement Metrics
    COUNT(DISTINCT rev.review_id) AS reviews_written,
    ROUND(AVG(rev.rating), 2) AS avg_review_rating,
    COUNT(DISTINCT addr.address_id) AS addresses_on_file,
    COUNT(DISTINCT cart.cart_id) AS total_carts_created,
    
    -- Customer Segmentation
    CASE 
        -- Champions: High R, F, M (555, 554, 545, 544)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('555', '554', '545', '544', '455', '454', '445')
            THEN 'Champions'
        
        -- Loyal Customers: High F, M but lower R (445, 435, 345)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('344', '345', '335', '334', '444', '435', '434')
            THEN 'Loyal Customers'
        
        -- Potential Loyalists: Recent, moderate F & M (525, 524, 515, 514)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('523', '522', '521', '513', '512', '511', '423', '422', '421')
            THEN 'Potential Loyalists'
        
        -- At Risk: Low R, high F & M (245, 244, 235, 234)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('244', '243', '234', '233', '224', '223', '144', '143', '134', '133')
            THEN 'At Risk'
        
        -- Can't Lose Them: Very low R, high F & M (145, 144, 135, 134)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('155', '154', '145', '144', '155', '135', '124', '123')
            THEN 'Cannot Lose Them'
        
        -- New Customers: High R, low F (511, 411, 311)
        WHEN COUNT(DISTINCT o.order_id) <= 2 AND DATEDIFF(NOW(), MAX(o.placed_at)) <= 60
            THEN 'New Customers'
        
        -- Promising: Recent, low F but good M (533, 532, 531, 543, 542, 541)
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 AND COUNT(DISTINCT o.order_id) <= 3 
            AND SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 500
            THEN 'Promising'
        
        -- Hibernating: Low R, F, M (222, 221, 212, 211)
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 AND COUNT(DISTINCT o.order_id) <= 3
            THEN 'Hibernating'
        
        -- Lost: Very low scores
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 OR MAX(o.placed_at) IS NULL
            THEN 'Lost'
        
        ELSE 'Needs Attention'
    END AS customer_segment,
    
    -- Marketing Actions
    CASE 
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('555', '554', '545', '544', '455', '454', '445')
            THEN 'VIP Treatment: Exclusive access, early releases, personal account manager'
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('244', '243', '234', '233', '224', '223', '144', '143', '134', '133')
            THEN 'Win-Back Campaign: Aggressive discounts, personalized outreach'
        WHEN COUNT(DISTINCT o.order_id) <= 2 AND DATEDIFF(NOW(), MAX(o.placed_at)) <= 60
            THEN 'Nurture: Welcome series, product education, onboarding'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 OR MAX(o.placed_at) IS NULL
            THEN 'Re-engagement: Survey, massive discount, new product showcase'
        ELSE 'Standard Marketing: Regular newsletters, seasonal promotions'
    END AS recommended_marketing_action,
    
    -- Churn Risk
    CASE 
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 AND COUNT(DISTINCT o.order_id) >= 3 THEN 'HIGH CHURN RISK'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 90 AND COUNT(DISTINCT o.order_id) >= 2 THEN 'MEDIUM CHURN RISK'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 60 THEN 'LOW CHURN RISK'
        WHEN MAX(o.placed_at) IS NULL THEN 'NEVER PURCHASED'
        ELSE 'ACTIVE'
    END AS churn_risk_level,
    
    -- Customer Value Tier
    CASE 
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 
            THEN 'PLATINUM ($5000+)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 
            THEN 'GOLD ($2000-$4999)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 
            THEN 'SILVER ($1000-$1999)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 
            THEN 'BRONZE ($100-$999)'
        ELSE 'STARTER (<$100)'
    END AS customer_value_tier

FROM Users u
LEFT JOIN UserRoles ur ON u.user_id = ur.user_id
LEFT JOIN Roles r ON ur.role_id = r.role_id
LEFT JOIN Orders o ON u.user_id = o.user_id AND o.status IN ('PAID', 'FULFILLED', 'PENDING')
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
LEFT JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Reviews rev ON u.user_id = rev.user_id
LEFT JOIN Addresses addr ON u.user_id = addr.user_id
LEFT JOIN Carts cart ON u.user_id = cart.user_id

WHERE 
    u.is_active = TRUE
    AND u.created_at <= NOW()

GROUP BY 
    u.user_id, u.full_name, u.email, u.phone, u.is_active, u.created_at

ORDER BY 
    lifetime_value DESC,
    total_orders DESC,
    days_since_last_order ASC;

-- BUSINESS VALUE:
-- 1. Marketing: Targeted campaigns based on customer segments
-- 2. Customer Success: Proactive retention for at-risk customers
-- 3. Sales: Identifies upsell opportunities with high-value customers
-- 4. Finance: Customer lifetime value forecasting
-- 5. Product: Tailors features and pricing for different segments
-- 6. Executive: Overall customer health and retention metrics

