-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Categories Table (90 entries total: 30 root + 60 subcategories)
-- Module: Product Catalog
-- =============================================

USE urbanease_shop;

-- Root categories (30 main categories)
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
  
-- Sub-categories (60 subcategories, 2 per root category)
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
(10, 'Dairy Products', 'dairy-products'),

-- 11. Baby & Kids
(11, 'Baby Clothing', 'baby-clothing'),
(11, 'Baby Care', 'baby-care'),

-- 12. Jewelry & Accessories
(12, 'Necklaces', 'necklaces'),
(12, 'Earrings', 'earrings'),

-- 13. Shoes & Footwear
(13, 'Men Footwear', 'men-footwear'),
(13, 'Women Footwear', 'women-footwear'),

-- 14. Pet Supplies
(14, 'Dog Supplies', 'dog-supplies'),
(14, 'Cat Supplies', 'cat-supplies'),

-- 15. Furniture
(15, 'Living Room Furniture', 'living-room-furniture'),
(15, 'Bedroom Furniture', 'bedroom-furniture'),

-- 16. Office Supplies
(16, 'Printers & Scanners', 'printers-scanners'),
(16, 'Desk Accessories', 'desk-accessories'),

-- 17. Tools & Hardware
(17, 'Power Tools', 'power-tools'),
(17, 'Hand Tools', 'hand-tools'),

-- 18. Musical Instruments
(18, 'Guitars', 'guitars'),
(18, 'Keyboards', 'keyboards'),

-- 19. Arts & Crafts
(19, 'Painting Supplies', 'painting-supplies'),
(19, 'Craft Kits', 'craft-kits'),

-- 20. Cameras & Photography
(20, 'DSLR Cameras', 'dslr-cameras'),
(20, 'Camera Lenses', 'camera-lenses'),

-- 21. Computers & Laptops
(21, 'Desktops', 'desktops'),
(21, 'Gaming Laptops', 'gaming-laptops'),

-- 22. Mobile Phones & Tablets
(22, 'Android Phones', 'android-phones'),
(22, 'iPhones', 'iphones'),

-- 23. Appliances
(23, 'Refrigerators', 'refrigerators'),
(23, 'Washing Machines', 'washing-machines'),

-- 24. Travel & Luggage
(24, 'Suitcases', 'suitcases'),
(24, 'Backpacks', 'backpacks'),

-- 25. Movies & Entertainment
(25, 'DVDs & Blu-rays', 'dvds-blurays'),
(25, 'Music Albums', 'music-albums'),

-- 26. Gaming
(26, 'Consoles', 'consoles'),
(26, 'Video Games', 'video-games'),

-- 27. Watches
(27, 'Men Watches', 'men-watches'),
(27, 'Smart Watches', 'smart-watches'),

-- 28. Kitchen & Dining
(28, 'Cookware', 'cookware'),
(28, 'Tableware', 'tableware'),

-- 29. Seasonal & Holiday
(29, 'Christmas Decor', 'christmas-decor'),
(29, 'Halloween Supplies', 'halloween-supplies'),

-- 30. Safety & Security
(30, 'Home Security Systems', 'home-security-systems'),
(30, 'Surveillance Cameras', 'surveillance-cameras');

-- Verify inserted data
SELECT COUNT(*) AS total_categories FROM Categories;
SELECT * FROM Categories WHERE parent_id IS NULL LIMIT 10;
SELECT c.name AS subcategory, p.name AS parent_category 
FROM Categories c 
LEFT JOIN Categories p ON c.parent_id = p.category_id 
WHERE c.parent_id IS NOT NULL 
LIMIT 10;
