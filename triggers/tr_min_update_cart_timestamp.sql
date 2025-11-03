-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Trigger - Update Cart Timestamp
-- Tables: Carts, CartItems, Coupons
-- Purpose: Update cart timestamp when items are added/removed
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Update cart timestamp when items change
CREATE TRIGGER tr_UpdateCartTimestamp
AFTER INSERT ON CartItems
FOR EACH ROW
BEGIN
    -- TODO: Implement your trigger logic here
    
    -- Example: Update parent cart timestamp
    -- UPDATE Carts 
    -- SET updated_at = UTC_TIMESTAMP() 
    -- WHERE cart_id = NEW.cart_id;
    
    -- You could also:
    -- - Validate cart item quantity
    -- - Check product availability
    -- - Apply automatic discounts
    
END//

DELIMITER ;

-- Test the trigger
-- INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) VALUES (1, 1, 2, 29.99);

