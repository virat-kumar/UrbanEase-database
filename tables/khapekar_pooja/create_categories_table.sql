-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Create Categories Table
-- Module: Product Catalog
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  parent_id   BIGINT NULL,
  name        VARCHAR(120) NOT NULL,
  slug        VARCHAR(160) NOT NULL UNIQUE,
  CONSTRAINT FK_Category_Parent FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Categories COMMENT = 'Product categories with hierarchical parent-child relationships';

-- Create index for parent_id lookups
CREATE INDEX IX_Category_Parent ON Categories(parent_id);

-- Verify table creation
DESC Categories;

-- Example: Insert sample categories
/*
-- Root categories
INSERT INTO Categories (parent_id, name, slug) VALUES 
  (NULL, 'Electronics', 'electronics'),
  (NULL, 'Clothing', 'clothing'),
  (NULL, 'Home & Garden', 'home-garden');

-- Sub-categories (assuming Electronics has category_id = 1)
INSERT INTO Categories (parent_id, name, slug) VALUES 
  (1, 'Laptops', 'laptops'),
  (1, 'Smartphones', 'smartphones'),
  (1, 'Accessories', 'electronics-accessories');
*/

-- Example: Query to see category hierarchy
-- SELECT 
--   child.name AS subcategory,
--   parent.name AS parent_category
-- FROM Categories child
-- LEFT JOIN Categories parent ON child.parent_id = parent.category_id;


/* Sample Values Created by Pooja */
-- Actual query with values


