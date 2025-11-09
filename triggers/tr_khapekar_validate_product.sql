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
    -- 1. Title must not be empty or NULL
    IF NEW.title IS NULL OR TRIM(NEW.title) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product title cannot be empty';
    END IF;

    -- 2. Category ID must exist in the Categories table
    IF NOT EXISTS (
        SELECT 1 FROM Categories WHERE category_id = NEW.category_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid category_id – category does not exist';
    END IF;

    -- 3. Title must not already exist (simple uniqueness check)
    IF EXISTS (
        SELECT 1 FROM Products WHERE title = NEW.title
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A product with this title already exists';
    END IF;
END//

DELIMITER ;

-- Test the trigger
INSERT INTO Products (category_id, title, description, brand)
VALUES (31, 'Acoustic Guitar Beginner', 'Simple beginner friendly guitar', 'Fender');

