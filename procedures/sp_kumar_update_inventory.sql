

-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Stored Procedure - Update Inventory Operations
-- Tables: ProductVariants, Warehouses, Inventory
-- Purpose: Centralized inventory management with validation and auditing
-- =============================================

-- BUSINESS USE CASE:
-- This procedure is the core of inventory management operations, handling all
-- stock movements in the warehouse management system (WMS). It's called by:
-- 
-- 1. Receiving Department: When new stock arrives from suppliers
-- 2. Fulfillment System: When reserving items for customer orders
-- 3. Shipping Department: When releasing reserved items after shipment
-- 4. Returns Processing: When customers return products
-- 5. Inventory Adjustments: For cycle counts and corrections
-- 6. Transfer Operations: Moving stock between warehouses

-- REAL-WORLD SCENARIO:
-- Every time an action occurs in the warehouse, this procedure is called:
-- - 9:00 AM: Receiving scans 100 iPhones -> sp_UpdateInventory(..., 'ADD_STOCK')
-- - 10:30 AM: Order system reserves 5 for customer -> sp_UpdateInventory(..., 'RESERVE')
-- - 2:00 PM: Shipping confirms shipment -> sp_UpdateInventory(..., 'RELEASE_SHIP')
-- - 3:30 PM: Customer returns 1 defective -> sp_UpdateInventory(..., 'RETURN')
-- - 5:00 PM: Inventory audit finds 2 missing -> sp_UpdateInventory(..., 'ADJUST')

USE urbanease_shop;

-- Drop procedure if exists (for development/updates)
DROP PROCEDURE IF EXISTS sp_UpdateInventory;

DELIMITER //