CREATE TABLE Categories (
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  parent_id   BIGINT NULL,
  name        VARCHAR(120) NOT NULL,
  slug        VARCHAR(160) NOT NULL UNIQUE,
  CONSTRAINT FK_Category_Parent FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Categories COMMENT = 'Product categories with hierarchical parent-child relationships';

-- Create index for parent_id lookups
CREATE INDEX IX_Category_Parent ON Categories(parent_id);

-- Verify table creation
DESC Categories;

-- Root categories
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
  (NULL, 'Groceries', 'groceries'),
  (NULL, 'Baby & Kids', 'baby-kids'),
  (NULL, 'Jewelry & Accessories', 'jewelry-accessories'),
  (NULL, 'Shoes & Footwear', 'shoes-footwear'),
  (NULL, 'Pet Supplies', 'pet-supplies'),
  (NULL, 'Furniture', 'furniture'),
  (NULL, 'Office Supplies', 'office-supplies'),
  (NULL, 'Tools & Hardware', 'tools-hardware'),
  (NULL, 'Musical Instruments', 'musical-instruments'),
  (NULL, 'Arts & Crafts', 'arts-crafts'),
  (NULL, 'Cameras & Photography', 'cameras-photography'),
  (NULL, 'Computers & Laptops', 'computers-laptops'),
  (NULL, 'Mobile Phones & Tablets', 'mobile-phones-tablets'),
  (NULL, 'Appliances', 'appliances'),
  (NULL, 'Travel & Luggage', 'travel-luggage'),
  (NULL, 'Movies & Entertainment', 'movies-entertainment'),
  (NULL, 'Gaming', 'gaming'),
  (NULL, 'Watches', 'watches'),
  (NULL, 'Kitchen & Dining', 'kitchen-dining'),
  (NULL, 'Seasonal & Holiday', 'seasonal-holiday'),
  (NULL, 'Safety & Security', 'safety-security');
  
  -- Sub-categories (assuming Electronics has category_id = 1)
INSERT INTO Categories (parent_id, name, slug) VALUES
-- 1. Electronics
(1, 'Laptops', 'laptops'),
(1, 'Smartphones', 'smartphones'),
(1, 'Electronics Accessories', 'electronics-accessories'),

-- 2. Clothing
(2, 'Men Clothing', 'men-clothing'),
(2, 'Women Clothing', 'women-clothing'),
(2, 'Kids Clothing', 'kids-clothing'),

-- 3. Home & Garden
(3, 'Furniture Sets', 'furniture-sets'),
(3, 'Home Decor', 'home-decor'),
(3, 'Outdoor Gardening', 'outdoor-gardening'),

-- 4. Beauty & Personal Care
(4, 'Skincare', 'skincare'),
(4, 'Hair Care', 'hair-care'),
(4, 'Makeup', 'makeup'),

-- 5. Health & Wellness
(5, 'Vitamins & Supplements', 'vitamins-supplements'),
(5, 'Fitness Equipment', 'fitness-equipment'),
(5, 'Personal Care Devices', 'personal-care-devices'),

-- 6. Sports & Outdoors
(6, 'Camping & Hiking', 'camping-hiking'),
(6, 'Sportswear', 'sportswear'),
(6, 'Fitness Accessories', 'fitness-accessories'),

-- 7. Toys & Games
(7, 'Board Games', 'board-games'),
(7, 'Action Figures', 'action-figures'),
(7, 'Educational Toys', 'educational-toys'),

-- 8. Automotive
(8, 'Car Accessories', 'car-accessories'),
(8, 'Motorbike Accessories', 'motorbike-accessories'),
(8, 'Car Care Products', 'car-care-products'),

-- 9. Books & Stationery
(9, 'Fiction Books', 'fiction-books'),
(9, 'Notebooks & Diaries', 'notebooks-diaries'),
(9, 'Office Stationery', 'office-stationery'),

-- 10. Groceries
(10, 'Snacks & Beverages', 'snacks-beverages'),
(10, 'Dairy Products', 'dairy-products'),
(10, 'Cereals & Grains', 'cereals-grains'),

-- 11. Baby & Kids
(11, 'Baby Clothing', 'baby-clothing'),
(11, 'Baby Care', 'baby-care'),
(11, 'Toys for Babies', 'toys-for-babies'),

-- 12. Jewelry & Accessories
(12, 'Necklaces', 'necklaces'),
(12, 'Earrings', 'earrings'),
(12, 'Bracelets', 'bracelets'),

-- 13. Shoes & Footwear
(13, 'Men Footwear', 'men-footwear'),
(13, 'Women Footwear', 'women-footwear'),
(13, 'Sports Shoes', 'sports-shoes'),

-- 14. Pet Supplies
(14, 'Dog Supplies', 'dog-supplies'),
(14, 'Cat Supplies', 'cat-supplies'),
(14, 'Aquarium Accessories', 'aquarium-accessories'),

-- 15. Furniture
(15, 'Living Room Furniture', 'living-room-furniture'),
(15, 'Bedroom Furniture', 'bedroom-furniture'),
(15, 'Office Furniture', 'office-furniture'),

-- 16. Office Supplies
(16, 'Printers & Scanners', 'printers-scanners'),
(16, 'Desk Accessories', 'desk-accessories'),
(16, 'Writing Tools', 'writing-tools'),

-- 17. Tools & Hardware
(17, 'Power Tools', 'power-tools'),
(17, 'Hand Tools', 'hand-tools'),
(17, 'Safety Gear', 'safety-gear'),

-- 18. Musical Instruments
(18, 'Guitars', 'guitars'),
(18, 'Keyboards', 'keyboards'),
(18, 'Drums & Percussion', 'drums-percussion'),

-- 19. Arts & Crafts
(19, 'Painting Supplies', 'painting-supplies'),
(19, 'Craft Kits', 'craft-kits'),
(19, 'Drawing Tools', 'drawing-tools'),

-- 20. Cameras & Photography
(20, 'DSLR Cameras', 'dslr-cameras'),
(20, 'Camera Lenses', 'camera-lenses'),
(20, 'Tripods & Mounts', 'tripods-mounts'),

-- 21. Computers & Laptops
(21, 'Desktops', 'desktops'),
(21, 'Gaming Laptops', 'gaming-laptops'),
(21, 'Computer Accessories', 'computer-accessories'),

-- 22. Mobile Phones & Tablets
(22, 'Android Phones', 'android-phones'),
(22, 'iPhones', 'iphones'),
(22, 'Tablets & iPads', 'tablets-ipads'),

-- 23. Appliances
(23, 'Refrigerators', 'refrigerators'),
(23, 'Washing Machines', 'washing-machines'),
(23, 'Microwave Ovens', 'microwave-ovens'),

-- 24. Travel & Luggage
(24, 'Suitcases', 'suitcases'),
(24, 'Backpacks', 'backpacks'),
(24, 'Travel Accessories', 'travel-accessories'),

-- 25. Movies & Entertainment
(25, 'DVDs & Blu-rays', 'dvds-blurays'),
(25, 'Music Albums', 'music-albums'),
(25, 'Streaming Devices', 'streaming-devices'),

-- 26. Gaming
(26, 'Consoles', 'consoles'),
(26, 'Video Games', 'video-games'),
(26, 'Gaming Accessories', 'gaming-accessories'),

-- 27. Watches
(27, 'Men Watches', 'men-watches'),
(27, 'Women Watches', 'women-watches'),
(27, 'Smart Watches', 'smart-watches'),

-- 28. Kitchen & Dining
(28, 'Cookware', 'cookware'),
(28, 'Tableware', 'tableware'),
(28, 'Kitchen Storage', 'kitchen-storage'),

-- 29. Seasonal & Holiday
(29, 'Christmas Decor', 'christmas-decor'),
(29, 'Halloween Supplies', 'halloween-supplies'),
(29, 'Festival Lights', 'festival-lights'),

-- 30. Safety & Security
(30, 'Home Security Systems', 'home-security-systems'),
(30, 'Surveillance Cameras', 'surveillance-cameras'),
(30, 'Fire Safety Equipment', 'fire-safety-equipment');

SELECT 
child.name AS subcategory,
parent.name AS parent_category
FROM Categories child
LEFT JOIN Categories parent ON child.parent_id = parent.category_id;  

SELECT * FROM Categories;



