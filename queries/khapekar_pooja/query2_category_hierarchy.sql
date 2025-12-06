-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 2 - Category Hierarchy with Product Count
-- Tables: Categories, Products, ProductImages
-- =============================================

-- BUSINESS USE CASE:
-- This query gives a snapshot of the category structure, showing how many products and images exist per category. It helps teams identify:
-- Underpopulated or image-deficient categories
-- Readiness of product categories for campaigns
-- Gaps in catalog coverage or merchandising focus

-- REAL-WORLD SCENARIO:
-- Before a major sale, teams run this to check if all featured categories have enough products and visuals. If a category has products but no images, it's flagged for immediate content upload.

-- Impact:
-- Ensures catalog completeness, better customer experience, and supports campaign planning with accurate product distribution data.


  
USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Display category hierarchy (parent-child) with product counts


SELECT 
  pcat.name AS parent_category,
  ccat.name AS subcategory,
  pr.title AS product_title,
  pr.brand,
  pi.url AS product_image
FROM Categories ccat
LEFT JOIN Categories pcat 
  ON ccat.parent_id = pcat.category_id               -- Get parent category
JOIN Products pr 
  ON pr.category_id = ccat.category_id               -- Get products in the subcategory
LEFT JOIN (
  SELECT product_id, MIN(url) AS url                 -- Pick 1 image per product (lowest sort_order or first)
  FROM ProductImages
  GROUP BY product_id
) pi ON pr.product_id = pi.product_id                -- Attach image
ORDER BY pcat.name, ccat.name, pr.title
LIMIT 10;                                            -- Show 10 entries
