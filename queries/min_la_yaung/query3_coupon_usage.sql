-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 3 - Coupon Usage and Effectiveness
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;

-- a query that calculates how much each active coupon could discount total cart values based on current items

SELECT 
    cp.code AS coupon_code,												-- Coupon code identifier
    cp.type AS discount_type,											-- Either 'PERCENT' or 'AMOUNT'
    cp.value AS discount_value,											-- Discount percentage or flat value
    COUNT(DISTINCT c.cart_id) AS applicable_carts,						-- Number of carts the coupon could apply to
    -- calculate the total value of all carts combined
    ROUND(SUM(ci.qty * ci.unit_price), 2) AS total_cart_value,
    
    -- created a subquery that determines total discount amount based on coupon type
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT'  THEN ROUND(cp.value * COUNT(DISTINCT c.cart_id), 2)
        ELSE 0
    END AS total_discount_value,
    --  created a subquery that calculates the remaining revenue after discount is applied
    ROUND(
        SUM(ci.qty * ci.unit_price) -
        CASE 
            WHEN cp.type = 'PERCENT' THEN SUM(ci.qty * ci.unit_price) * (cp.value / 100)
            WHEN cp.type = 'AMOUNT'  THEN cp.value * COUNT(DISTINCT c.cart_id)
            ELSE 0
        END, 2
    ) AS potential_revenue_after_discount
FROM Coupons cp
JOIN Carts c ON 1=1          					-- remove date restrictions to include all carts
JOIN CartItems ci ON ci.cart_id = c.cart_id 	-- match each cart with its items
WHERE cp.is_active = TRUE						-- only include active coupons
GROUP BY cp.code, cp.type, cp.value				-- group results per coupon
HAVING total_cart_value > 0						-- ignore coupons with no sales data
ORDER BY total_discount_value DESC;				-- show most valuable coupons first
