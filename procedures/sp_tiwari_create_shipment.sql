-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Stored Procedure - Create Shipment
-- Tables: Orders, OrderItems, Shipments
-- Purpose: Create shipment for an order and update status
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE PROCEDURE sp_CreateShipment(
    IN p_order_id BIGINT,
    IN p_warehouse_id BIGINT,
    IN p_carrier VARCHAR(80),
    IN p_tracking_no VARCHAR(120)
)
BEGIN
    DECLARE v_order_status VARCHAR(20);

    -- Validate order exists
    SELECT status INTO v_order_status
    FROM Orders
    WHERE order_id = p_order_id;

    IF v_order_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order does not exist';
    ELSE
        -- Create shipment record
        INSERT INTO Shipments(order_id, warehouse_id, carrier, tracking_no, status, shipped_at)
        VALUES (p_order_id, p_warehouse_id, p_carrier, p_tracking_no, 'CREATED', NOW());

    END IF;
END//

-- Test the procedure
CALL sp_CreateShipment(16, 1, 'FedEx', 'TRACK12345');

