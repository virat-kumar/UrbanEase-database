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

