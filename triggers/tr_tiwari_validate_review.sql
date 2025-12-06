-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Trigger - Update Order Status on Shipment
-- Tables: Orders, OrderItems, Shipments
-- Purpose: Automatically update order status when shipment is created
-- =============================================

-- BUSINESS USE CASE:
-- This trigger ensures that the Orders table always reflects the real-world 
-- fulfillment status without relying solely on application code or manual updates.
--
-- It protects against:
-- 1. Partial Shipments: Orders that are shipped in multiple boxes over time
-- 2. Missed Status Updates: Developers forgetting to update Orders.status in code
-- 3. Manual Data Entry Errors: Staff updating shipments but not updating orders
-- 4. Integration Issues: Third-party shipping systems inserting shipments but not
--    triggering order status changes
-- 5. Reporting Mismatches: Orders marked as "SHIPPED" even when everything is 
--    already delivered, causing confusion for analytics and dashboards

-- REAL-WORLD SCENARIO:
-- Example: Order #16 (3 items, shipped in 2 boxes)
-- - Box 1: Ships today (status: SHIPPED → then DELIVERED)
-- - Box 2: Ships tomorrow (status: SHIPPED → then DELIVERED)
-- 
-- Without this trigger:
-- - The system might forget to update Orders.status when the last shipment arrives.
-- - The order could remain stuck in 'SHIPPED' or 'PROCESSING'.
--
-- With this trigger:
-- - Every time a new row is inserted in Shipments, the trigger checks:
--   • How many shipments exist for that order
--   • How many of those are marked as 'DELIVERED'
-- - If ALL shipments are 'DELIVERED', Orders.status is automatically set to 'FULFILLED'
--
-- BUSINESS IMPACT:
-- - Accurate order lifecycle tracking (PROCESSING → SHIPPED → FULFILLED)
-- - Cleaner reporting for KPIs such as:
--   • % of orders fulfilled
--   • Average time to fulfillment
-- - Better customer experience: status in UI/email always matches reality
-- - Reduced manual work for operations and support teams

USE urbanease_shop;

-- =============================================
-- TRIGGER: Auto-update order status when all shipments delivered
-- =============================================

-- Drop trigger if it already exists (for updates during development)
DROP TRIGGER IF EXISTS tr_UpdateOrderStatus;

DELIMITER //

CREATE TRIGGER tr_UpdateOrderStatus
AFTER INSERT ON Shipments
FOR EACH ROW
BEGIN
    DECLARE total_shipments INT;
    DECLARE delivered_shipments INT;

    -- ============================================
    -- STEP 1: Count total shipments for this order
    -- ============================================
    SELECT COUNT(*)
    INTO total_shipments
    FROM Shipments
    WHERE order_id = NEW.order_id;

    -- ============================================
    -- STEP 2: Count shipments that are DELIVERED
    -- ============================================
    SELECT COUNT(*)
    INTO delivered_shipments
    FROM Shipments
    WHERE order_id = NEW.order_id
      AND status = 'DELIVERED';

    -- ============================================
    -- STEP 3: If ALL shipments are delivered,
    --         mark the order as FULFILLED
    -- ============================================
    IF total_shipments = delivered_shipments
       AND total_shipments > 0 THEN
        UPDATE Orders
        SET status     = 'FULFILLED',
            updated_at = NOW()
        WHERE order_id = NEW.order_id;
    END IF;

    -- Note:
    --  • This trigger assumes that Orders.status lifecycle is managed elsewhere
    --    for earlier stages (e.g., 'PENDING', 'PROCESSING', 'SHIPPED').
    --  • This trigger only handles the final step: moving to 'FULFILLED' once
    --    every related shipment is marked as 'DELIVERED'.

END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

-- =============================================
-- TEST 1: Insert first shipment (partial)
-- EXPECTATION:
--   • Order remains NOT FULFILLED if not all shipments are delivered.
-- =============================================

SELECT '=== Test 1: Insert partial shipment (order should NOT be FULFILLED yet) ===' AS test_description;

-- Example: assume order_id = 16 exists and is not yet fulfilled
-- First shipment (delivered, but we will assume another shipment still pending)
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at)
VALUES (16, 1, 'FedEx', 'TRACK1111', 'DELIVERED', NOW());

-- Check order status after first shipment
SELECT order_id, status, updated_at
FROM Orders
WHERE order_id = 16;

-- =============================================
-- TEST 2: Insert final shipment (all delivered)
-- EXPECTATION:
--   • Once ALL shipments for order 16 are DELIVERED,
--     Orders.status should automatically become 'FULFILLED'.
-- =============================================

SELECT '=== Test 2: Insert final delivered shipment (order SHOULD become FULFILLED) ===' AS test_description;

-- Second (or final) shipment for same order
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at)
VALUES (16, 1, 'FedEx', 'TRACK9999', 'DELIVERED', NOW());

-- Verify that order 16 is now FULFILLED
SELECT order_id, status, updated_at
FROM Orders
WHERE order_id = 16;

-- =============================================
-- TEST 3: Show trigger configuration
-- =============================================

SELECT '=== Test 3: Show trigger on Shipments table ===' AS test_description;

SELECT 
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    ACTION_TIMING,
    EVENT_OBJECT_TABLE AS TABLE_NAME
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'urbanease_shop'
  AND EVENT_OBJECT_TABLE = 'Shipments'
ORDER BY ACTION_TIMING, EVENT_MANIPULATION;
