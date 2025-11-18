-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Stored Procedure - Create Shipment
-- Tables: Orders, OrderItems, Shipments
-- Purpose: Create shipment for an order and initialize shipment workflow
-- =============================================

-- BUSINESS USE CASE:
-- This procedure is the central entry point for creating a shipment record
-- whenever an order is ready to be shipped from a warehouse.
--
-- It can be called by:
-- 1. Warehouse Management System (WMS) when a picker/packer marks an order as ready.
-- 2. E-commerce backend when an order moves from "PROCESSING" to "SHIPPED".
-- 3. Integration services that connect to external carriers (FedEx, UPS, DHL).
-- 4. Customer Service tools to manually trigger a shipment in special cases.
--
-- Key responsibilities:
-- - Validate that the order exists.
-- - Create a new row in Shipments with basic info (warehouse, carrier, tracking).
-- - Set initial shipment status (e.g., 'CREATED') and timestamp.
--
-- This procedure works together with:
-- - Triggers like tr_UpdateOrderStatus that react to shipment events
--   and update the Orders table (e.g., moving to FULFILLED once all shipments are delivered).

-- REAL-WORLD SCENARIO:
-- Example: Order #16 is paid and packed at Warehouse #1.
--
-- - The system calls:
--     CALL sp_CreateShipment(16, 1, 'FedEx', 'TRACK12345');
--
-- - Results:
--   • A row is inserted into Shipments:
--       order_id   = 16
--       warehouse_id = 1
--       carrier    = 'FedEx'
--       tracking_no = 'TRACK12345'
--       status     = 'CREATED'
--       shipped_at = NOW()
--
-- - Next steps:
--   • Another process or UI workflow may later update status to
--     'SHIPPED', 'IN_TRANSIT', 'DELIVERED', etc.
--   • Your AFTER INSERT trigger on Shipments can evaluate whether
--     all shipments are delivered and mark the order as FULFILLED.

USE urbanease_shop;

-- Drop procedure if exists (for development/updates)
DROP PROCEDURE IF EXISTS sp_CreateShipment;

DELIMITER //

CREATE PROCEDURE sp_CreateShipment(
    IN p_order_id BIGINT,
    IN p_warehouse_id BIGINT,
    IN p_carrier VARCHAR(80),
    IN p_tracking_no VARCHAR(120)
)
BEGIN
    DECLARE v_order_status VARCHAR(20);

    -- ============================================
    -- STEP 1: Validate order exists
    -- ============================================
    -- If no row is found, v_order_status will be NULL.
    SELECT status
    INTO v_order_status
    FROM Orders
    WHERE order_id = p_order_id;

    IF v_order_status IS NULL THEN
        -- Business rule: do not allow shipments for non-existent orders
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ORDER ERROR: Order does not exist. Cannot create shipment.';
    ELSE
        -- ============================================
        -- STEP 2: Create shipment record
        -- ============================================
        -- Initial status is set to 'CREATED'. Other parts of the system
        -- can later transition this to SHIPPED / IN_TRANSIT / DELIVERED.
        INSERT INTO Shipments (
            order_id,
            warehouse_id,
            carrier,
            tracking_no,
            status,
            shipped_at
        )
        VALUES (
            p_order_id,
            p_warehouse_id,
            p_carrier,
            p_tracking_no,
            'CREATED',
            NOW()
        );
    END IF;
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

-- TEST 1: Basic shipment creation for an existing order
SELECT '=== Test 1: Create shipment for existing order (16) ===' AS test_description;
CALL sp_CreateShipment(16, 1, 'FedEx', 'TRACK12345');

-- Verify shipment was inserted
SELECT 
    s.shipment_id,
    s.order_id,
    s.warehouse_id,
    s.carrier,
    s.tracking_no,
    s.status,
    s.shipped_at
FROM Shipments s
WHERE s.order_id = 16
ORDER BY s.shipped_at DESC
LIMIT 5;

-- TEST 2: Attempt shipment for non-existent order (should error)
SELECT '=== Test 2: Try to create shipment for non-existent order (e.g., 99999) ===' AS test_description;
-- This should raise: ORDER ERROR: Order does not exist. Cannot create shipment.
-- Uncomment to test:
-- CALL sp_CreateShipment(99999, 1, 'UPS', 'FAKE12345');

-- TEST 3: View recent shipments across all orders
SELECT '=== Test 3: Recent shipments overview ===' AS test_description;
SELECT 
    s.shipment_id,
    s.order_id,
    s.warehouse_id,
    s.carrier,
    s.tracking_no,
    s.status,
    s.shipped_at
FROM Shipments s
ORDER BY s.shipped_at DESC
LIMIT 10;
