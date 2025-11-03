-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Stored Procedure - Manage Product with Images
-- Tables: Categories, Products, ProductImages
-- Purpose: Create or update product with category and images
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE PROCEDURE sp_ManageProduct(
    IN p_product_id BIGINT,
    IN p_category_id BIGINT,
    IN p_title VARCHAR(200),
    IN p_description TEXT,
    IN p_brand VARCHAR(100)
)
BEGIN
    -- TODO: Implement your stored procedure logic here
    
    -- Example structure:
    -- IF p_product_id IS NULL THEN
    --     INSERT INTO Products (category_id, title, description, brand) 
    --     VALUES (p_category_id, p_title, p_description, p_brand);
    -- ELSE
    --     UPDATE Products SET ... WHERE product_id = p_product_id;
    -- END IF;
    
    SELECT 'Procedure not implemented yet' as message;
END//

DELIMITER ;

-- Test the procedure
-- CALL sp_ManageProduct(NULL, 1, 'Test Product', 'Description', 'Brand');

