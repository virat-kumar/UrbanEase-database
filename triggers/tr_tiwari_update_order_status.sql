-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Trigger - Update Order Status on Shipment
-- Tables: Orders, OrderItems, Shipments
-- Purpose: Automatically update order status when shipment is created
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE TRIGGER tr_UpdateOrderStatus
AFTER INSERT ON Shipments
FOR EACH ROW
BEGIN
    DECLARE total_shipments INT;
    DECLARE delivered_shipments INT;

    -- 1. Count total shipments for the order
    SELECT COUNT(*) INTO total_shipments
    FROM Shipments
    WHERE order_id = NEW.order_id;

    -- 2. Count shipments that are delivered
    SELECT COUNT(*) INTO delivered_shipments
    FROM Shipments
    WHERE order_id = NEW.order_id
      AND status = 'DELIVERED';

    -- 3. If all shipments delivered, update order status to FULFILLED
    IF total_shipments = delivered_shipments THEN
        UPDATE Orders
        SET status = 'FULFILLED',
            updated_at = NOW()
        WHERE order_id = NEW.order_id;
    END IF;

END//

DELIMITER ;


-- Test the trigger
-- Insert a shipment
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at)
VALUES (16, 1, 'FedEx', 'TRACK9999', 'DELIVERED', NOW());

-- Check if order 16 status updates
SELECT order_id, status FROM Orders WHERE order_id = 16;


