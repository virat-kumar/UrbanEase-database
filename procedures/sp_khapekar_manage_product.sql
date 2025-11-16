-- =============================================
-- Author: Khapekar, Pooja
-- Create date: Noovember 2025
-- Description: Stored Procedure - Manage Product with Images
-- Tables: Categories, Products, ProductImages
-- Purpose: Create or update product with category and images
-- =============================================


USE urbanease_shop;

DELIMITER $$
CREATE PROCEDURE sp_ManageProduct(
    IN p_product_id BIGINT,
    IN p_category_id BIGINT,
    IN p_title VARCHAR(200),
    IN p_description TEXT,
    IN p_brand VARCHAR(100),
    IN p_image_url VARCHAR(512),
    IN p_image_alt_text VARCHAR(160),
    IN p_image_sort_order INT
)
BEGIN
    DECLARE v_product_id BIGINT;

    -- INSERT if product_id is NULL
    IF p_product_id IS NULL THEN
        INSERT INTO Products (
            category_id, title, description, brand, is_active
        )
        VALUES (
            p_category_id, p_title, p_description, p_brand, TRUE
        );

        -- Get the new product_id
        SET v_product_id = LAST_INSERT_ID();

    ELSE
        -- UPDATE the existing product
        UPDATE Products
        SET 
            category_id = p_category_id,
            title = p_title,
            description = p_description,
            brand = p_brand,
            updated_at = NOW()
        WHERE 
            product_id = p_product_id;

        -- Use the existing product_id
        SET v_product_id = p_product_id;

        -- Delete old images before inserting new one
        DELETE FROM ProductImages 
        WHERE product_id = v_product_id;
    END IF;

    -- Insert the image if image URL is provided
    IF p_image_url IS NOT NULL AND p_image_url != '' THEN
        INSERT INTO ProductImages (
            product_id, url, alt_text, sort_order
        )
        VALUES (
            v_product_id, p_image_url, p_image_alt_text, p_image_sort_order
        );
    END IF;

    -- Return the operation result
    SELECT 
        v_product_id AS product_id,
        IF(p_product_id IS NULL, 'Created', 'Updated') AS operation,
        'Success' AS status;

END$$

DELIMITER ;

select * from products;

-- Update existing product (e.g., ID = 1) with new image
CALL sp_ManageProduct(
    1,
    1,
    'Guitar',
    'Amazing Electric Guitar',
    'Yamaha',
    'https://cdn.urbanease.com/images/guitar-updated.jpg',
    'New Image',
    0
);

