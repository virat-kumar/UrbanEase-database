-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Create Carts Table
-- Module: Shopping Cart & Promotions
-- Note: user_id can be NULL for guest carts
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Carts;

CREATE TABLE Carts (
  cart_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    BIGINT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Cart_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Add comments to document table purpose
ALTER TABLE Carts COMMENT = 'Shopping carts for registered users and guests';

-- Create index for user lookups
CREATE INDEX IX_Cart_User ON Carts(user_id);

-- Verify table creation
DESC Carts;

INSERT INTO Users (email, password_hash, full_name, phone) VALUES
  ('alice@gmail.com', UNHEX(SHA2('password1', 256)), 'Alice Johnson', '+1-555-1010'),
  ('bob@gmail.com',   UNHEX(SHA2('password2', 256)), 'Bob Smith', '+1-555-2020'),
  ('carol@gmail.com', UNHEX(SHA2('password3', 256)), 'Carol Lee', '+1-555-3030'),
  ('dave@gmail.com',  UNHEX(SHA2('password4', 256)), 'Dave Kim', '+1-555-4040'),
  ('emma@gmail.com',  UNHEX(SHA2('password5', 256)), 'Emma Brown', '+1-555-5050'),
  ('frank@gmail.com',   UNHEX(SHA2('password6', 256)), 'Frank Harris', '+1-555-6060'),
  ('grace@gmail.com',   UNHEX(SHA2('password7', 256)), 'Grace Miller', '+1-555-7070'),
  ('henry@gmail.com',   UNHEX(SHA2('password8', 256)), 'Henry Wilson', '+1-555-8080'),
  ('irene@gmail.com',   UNHEX(SHA2('password9', 256)), 'Irene Davis', '+1-555-9090'),
  ('jack@gmail.com',    UNHEX(SHA2('password10', 256)), 'Jack Thomas', '+1-555-1111'),
  ('kate@gmail.com',    UNHEX(SHA2('password11', 256)), 'Kate Turner', '+1-555-1212'),
  ('leo@gmail.com',     UNHEX(SHA2('password12', 256)), 'Leo Martinez', '+1-555-1313'),
  ('mia@gmail.com',     UNHEX(SHA2('password13', 256)), 'Mia Anderson', '+1-555-1414'),
  ('nina@gmail.com',    UNHEX(SHA2('password14', 256)), 'Nina Clark', '+1-555-1515'),
  ('oliver@gmail.com',  UNHEX(SHA2('password15', 256)), 'Oliver Hall', '+1-555-1616'),
  ('paul@gmail.com',    UNHEX(SHA2('password16', 256)), 'Paul Allen', '+1-555-1717'),
  ('quinn@gmail.com',   UNHEX(SHA2('password17', 256)), 'Quinn Evans', '+1-555-1818'),
  ('rachel@gmail.com',  UNHEX(SHA2('password18', 256)), 'Rachel Scott', '+1-555-1919'),
  ('steve@gmail.com',   UNHEX(SHA2('password19', 256)), 'Steve Parker', '+1-555-2021'),
  ('tina@gmail.com',    UNHEX(SHA2('password20', 256)), 'Tina Lewis', '+1-555-2121'),
  ('ursula@gmail.com',  UNHEX(SHA2('password21', 256)), 'Ursula Green', '+1-555-2222'),
  ('victor@gmail.com',  UNHEX(SHA2('password22', 256)), 'Victor Nguyen', '+1-555-2323');
  

-- Added values into categories table 
INSERT INTO Categories (parent_id, name, slug) VALUES
  (NULL, 'Electronics', 'electronics'),
  (1, 'Smartphones', 'smartphones'),
  (1, 'Laptops', 'laptops'),
  (1, 'Accessories', 'accessories'),
  (NULL, 'Home Appliances', 'home-appliances'),
  (NULL, 'Furniture', 'furniture'),
  (6, 'Living Room', 'living-room'),
  (6, 'Bedroom', 'bedroom'),
  (6, 'Office', 'office'),
  (NULL, 'Clothing', 'clothing'),
  (10, 'Men', 'men'),
  (10, 'Women', 'women'),
  (10, 'Kids', 'kids'),
  (NULL, 'Beauty', 'beauty'),
  (14, 'Skincare', 'skincare'),
  (14, 'Haircare', 'haircare'),
  (14, 'Makeup', 'makeup'),
  (NULL, 'Sports & Outdoors', 'sports-outdoors'),
  (18, 'Fitness', 'fitness'),
  (18, 'Camping', 'camping'),
  (NULL, 'Books', 'books'),
  (21, 'Fiction', 'fiction');



-- Added values into products table
INSERT INTO Products (category_id, title, description, brand) VALUES
  (2, 'iPhone 15', 'Apple’s latest smartphone with A17 Pro chip', 'Apple'),
  (2, 'Galaxy S24', 'Samsung flagship smartphone with AI features', 'Samsung'),
  (3, 'MacBook Air 13"', 'Lightweight laptop with M3 chip', 'Apple'),
  (3, 'Dell XPS 13', 'Compact ultrabook with Intel i7', 'Dell'),
  (4, 'AirPods Pro 2', 'Wireless noise-cancelling earbuds', 'Apple'),
  (4, 'Logitech MX Master 3S', 'Wireless mouse with ergonomic design', 'Logitech'),
  (5, 'Dyson V15 Detect', 'Cordless vacuum cleaner', 'Dyson'),
  (5, 'Instant Pot Duo 7-in-1', 'Multi-functional electric pressure cooker', 'Instant Brands'),
  (6, 'IKEA Sofa Set', 'Modern 3-seater sofa with fabric upholstery', 'IKEA'),
  (7, 'Memory Foam Mattress', 'Queen size 10-inch mattress', 'Casper'),
  (8, 'Ergonomic Office Chair', 'Mesh backrest, lumbar support', 'Herman Miller'),
  (11, 'Men’s Leather Jacket', 'Genuine leather biker jacket', 'Levi’s'),
  (12, 'Women’s Summer Dress', 'Floral cotton sundress', 'Zara'),
  (13, 'Kids Hoodie', 'Soft cotton hoodie for kids', 'Gap'),
  (15, 'Moisturizing Cream', 'Hydrating cream for dry skin', 'CeraVe'),
  (16, 'Shampoo Plus', 'Nourishing shampoo for all hair types', 'Pantene'),
  (17, 'Matte Lipstick', 'Long-lasting matte lipstick', 'Maybelline'),
  (19, 'Yoga Mat Pro', 'Eco-friendly 6mm yoga mat', 'Lululemon'),
  (20, 'Camping Tent 4P', '4-person waterproof tent', 'Coleman'),
  (1, 'Sony Bravia 55”', '4K OLED Smart TV', 'Sony'),
  (22, 'The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 'Penguin'),
  (22, '1984', 'Dystopian novel by George Orwell', 'Harvill Secker');


-- Added values into productvariants table
INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency) VALUES
  (1, 'SKU-IP15-128', '{"storage":"128GB","color":"Black"}', 999.99, 'USD'),
  (1, 'SKU-IP15-256', '{"storage":"256GB","color":"Silver"}', 1099.99, 'USD'),
  (2, 'SKU-GS24-256', '{"storage":"256GB","color":"Gray"}', 899.99, 'USD'),
  (3, 'SKU-MBA13-8',  '{"ram":"8GB","storage":"256GB"}', 1299.00, 'USD'),
  (3, 'SKU-MBA13-16', '{"ram":"16GB","storage":"512GB"}', 1599.00, 'USD'),
  (4, 'SKU-XPS13-16', '{"ram":"16GB","storage":"1TB"}', 1399.00, 'USD'),
  (5, 'SKU-APP2-WHT', '{"color":"White"}', 249.99, 'USD'),
  (6, 'SKU-LMX3S-BLK', '{"color":"Black"}', 99.99, 'USD'),
  (7, 'SKU-DYSV15', '{"accessory":"Standard Kit"}', 749.99, 'USD'),
  (8, 'SKU-IPD7', '{"size":"6QT"}', 129.99, 'USD'),
  (9, 'SKU-SOFA-GRY', '{"color":"Gray"}', 799.99, 'USD'),
  (10, 'SKU-MFM-QN', '{"size":"Queen"}', 599.99, 'USD'),
  (11, 'SKU-CHAIR-BLK', '{"color":"Black"}', 999.99, 'USD'),
  (12, 'SKU-JACKET-L', '{"size":"L","color":"Black"}', 249.99, 'USD'),
  (13, 'SKU-DRESS-M', '{"size":"M","color":"Floral"}', 79.99, 'USD'),
  (14, 'SKU-HOODIE-K', '{"size":"S","color":"Blue"}', 39.99, 'USD'),
  (15, 'SKU-CREAM-50', '{"size":"50ml"}', 14.99, 'USD'),
  (16, 'SKU-SHAMPOO-400', '{"volume":"400ml"}', 9.99, 'USD'),
  (17, 'SKU-LIP-RED', '{"shade":"Red"}', 12.99, 'USD'),
  (18, 'SKU-YOGA-GRN', '{"color":"Green"}', 39.99, 'USD'),
  (19, 'SKU-TENT-4P', '{"capacity":"4","color":"Green"}', 249.99, 'USD'),
  (20, 'SKU-TV55', '{"size":"55in"}', 1199.99, 'USD'),
  (21, 'SKU-GATSBY-PB', '{"format":"Paperback"}', 12.99, 'USD'),
  (22, 'SKU-1984-HC', '{"format":"Hardcover"}', 19.99, 'USD');

 -- Added sample values into carts table
INSERT INTO Carts (user_id) VALUES
  (1),
  (2),
  (3),
  (NULL),
  (4),
  (NULL),
  (5),
  (NULL),
  (NULL),
  (NULL),
  (6),
  (7),
  (8),
  (9),
  (10),
  (NULL),
  (11),
  (12),
  (13),
  (NULL),
  (14),
  (15);

-- Added sample values to cart items table
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) VALUES 
  (1, 1, 2, 999.99),
  (1, 2, 1, 1099.99),
  (2, 3, 3, 49.99),
  (2, 4, 1, 89.99),
  (3, 5, 1, 799.00),
  (4, 6, 2, 1299.00),
  (5, 7, 1, 59.99),
  (6, 8, 4, 29.99),
  (7, 9, 2, 249.99),
  (8, 10, 1, 149.99),
  (9, 11, 1, 799.99),
  (10, 12, 1, 599.99),
  (11, 13, 2, 999.99),
  (12, 14, 1, 249.99),
  (13, 15, 1, 79.99),
  (14, 16, 3, 39.99),
  (15, 17, 1, 14.99),
  (16, 18, 2, 9.99),
  (17, 19, 2, 12.99),
  (18, 20, 1, 1199.99),
  (19, 21, 1, 12.99),
  (20, 22, 1, 19.99);
  
 
