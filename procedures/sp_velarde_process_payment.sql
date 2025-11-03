-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Stored Procedure - Process Payment
-- Tables: Addresses, Payments, Reviews
-- Purpose: Record payment transaction for an order
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE PROCEDURE sp_ProcessPayment(
    IN p_order_id BIGINT,
    IN p_provider VARCHAR(40),
    IN p_provider_ref VARCHAR(120),
    IN p_amount DECIMAL(12,2)
)
BEGIN
    -- TODO: Implement your stored procedure logic here
    
    -- Example structure:
    -- 1. Validate order exists
    -- 2. Insert payment record
    -- 3. Update order status to 'PAID'
    -- 4. Return payment confirmation
    
    SELECT 'Procedure not implemented yet' as message;
END//

DELIMITER ;

-- Test the procedure
-- CALL sp_ProcessPayment(1, 'Stripe', 'ch_123456', 99.99);

