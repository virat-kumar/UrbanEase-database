-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 3 - Products Without Images
-- Tables: Categories, Products, ProductImages
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Find products that don't have any images


SELECT 
  p.product_id,
  p.title AS product_title,
  p.brand,
  c.name AS category_name
FROM Products p
LEFT JOIN ProductImages pi 
  ON p.product_id = pi.product_id              -- Try to join image
LEFT JOIN Categories c 
  ON p.category_id = c.category_id             -- Get category info
WHERE pi.product_id IS NULL                    -- Keep only those with no image match
ORDER BY p.created_at DESC
LIMIT 10;                                      -- Just 10 records for review