-- Added sample values into Coupons table
INSERT INTO Coupons (code, type, value, starts_at, expires_at, min_subtotal, is_active) VALUES 
  ('SAVE10', 'PERCENT', 10.00, '2024-01-01', '2024-12-31', 50.00, TRUE),
  ('FREESHIP', 'AMOUNT', 15.00, '2024-01-01', '2024-06-30', 100.00, TRUE),
  ('WELCOME20', 'PERCENT', 20.00, '2024-01-01', '2024-12-31', NULL, TRUE),
  ('FLASH50', 'AMOUNT', 50.00, '2024-11-01', '2024-11-30', 200.00, TRUE),
  ('HOLIDAY25', 'PERCENT', 25.00, '2024-12-01', '2024-12-31', 75.00, TRUE),
  ('NEWYEAR30', 'PERCENT', 30.00, '2024-12-26', '2025-01-10', 100.00, TRUE),
  ('SUMMER15', 'PERCENT', 15.00, '2024-06-01', '2024-08-31', 60.00, TRUE),
  ('SPRING5', 'PERCENT', 5.00, '2024-03-01', '2024-05-31', 40.00, TRUE),
  ('WINTER40', 'AMOUNT', 40.00, '2024-12-01', '2025-02-28', 150.00, TRUE),
  ('AUTUMN10', 'PERCENT', 10.00, '2024-09-01', '2024-11-30', 50.00, TRUE),
  ('LOYALTY50', 'AMOUNT', 50.00, '2024-01-01', '2025-12-31', 250.00, TRUE),
  ('REFERRAL5', 'PERCENT', 5.00, '2024-02-01', '2025-02-01', NULL, TRUE),
  ('STUDENT20', 'PERCENT', 20.00, '2024-01-01', '2025-01-01', 30.00, TRUE),
  ('BLACKFRIDAY70', 'PERCENT', 70.00, '2024-11-25', '2024-11-29', 300.00, TRUE),
  ('CYBERMONDAY60', 'PERCENT', 60.00, '2024-11-30', '2024-12-02', 200.00, TRUE),
  ('VIP100', 'AMOUNT', 100.00, '2024-01-01', '2025-12-31', 500.00, TRUE),
  ('FIRSTBUY15', 'PERCENT', 15.00, '2024-01-01', '2025-12-31', NULL, TRUE),
  ('FALL30', 'PERCENT', 30.00, '2024-09-15', '2024-10-31', 100.00, TRUE),
  ('BACK2SCHOOL', 'AMOUNT', 20.00, '2024-08-01', '2024-09-15', 80.00, TRUE),
  ('BIRTHDAY25', 'PERCENT', 25.00, '2024-01-01', '2025-01-01', NULL, TRUE),
  ('THANKYOU10', 'PERCENT', 10.00, '2024-01-01', '2025-12-31', NULL, TRUE),
  ('CLEARANCE50', 'AMOUNT', 50.00, '2024-07-01', '2024-09-30', 150.00, FALSE);
  
  
-- Viewing sample values in carts table
select * from Carts;


