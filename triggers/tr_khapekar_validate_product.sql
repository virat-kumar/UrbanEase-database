-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Trigger - Validate Product Data
-- Tables: Categories, Products, ProductImages
-- Purpose: Validate product data before insert/update
-- =============================================


USE urbanease_shop;

DELIMITER //

CREATE TRIGGER tr_ValidateProduct
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    -- If title is empty, replace it
    IF NEW.title IS NULL OR NEW.title = '' THEN
        SET NEW.title = 'Untitled Product';
    END IF;

    -- If brand is NULL, replace with 'Unknown'
    IF NEW.brand IS NULL THEN
        SET NEW.brand = 'Unknown';
    END IF;

    -- If category is NULL or 0, set to default category ID = 1
    IF NEW.category_id IS NULL OR NEW.category_id = 0 THEN
        SET NEW.category_id = 1;
    END IF;
END//

DELIMITER ;

-- Test the trigger
INSERT INTO Products (category_id, title, description, brand)
VALUES (NULL, '', 'Testing trigger without SIGNAL', NULL);
