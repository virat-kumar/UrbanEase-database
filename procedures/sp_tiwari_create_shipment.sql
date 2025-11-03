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
    -- TODO: Implement your stored procedure logic here
    
    -- Example structure:
    -- 1. Validate order exists
    -- 2. Create shipment record
    -- 3. Update order status
    -- 4. Update inventory (deduct reserved stock)
    
    SELECT 'Procedure not implemented yet' as message;
END//

DELIMITER ;

-- Test the procedure
-- CALL sp_CreateShipment(1, 1, 'FedEx', 'TRACK12345');

