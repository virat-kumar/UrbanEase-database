-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Categories Table (30 entries total: 10 root + 20 subcategories)
-- Module: Product Catalog
-- =============================================

USE urbanease_shop;

-- Root categories (10 main categories)

INSERT INTO Categories (parent_id, name, slug) VALUES 
(NULL, 'Electronics', 'electronics'),
(NULL, 'Clothing', 'clothing'),
(NULL, 'Home & Garden', 'home-garden'),
(NULL, 'Beauty & Personal Care', 'beauty-personal-care'),
(NULL, 'Health & Wellness', 'health-wellness'),
(NULL, 'Sports & Outdoors', 'sports-outdoors'),
(NULL, 'Toys & Games', 'toys-games'),
(NULL, 'Automotive', 'automotive'),
(NULL, 'Books & Stationery', 'books-stationery'),
(NULL, 'Groceries', 'groceries');

  
-- Sub-categories (20 subcategories, 2 per root category)
INSERT INTO Categories (parent_id, name, slug) VALUES
-- 1. Electronics
(1, 'Laptops', 'laptops'),
(1, 'Smartphones', 'smartphones'),

-- 2. Clothing
(2, 'Men Clothing', 'men-clothing'),
(2, 'Women Clothing', 'women-clothing'),

-- 3. Home & Garden
(3, 'Furniture Sets', 'furniture-sets'),
(3, 'Home Decor', 'home-decor'),

-- 4. Beauty & Personal Care
(4, 'Skincare', 'skincare'),
(4, 'Hair Care', 'hair-care'),

-- 5. Health & Wellness
(5, 'Vitamins & Supplements', 'vitamins-supplements'),
(5, 'Fitness Equipment', 'fitness-equipment'),

-- 6. Sports & Outdoors
(6, 'Camping & Hiking', 'camping-hiking'),
(6, 'Sportswear', 'sportswear'),

-- 7. Toys & Games
(7, 'Board Games', 'board-games'),
(7, 'Action Figures', 'action-figures'),

-- 8. Automotive
(8, 'Car Accessories', 'car-accessories'),
(8, 'Motorbike Accessories', 'motorbike-accessories'),

-- 9. Books & Stationery
(9, 'Fiction Books', 'fiction-books'),
(9, 'Notebooks & Diaries', 'notebooks-diaries'),

-- 10. Groceries
(10, 'Snacks & Beverages', 'snacks-beverages'),
(10, 'Dairy Products', 'dairy-products');

SELECT * FROM Categories;

-- Verify inserted data
SELECT COUNT(*) AS total_categories FROM Categories;
SELECT * FROM Categories WHERE parent_id IS NULL LIMIT 10;
SELECT c.name AS subcategory, p.name AS parent_category 
FROM Categories c 
LEFT JOIN Categories p ON c.parent_id = p.category_id 
WHERE c.parent_id IS NOT NULL 
LIMIT 10;
