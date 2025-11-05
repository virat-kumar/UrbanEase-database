-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Enhanced Query 2 - Abandoned Carts Revenue Insights
-- Tables: Carts, CartItems, Coupons, Users
-- =============================================

USE urbanease_shop;


-- a query that ranks carts by inactivity and potential revenue to help the team decide 
-- which users to target first with reminders or coupon offers for cart recovery.
WITH cart_summary AS (
    SELECT 
        c.cart_id,
        COALESCE(u.full_name, 'Guest User') AS user_name,
        TIMESTAMPDIFF(DAY, MAX(ci.added_at), NOW()) AS days_inactive,  -- Days since the last item was added
        COUNT(ci.cart_item_id) AS total_items,
        SUM(ci.qty * ci.unit_price) AS potential_revenue,               -- Estimated total cart value
        COUNT(DISTINCT p.category_id) AS category_diversity             -- How diverse the cart is (helps in marketing personalization)
    FROM Carts c
    LEFT JOIN Users u ON c.user_id = u.user_id
    INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
    INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
    INNER JOIN Products p ON pv.product_id = p.product_id
    GROUP BY c.cart_id, user_name
)
SELECT 
    cs.cart_id,
    cs.user_name,
    cs.days_inactive,
    cs.total_items,
    ROUND(cs.potential_revenue, 2) AS potential_revenue,
    cs.category_diversity,
    -- Customer activity classification
    CASE
        WHEN cs.days_inactive <= 2 THEN 'Recently Active'
        WHEN cs.days_inactive BETWEEN 3 AND 6 THEN 'At Risk'
        WHEN cs.days_inactive BETWEEN 7 AND 14 THEN 'Likely Lost'
        ELSE 'Dormant'
    END AS cart_status,

    -- Prioritize high-value carts with recent inactivity

    RANK() OVER (
        ORDER BY cs.days_inactive ASC, cs.potential_revenue DESC
    ) AS recovery_priority,

    -- Suggest a coupon strategy based on value
    CASE
        WHEN cs.potential_revenue >= 500 THEN 'Offer 20% OFF coupon'
        WHEN cs.potential_revenue BETWEEN 200 AND 499 THEN 'Offer $25 OFF coupon'
        ELSE 'Send gentle reminder email'
    END AS recommended_action
FROM cart_summary cs
WHERE cs.total_items > 0
ORDER BY recovery_priority;
