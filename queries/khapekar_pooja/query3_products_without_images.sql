-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 3 - Products Without Images
-- Tables: Categories, Products, ProductImages
-- =============================================

--- BUSINESS USE CASE:
This query identifies products that are missing images, helping teams quickly locate and fix incomplete listings. It's essential for:
Catalog QA and content cleanup
Preventing customer drop-offs due to missing visuals
Ensuring all products meet listing standards

--- REAL-WORLD SCENARIO:
Before a site-wide sale, this query flags 40 products with no images. The content team is alerted to upload missing visuals before the event goes live.

--- Impact:
 Avoids lost conversions, improves product discoverability, and maintains professional catalog standards.



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
