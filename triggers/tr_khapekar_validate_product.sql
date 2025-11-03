-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Trigger - Validate Product Data
-- Tables: Categories, Products, ProductImages
-- Purpose: Validate product data before insert/update
-- =============================================

USE urbanease_shop;

DELIMITER //

-- Example: Validate product before insertion
CREATE TRIGGER tr_ValidateProduct
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    -- TODO: Implement your trigger logic here
    
    -- Example validations:
    -- IF NEW.title IS NULL OR NEW.title = '' THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'Product title cannot be empty';
    -- END IF;
    
    -- You could also:
    -- - Validate category exists
    -- - Check for duplicate titles
    -- - Enforce business rules
    
END//

DELIMITER ;

-- Test the trigger
-- INSERT INTO Products (title, category_id) VALUES ('Test', 1);

