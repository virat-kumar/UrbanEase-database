-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 1 - Products by Category with Images
-- Tables: Categories, Products, ProductImages
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Get products with their categories and image count


SELECT 
  p.product_id,
  p.title AS product_title,
  c.name AS category_name,
  COUNT(pi.image_id) AS total_images
FROM Products p
LEFT JOIN Categories c 
  ON p.category_id = c.category_id          -- Join with category to get category name
LEFT JOIN ProductImages pi 
  ON p.product_id = pi.product_id           -- Join with images to count them
GROUP BY p.product_id, p.title, c.name      -- Group by product and category for aggregation
ORDER BY total_images DESC, p.title         -- Sort by most images, then by title
LIMIT 10;                                   -- Limit to 10 records
