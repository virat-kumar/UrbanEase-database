-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Create CartItems Table
-- Module: Shopping Cart & Promotions
-- Note: Requires Carts and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS CartItems;

CREATE TABLE CartItems (
  cart_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  cart_id      BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  qty          INT NOT NULL CHECK (qty > 0),
  unit_price   DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  added_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_CI_Cart    FOREIGN KEY (cart_id)    REFERENCES Carts(cart_id),
  CONSTRAINT FK_CI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Add comments to document table purpose
ALTER TABLE CartItems COMMENT = 'Items in shopping carts with quantity and price';

-- Create indexes for lookups
CREATE INDEX IX_CartItems_Cart ON CartItems(cart_id);
CREATE INDEX IX_CartItems_Variant ON CartItems(variant_id);

-- Verify table creation
DESC CartItems;

/* Sample Values Created by La Yaung Min */
-- Note: These samples are required to run La Yaung Min's queries, trigger, function, and procedure.
-- Added values into users table 
INSERT INTO Users (email, password_hash, full_name, phone) VALUES
  ('alice@gmail.com', UNHEX(SHA2('password1', 256)), 'Alice Johnson', '+1-555-1010'),
  ('bob@gmail.com',   UNHEX(SHA2('password2', 256)), 'Bob Smith', '+1-555-2020'),
  ('carol@gmail.com', UNHEX(SHA2('password3', 256)), 'Carol Lee', '+1-555-3030'),
  ('dave@gmail.com',  UNHEX(SHA2('password4', 256)), 'Dave Kim', '+1-555-4040'),
  ('emma@gmail.com',  UNHEX(SHA2('password5', 256)), 'Emma Brown', '+1-555-5050');


-- Added values into categories table 
INSERT INTO Categories (parent_id, name, slug) VALUES
  (NULL, 'Electronics', 'electronics'),
  (1, 'Smartphones', 'smartphones'),
  (1, 'Laptops', 'laptops'),
  (1, 'Accessories', 'accessories'),
  (NULL, 'Home Appliances', 'home-appliances');


-- Added values into products table
INSERT INTO Products (category_id, title, description, brand) VALUES
  (2, 'iPhone 15', 'Apple’s latest smartphone with A17 Pro chip', 'Apple'),
  (2, 'Galaxy S24', 'Samsung flagship smartphone with AI features', 'Samsung'),
  (3, 'MacBook Air 13"', 'Lightweight laptop with M3 chip', 'Apple'),
  (3, 'Dell XPS 13', 'Compact ultrabook with Intel i7', 'Dell'),
  (4, 'AirPods Pro 2', 'Wireless noise-cancelling earbuds', 'Apple'),
  (4, 'Logitech MX Master 3S', 'Wireless mouse with ergonomic design', 'Logitech'),
  (5, 'Dyson V15 Detect', 'Cordless vacuum cleaner', 'Dyson'),
  (5, 'Instant Pot Duo 7-in-1', 'Multi-functional electric pressure cooker', 'Instant Brands');


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
  (8, 'SKU-IPD7', '{"size":"6QT"}', 129.99, 'USD');


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
  (8, 10, 1, 149.99);
  
-- Viewing sample values in cart items table
select * from CartItems;
