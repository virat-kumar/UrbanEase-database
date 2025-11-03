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

