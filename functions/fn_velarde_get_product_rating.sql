-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Function - Get Product Average Rating
-- Tables: Addresses, Payments, Reviews
-- Returns: Average rating for a product
-- =============================================

USE urbanease_shop;

DELIMITER //

CREATE FUNCTION fn_GetProductRating(
    p_product_id BIGINT
)
RETURNS DECIMAL(3,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3,2) DEFAULT 0.00;
    
    -- TODO: Implement your function logic here
    
    -- Example structure:
    -- SELECT AVG(rating) INTO avg_rating
    -- FROM Reviews
    -- WHERE product_id = p_product_id;
    
    RETURN avg_rating;
END//

DELIMITER ;

-- Test the function
-- SELECT fn_GetProductRating(1);

