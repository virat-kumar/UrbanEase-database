-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Function - Get Order Item Count
-- Tables: OrderItems
-- Returns:  Number of line items (rows) in a specific order
-- =============================================

-- BUSINESS USE CASE:
-- This function supports the entire order lifecycle by providing a fast,
-- reusable way to determine how many distinct line items exist in a given order.
--
-- Used by:
-- 1. Website order summary 
-- 2. Warehouse picking workflows
-- 3. Quality control checkpoint before packing
-- 4. Customer service ticket screens
-- 5. Analytics dashboards (average items per order, basket analysis)
-- 6. Fraud detection (large or unusual item counts)
--
-- REAL-WORLD SCENARIO:
-- Order #16 contains:
--   - iPhone 15 × 1
--   - AirPods Pro × 2
--   - MagSafe Charger × 1
-- That is 3 line items (rows).
--
-- fn_GetOrderItemCount(16) → 3
--
-- This helps:
-- - Website UI display correct order summary
-- - Warehouse route single vs multi-item orders differently
-- - Reduce human error during packing
-- - Improve reporting accuracy

USE urbanease_shop;

-- Drop function if exists (for development updates)
DROP FUNCTION IF EXISTS fn_GetOrderItemCount;

DELIMITER //

CREATE FUNCTION fn_GetOrderItemCount(
    p_order_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns the number of line items in an order (OrderItems count)'
BEGIN
    DECLARE item_count INT DEFAULT 0;

    -- Count line items in the order
    SELECT COUNT(*)
    INTO item_count
    FROM OrderItems
    WHERE order_id = p_order_id;

    RETURN item_count;
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

-- TEST 1: Basic count
SELECT '=== Test 1: Get item count for order 16 ===' AS test_description;
SELECT 
    fn_GetOrderItemCount(16) AS item_count;

-- TEST 2: Validate function using direct COUNT(*) (no changes to table)
SELECT '=== Test 2: Validate using direct COUNT ===' AS test_description;
SELECT 
    'Function Result' AS method,
    fn_GetOrderItemCount(16) AS item_count
UNION ALL
SELECT 
    'Direct Query' AS method,
    COUNT(*) AS item_count
FROM OrderItems
WHERE order_id = 16;

-- TEST 3: Show item counts (NO ORDER BY created_at because table doesn’t have it)
SELECT '=== Test 3: Item counts for multiple orders ===' AS test_description;
SELECT 
    o.order_id,
    o.status,
    fn_GetOrderItemCount(o.order_id) AS item_count
FROM Orders o
LIMIT 10;

-- TEST 4: Edge case - order does not exist
SELECT '=== Test 4: Non-existent order ===' AS test_description;
SELECT 
    fn_GetOrderItemCount(999999) AS item_count_non_existent;