CREATE PROCEDURE sp_UpdateInventory(
    IN p_warehouse_id BIGINT,
    IN p_variant_id BIGINT,
    IN p_quantity_change INT,
    IN p_operation VARCHAR(20),  -- 'ADD_STOCK', 'REMOVE_STOCK', 'RESERVE', 'RELEASE_SHIP', 'RELEASE_CANCEL', 'ADJUST', 'RETURN'
    OUT p_result_code INT,       -- 0=Success, 1=Error, 2=Warning
    OUT p_message VARCHAR(500)   -- Human-readable result message
)
sp_UpdateInventory: BEGIN
    -- Variable declarations
    DECLARE v_current_on_hand INT DEFAULT 0;
    DECLARE v_current_reserved INT DEFAULT 0;
    DECLARE v_available INT DEFAULT 0;
    DECLARE v_new_on_hand INT DEFAULT 0;
    DECLARE v_new_reserved INT DEFAULT 0;
    DECLARE v_warehouse_exists INT DEFAULT 0;
    DECLARE v_variant_exists INT DEFAULT 0;
    DECLARE v_inventory_exists INT DEFAULT 0;
    
    -- Error handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Database error occurred during inventory update';
        ROLLBACK;
    END;
    
    -- Start transaction for data consistency
    START TRANSACTION;
    
    -- ============================================
    -- VALIDATION STEP 1: Check if quantity is valid
    -- ============================================
    IF p_quantity_change IS NULL OR p_quantity_change = 0 THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Quantity change must be non-zero';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    IF p_quantity_change < 0 AND p_operation NOT IN ('REMOVE_STOCK', 'ADJUST') THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Negative quantity only allowed for REMOVE_STOCK or ADJUST operations';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 2: Verify warehouse exists
    -- ============================================
    SELECT COUNT(*) INTO v_warehouse_exists
    FROM Warehouses
    WHERE warehouse_id = p_warehouse_id;
    
    IF v_warehouse_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = CONCAT('ERROR: Warehouse ID ', p_warehouse_id, ' does not exist');
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 3: Verify product variant exists and is active
    -- ============================================
    SELECT COUNT(*) INTO v_variant_exists
    FROM ProductVariants
    WHERE variant_id = p_variant_id AND is_active = TRUE;
    
    IF v_variant_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = CONCAT('ERROR: Product Variant ID ', p_variant_id, ' does not exist or is inactive');
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 4: Check if inventory record exists
    -- ============================================
    SELECT COUNT(*) INTO v_inventory_exists
    FROM Inventory
    WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
    
    -- If inventory record doesn't exist and we're adding stock, create it
    IF v_inventory_exists = 0 AND p_operation = 'ADD_STOCK' THEN
        INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved)
        VALUES (p_warehouse_id, p_variant_id, p_quantity_change, 0);
        
        SET p_result_code = 0;
        SET p_message = CONCAT('SUCCESS: Created new inventory record with ', p_quantity_change, ' units');
        COMMIT;
        LEAVE sp_UpdateInventory;
    END IF;
    
    IF v_inventory_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Inventory record does not exist. Use ADD_STOCK to create.';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- GET CURRENT INVENTORY STATE
    -- ============================================
    SELECT on_hand, reserved 
    INTO v_current_on_hand, v_current_reserved
    FROM Inventory
    WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
    
    SET v_available = v_current_on_hand - v_current_reserved;
    
    -- ============================================
    -- PROCESS OPERATION
    -- ============================================
    CASE p_operation
        
        -- ADD_STOCK: Receiving new stock from supplier or returns
        WHEN 'ADD_STOCK' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Added ', p_quantity_change, ' units. New stock: ', v_new_on_hand, 
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- REMOVE_STOCK: Damaged, lost, or written off inventory
        WHEN 'REMOVE_STOCK' THEN
            IF ABS(p_quantity_change) > v_available THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot remove ', ABS(p_quantity_change), 
                                      ' units. Only ', v_available, ' available (', v_current_reserved, ' reserved)');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand - ABS(p_quantity_change);
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Removed ', ABS(p_quantity_change), ' units. New stock: ', v_new_on_hand,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RESERVE: Reserve items for customer order
        WHEN 'RESERVE' THEN
            IF p_quantity_change > v_available THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot reserve ', p_quantity_change, 
                                      ' units. Only ', v_available, ' available');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand;
            SET v_new_reserved = v_current_reserved + p_quantity_change;
            
            UPDATE Inventory
            SET reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Reserved ', p_quantity_change, ' units. Total reserved: ', v_new_reserved,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RELEASE_SHIP: Release reserved items after successful shipment
        WHEN 'RELEASE_SHIP' THEN
            IF p_quantity_change > v_current_reserved THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot release ', p_quantity_change, 
                                      ' units. Only ', v_current_reserved, ' reserved');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand - p_quantity_change;
            SET v_new_reserved = v_current_reserved - p_quantity_change;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand, reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Shipped ', p_quantity_change, ' units. New stock: ', v_new_on_hand,
                                   ' (Reserved: ', v_new_reserved, ', Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RELEASE_CANCEL: Release reservation when order is cancelled
        WHEN 'RELEASE_CANCEL' THEN
            IF p_quantity_change > v_current_reserved THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot release ', p_quantity_change, 
                                      ' units. Only ', v_current_reserved, ' reserved');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand;
            SET v_new_reserved = v_current_reserved - p_quantity_change;
            
            UPDATE Inventory
            SET reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Released ', p_quantity_change, ' units from reservation. ',
                                   'Available: ', (v_new_on_hand - v_new_reserved));
        
        -- ADJUST: Manual adjustment (cycle count corrections)
        WHEN 'ADJUST' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            
            IF v_new_on_hand < 0 THEN
                SET p_result_code = 1;
                SET p_message = 'ERROR: Adjustment would result in negative inventory';
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            IF v_new_on_hand < v_current_reserved THEN
                SET p_result_code = 2;
                SET p_message = CONCAT('WARNING: Adjusted stock (', v_new_on_hand, 
                                      ') is less than reserved (', v_current_reserved, '). Review reservations!');
            ELSE
                SET p_result_code = 0;
                SET p_message = CONCAT('SUCCESS: Adjusted inventory by ', p_quantity_change, 
                                      ' units. New stock: ', v_new_on_hand);
            END IF;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
        
        -- RETURN: Customer return (adds to stock, may release reservation)
        WHEN 'RETURN' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Processed return of ', p_quantity_change, 
                                   ' units. New stock: ', v_new_on_hand,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- Invalid operation
        ELSE
            SET p_result_code = 1;
            SET p_message = CONCAT('ERROR: Invalid operation "', p_operation, 
                                   '". Must be: ADD_STOCK, REMOVE_STOCK, RESERVE, RELEASE_SHIP, RELEASE_CANCEL, ADJUST, or RETURN');
            ROLLBACK;
            LEAVE sp_UpdateInventory;
    END CASE;
    
    -- Commit the transaction
    COMMIT;
    
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

-- Test 1: Add new stock (receiving from supplier)
CALL sp_UpdateInventory(1, 1, 50, 'ADD_STOCK', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 2: Reserve items for order
CALL sp_UpdateInventory(1, 1, 10, 'RESERVE', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 3: Try to reserve more than available (should fail)
CALL sp_UpdateInventory(1, 1, 500, 'RESERVE', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 4: Release reserved items after shipment
CALL sp_UpdateInventory(1, 1, 5, 'RELEASE_SHIP', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 5: Cancel order and release reservation
CALL sp_UpdateInventory(1, 1, 3, 'RELEASE_CANCEL', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Verify final state
SELECT 
    w.name as warehouse,
    pv.sku,
    i.on_hand,
    i.reserved,
    (i.on_hand - i.reserved) as available
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN ProductVariants pv ON i.variant_id = pv.variant_id
WHERE i.warehouse_id = 1 AND i.variant_id = 1;
