-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Trigger - Validate Review Before Insert
-- Tables: Addresses, Payments, Reviews
-- Purpose: Ensure user has purchased product before reviewing
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Validate review before insertion
CREATE TRIGGER tr_ValidateReview
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    DECLARE has_purchased INT DEFAULT 0;
    
    -- TODO: Implement your trigger logic here
    
    -- Example: Check if user has purchased the product
    -- SELECT COUNT(*) INTO has_purchased
    -- FROM Orders o
    -- JOIN OrderItems oi ON o.order_id = oi.order_id
    -- JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
    -- WHERE o.user_id = NEW.user_id 
    --   AND pv.product_id = NEW.product_id
    --   AND o.status = 'FULFILLED';
    
    -- IF has_purchased = 0 THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'User must purchase product before reviewing';
    -- END IF;
    
    -- You could also:
    -- - Validate rating range (1-5)
    -- - Check for duplicate reviews
    -- - Sanitize review content
    
END//

DELIMITER ;

-- Test the trigger
-- INSERT INTO Reviews (product_id, user_id, rating, title, body) 
-- VALUES (1, 1, 5, 'Great!', 'Excellent product');

