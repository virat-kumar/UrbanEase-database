-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Function - Get Product Image Count
-- Tables: Categories, Products, ProductImages
-- Returns: Number of images for a product
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE FUNCTION fn_GetProductImageCount(
    p_product_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE image_count INT DEFAULT 0;
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT COUNT(*) INTO image_count
    -- FROM ProductImages
    -- WHERE product_id = p_product_id;
    
    RETURN image_count;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_GetProductImageCount(1);

