-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Query 1 - Active Shopping Carts with Items
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Get all active carts with their items and total value

/*
SELECT 
    c.cart_id,
    c.user_id,
    COUNT(ci.cart_item_id) as item_count,
    SUM(ci.qty * ci.unit_price) as cart_total
FROM Carts c
-- Add your JOINs and WHERE clauses
;
*/

