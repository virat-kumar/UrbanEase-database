-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Trigger - Update Order Status on Shipment
-- Tables: Orders, OrderItems, Shipments
-- Purpose: Automatically update order status when shipment is created
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Update order status when shipment is created
CREATE TRIGGER tr_UpdateOrderStatus
AFTER INSERT ON Shipments
FOR EACH ROW
BEGIN
    -- TODO: Implement your trigger logic here
    
    -- Example: Update order status to FULFILLED
    -- UPDATE Orders 
    -- SET status = 'FULFILLED', updated_at = UTC_TIMESTAMP()
    -- WHERE order_id = NEW.order_id;
    
    -- You could also:
    -- - Send notification email
    -- - Update inventory
    -- - Log shipment creation
    
END//

DELIMITER ;

-- Test the trigger
-- INSERT INTO Shipments (order_id, carrier, status) VALUES (1, 'FedEx', 'CREATED');

