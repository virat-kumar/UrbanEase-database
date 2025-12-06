-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 1 - Products by Category with Images
-- Tables: Categories, Products, ProductImages
-- =============================================

-- BUSINESS USE CASE:
-- This query lists all products within each category along with their images. It's used to:
-- Validate visual completeness of the product catalog
-- Support merchandising teams in reviewing product readiness
-- Enable marketing to confirm image coverage for featured categories

-- REAL-WORLD SCENARIO:
-- Before launching a category-specific campaign (e.g., "Winter Jackets"), the team uses this query to ensure all listed products have the required number of images.

-- Impact:
-- Improves product presentation, reduces visual gaps, and ensures high-quality listings across all categories.



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
