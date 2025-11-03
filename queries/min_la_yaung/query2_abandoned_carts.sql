-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Query 2 - Abandoned Carts Analysis
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Find carts that haven't been updated in X days

/*
SELECT 
    c.cart_id,
    c.user_id,
    c.updated_at,
    DATEDIFF(NOW(), c.updated_at) as days_inactive,
    SUM(ci.qty * ci.unit_price) as potential_revenue
FROM Carts c
-- Add your JOINs and WHERE clauses
;
*/

