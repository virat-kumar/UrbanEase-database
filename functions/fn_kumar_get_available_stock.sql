-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Function - Get Available Stock for Product Variant
-- Tables: Inventory
-- Returns: Available stock (on_hand - reserved) for a specific variant at warehouse
-- =============================================

-- BUSINESS USE CASE:
-- This function is called thousands of times per day across multiple business operations:
--
-- 1. E-commerce Website: Real-time stock availability on product pages
-- 2. Order Processing: Validates if items can be added to cart
-- 3. Recommendation Engine: Shows only in-stock alternatives
-- 4. Sales Team: Checks availability before promising delivery
-- 5. Customer Service: Answers "do you have this in stock?" questions
-- 6. Mobile App: Updates product availability every few seconds
-- 7. Third-party Integrations: Syncs stock to marketplaces (Amazon, eBay)

-- REAL-WORLD SCENARIO:
-- Customer visits website and views iPhone 15:
-- 1. Product page loads -> fn_GetAvailableStock(1, 1) -> Shows "258 available"
-- 2. Customer adds 2 to cart -> fn_GetAvailableStock(1, 1) >= 2 -> "Add to Cart" enabled
-- 3. Customer changes quantity to 300 -> fn_GetAvailableStock(1, 1) < 300 -> "Only 258 available"
-- 4. Sales rep checks stock -> fn_GetAvailableStock(1, 1) -> "Yes, we have 258 in NYC warehouse"
-- 5. Background job syncs to Amazon -> fn_GetAvailableStock(1, 1) -> Updates Amazon listing
--
-- This function is called ~50,000 times/day on a busy e-commerce site

USE urbanease_shop;

-- Drop function if exists (for development/updates)
DROP FUNCTION IF EXISTS fn_GetAvailableStock;

DELIMITER //

CREATE FUNCTION fn_GetAvailableStock(
    p_variant_id BIGINT,
    p_warehouse_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns available stock (on_hand - reserved) for a variant at specific warehouse. Returns 0 if not found or negative.'
BEGIN
    DECLARE v_available_stock INT DEFAULT 0;
    DECLARE v_on_hand INT DEFAULT 0;
    DECLARE v_reserved INT DEFAULT 0;
    
    -- ============================================
    -- QUERY INVENTORY TABLE
    -- ============================================
    -- Get current inventory levels
    SELECT 
        COALESCE(on_hand, 0),
        COALESCE(reserved, 0)
    INTO 
        v_on_hand,
        v_reserved
    FROM Inventory
    WHERE 
        variant_id = p_variant_id 
        AND warehouse_id = p_warehouse_id
    LIMIT 1;
    
    -- ============================================
    -- CALCULATE AVAILABLE STOCK
    -- ============================================
    -- Calculate available stock (can never be negative for business logic)
    SET v_available_stock = v_on_hand - v_reserved;
    
    -- Safety check: if somehow available is negative, return 0
    -- This prevents overselling in edge cases
    IF v_available_stock < 0 THEN
        SET v_available_stock = 0;
    END IF;
    
    -- Return the available stock count
    RETURN v_available_stock;
END//

DELIMITER ;

-- =============================================
-- COMPANION FUNCTIONS (Optional enhancements)
-- =============================================

-- Drop if exists
DROP FUNCTION IF EXISTS fn_GetTotalAvailableStock;

DELIMITER //

-- Get total available stock across ALL warehouses for a variant
CREATE FUNCTION fn_GetTotalAvailableStock(
    p_variant_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns total available stock across all warehouses for a variant'
BEGIN
    DECLARE v_total_available INT DEFAULT 0;
    
    -- Sum available stock from all warehouses
    SELECT 
        COALESCE(SUM(on_hand - reserved), 0)
    INTO 
        v_total_available
    FROM Inventory
    WHERE 
        variant_id = p_variant_id
        AND (on_hand - reserved) > 0;  -- Only count positive availability
    
    -- Return total available
    RETURN GREATEST(v_total_available, 0);
END//

DELIMITER ;

-- Drop if exists
DROP FUNCTION IF EXISTS fn_IsInStock;

DELIMITER //

-- Quick boolean check if item is in stock at warehouse
CREATE FUNCTION fn_IsInStock(
    p_variant_id BIGINT,
    p_warehouse_id BIGINT,
    p_required_qty INT
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns TRUE if required quantity is available, FALSE otherwise'
BEGIN
    DECLARE v_available INT;
    
    -- Get available stock using our main function
    SET v_available = fn_GetAvailableStock(p_variant_id, p_warehouse_id);
    
    -- Return TRUE if we have enough, FALSE otherwise
    RETURN (v_available >= p_required_qty);
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

SELECT '=== Test 1: Get available stock for specific variant and warehouse ===' as test_description;
SELECT 
    fn_GetAvailableStock(1, 1) as available_stock_variant_1_warehouse_1,
    fn_GetAvailableStock(2, 2) as available_stock_variant_2_warehouse_2,
    fn_GetAvailableStock(999, 1) as non_existent_variant;

SELECT '=== Test 2: Get total available stock across all warehouses ===' as test_description;
SELECT 
    fn_GetTotalAvailableStock(1) as total_iphone_stock,
    fn_GetTotalAvailableStock(8) as total_macbook_stock,
    fn_GetTotalAvailableStock(999) as non_existent_total;

SELECT '=== Test 3: Check if sufficient stock exists ===' as test_description;
SELECT 
    fn_IsInStock(1, 1, 10) as can_fulfill_10_units,
    fn_IsInStock(1, 1, 500) as can_fulfill_500_units,
    fn_IsInStock(999, 1, 1) as non_existent_check;

SELECT '=== Test 4: Real-world scenario - Product page display ===' as test_description;
SELECT 
    pv.sku,
    pv.price,
    w.name as warehouse,
    i.on_hand,
    i.reserved,
    fn_GetAvailableStock(pv.variant_id, w.warehouse_id) as available_to_sell,
    CASE 
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) = 0 THEN '❌ OUT OF STOCK'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) < 10 THEN '⚠️  LOW STOCK'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) < 50 THEN '✓ IN STOCK'
        ELSE '✓✓ HIGH STOCK'
    END as stock_status,
    CASE 
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) >= 100 THEN 'Enable Buy Button'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) > 0 THEN 'Enable with "Limited Stock" warning'
        ELSE 'Disable Buy Button - Show "Notify Me"'
    END as website_action
FROM ProductVariants pv
JOIN Inventory i ON pv.variant_id = i.variant_id
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
WHERE pv.variant_id IN (1, 2, 3)
ORDER BY available_to_sell ASC
LIMIT 10;

SELECT '=== Test 5: Validate against actual query ===' as test_description;
SELECT 
    'Using Function' as method,
    fn_GetAvailableStock(1, 1) as available
UNION ALL
SELECT 
    'Using Direct Query' as method,
    (on_hand - reserved) as available
FROM Inventory
WHERE variant_id = 1 AND warehouse_id = 1;
