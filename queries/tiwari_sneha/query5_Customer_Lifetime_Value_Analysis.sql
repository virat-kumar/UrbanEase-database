-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 5 - Customer Lifetime Value (CLV) Analysis
-- Tables: Users, Orders, Payments
-- =============================================

USE urbanease_shop;

WITH customer_spend AS (
    SELECT 
        u.user_id,
        u.full_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.grand_total_amount) AS total_spent,
        AVG(o.grand_total_amount) AS avg_order_value,
        MAX(o.placed_at) AS last_order_date
    FROM Users u
    JOIN Orders o ON u.user_id = o.user_id
    WHERE o.status IN ('PAID', 'FULFILLED')
    GROUP BY u.user_id, u.full_name
)
SELECT 
    user_id,
    full_name,
    total_orders,
    total_spent,
    avg_order_value,
    last_order_date,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_spend
ORDER BY total_spent DESC;
