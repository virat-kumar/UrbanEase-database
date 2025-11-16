-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Function - Get Product Image Count
-- Tables: Categories, Products, ProductImages
-- Returns: Number of images for a product
-- =============================================



USE urbanease_shop;

DELIMITER $$

CREATE FUNCTION fn_GetProductImageCount(
    p_product_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE image_count INT DEFAULT 0;

    -- Count how many images exist for this product
    SELECT COUNT(*) INTO image_count
    FROM ProductImages
    WHERE product_id = p_product_id;

    -- Return the result
    RETURN image_count;
END$$

-- Reset the delimiter back to default
DELIMITER ;

-- Test the function
SELECT fn_GetProductImageCount(25) AS total_images;
