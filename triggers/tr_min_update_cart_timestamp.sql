-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Trigger - Update Cart Timestamp
-- Tables: Carts, CartItems, Coupons
-- Purpose: Update cart timestamp when items are added/removed
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Automatically updates the cart's last modified time whenever a new item is added.

CREATE TRIGGER tr_UpdateCartTimestamp
AFTER INSERT ON CartItems
FOR EACH ROW
BEGIN
    -- Update the parent cart’s timestamp to reflect that it has new items
    UPDATE Carts 
    SET updated_at = CURRENT_TIMESTAMP
    WHERE cart_id = NEW.cart_id;
END//

DELIMITER ;

-- Test the trigger
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) VALUES (1, 1, 2, 29.99);
-- Then check:
SELECT cart_id, updated_at FROM Carts WHERE cart_id = 1;

