-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Create Products Table
-- Module: Product Catalog
-- Note: Requires Categories table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
  product_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NULL,
  title       VARCHAR(200) NOT NULL,
  description TEXT NULL,
  brand       VARCHAR(100) NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at  DATETIME NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
  CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Products COMMENT = 'Product master data (title, description, brand)';

-- Create index for category lookups
CREATE INDEX IX_Product_Category ON Products(category_id);

-- Verify table creation
DESC Products;

-- Example: Insert sample products
/*
INSERT INTO Products (category_id, title, description, brand, is_active) VALUES 
  (1, 'MacBook Pro 16"', 'Powerful laptop for professionals', 'Apple', TRUE),
  (2, 'iPhone 15 Pro', 'Latest flagship smartphone', 'Apple', TRUE),
  (3, 'Wireless Mouse', 'Ergonomic wireless mouse', 'Logitech', TRUE);
*/

-- Example: Query to see products with categories
-- SELECT p.title, p.brand, c.name as category, p.is_active
-- FROM Products p
-- LEFT JOIN Categories c ON p.category_id = c.category_id;

/* Actual query created by Pooja */

CREATE TABLE Products (
  product_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NULL,
  title       VARCHAR(200) NOT NULL,
  description TEXT NULL,
  brand       VARCHAR(100) NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Products COMMENT = 'Product master data (title, description, brand)';

-- Create index for category lookups
CREATE INDEX IX_Product_Category ON Products(category_id);

-- Verify table creation
DESC Products;

INSERT INTO Products (category_id, title, description, brand, is_active) VALUES
-- 1. Electronics
(1, 'MacBook Pro 16"', 'Powerful laptop for professionals', 'Apple', TRUE),
-- 2. Clothing
(2, 'Classic Denim Jacket', 'Stylish and durable denim jacket for all seasons', 'Levi’s', TRUE),
-- 3. Home & Garden
(3, 'Indoor Plant Set', 'Three assorted air-purifying indoor plants', 'UrbanLeaf', TRUE),
-- 4. Beauty & Personal Care
(4, 'Hydrating Face Serum', 'Vitamin C enriched lightweight serum', 'The Ordinary', TRUE),
-- 5. Health & Wellness
(5, 'Yoga Mat Pro', 'Non-slip yoga mat for workouts and meditation', 'Lululemon', TRUE),
-- 6. Sports & Outdoors
(6, 'Hiking Backpack 50L', 'Water-resistant outdoor hiking bag', 'Quechua', TRUE),
-- 7. Toys & Games
(7, 'LEGO City Set', 'Creative building toy for kids aged 6+', 'LEGO', TRUE),
-- 8. Automotive
(8, 'Car Vacuum Cleaner', 'Portable and rechargeable car vacuum', 'Armor All', TRUE),
-- 9. Books & Stationery
(9, 'Hardcover Journal', 'Premium ruled journal notebook', 'Moleskine', TRUE),
-- 10. Groceries
(10, 'Organic Green Tea Pack', '100% natural antioxidant-rich tea bags', 'Lipton', TRUE),
-- 11. Baby & Kids
(11, 'Baby Diaper Pack', 'Ultra-soft leak-proof diapers', 'Pampers', TRUE),
-- 12. Jewelry & Accessories
(12, 'Gold-Plated Necklace', 'Elegant minimal chain for daily wear', 'Tanishq', TRUE),
-- 13. Shoes & Footwear
(13, 'Running Shoes', 'Breathable mesh running shoes', 'Nike', TRUE),
-- 14. Pet Supplies
(14, 'Dog Food 10kg', 'Healthy dry food for adult dogs', 'Pedigree', TRUE),
-- 15. Furniture
(15, 'Wooden Coffee Table', 'Contemporary design with oak finish', 'IKEA', TRUE),
-- 16. Office Supplies
(16, 'Wireless Printer', 'Compact Wi-Fi printer with scanner', 'HP', TRUE),
-- 17. Tools & Hardware
(17, 'Cordless Drill Set', '18V drill with accessories', 'Bosch', TRUE),
-- 18. Musical Instruments
(18, 'Acoustic Guitar', 'Full-size 6-string beginner guitar', 'Yamaha', TRUE),
-- 19. Arts & Crafts
(19, 'Acrylic Paint Kit', 'Set of 24 vibrant paint colors', 'Camlin', TRUE),
-- 20. Cameras & Photography
(20, 'DSLR Camera', 'Professional camera with 24MP sensor', 'Canon', TRUE),
-- 21. Computers & Laptops
(21, 'Gaming Laptop', 'High-performance gaming laptop with RTX GPU', 'ASUS', TRUE),
-- 22. Mobile Phones & Tablets
(22, 'Samsung Galaxy S24', 'Flagship Android smartphone', 'Samsung', TRUE),
-- 23. Appliances
(23, 'Smart Refrigerator', 'Double-door fridge with energy efficiency', 'LG', TRUE),
-- 24. Travel & Luggage
(24, 'Hard Shell Suitcase', 'Lightweight spinner luggage 28-inch', 'American Tourister', TRUE),
-- 25. Movies & Entertainment
(25, 'Blu-ray Movie Set', 'Collector’s edition of top-rated films', 'Universal', TRUE),
-- 26. Gaming
(26, 'PlayStation 5', 'Next-gen gaming console', 'Sony', TRUE),
-- 27. Watches
(27, 'Smartwatch Series 9', 'Health tracking and fitness features', 'Apple', TRUE),
-- 28. Kitchen & Dining
(28, 'Non-Stick Cookware Set', 'Durable pots and pans for daily use', 'Tefal', TRUE),
-- 29. Seasonal & Holiday
(29, 'Christmas LED Lights', 'Colorful decorative string lights', 'Philips', TRUE),
-- 30. Safety & Security
(30, 'Smart Doorbell Camera', 'Wi-Fi enabled video doorbell with motion detection', 'Ring', TRUE);


SELECT * FROM products;


