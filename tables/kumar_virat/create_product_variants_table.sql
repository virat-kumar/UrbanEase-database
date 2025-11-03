-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Create ProductVariants Table
-- Module: Product Variants & Inventory Management
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS ProductVariants;

CREATE TABLE ProductVariants (
  variant_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id      BIGINT       NOT NULL,
  sku             VARCHAR(64)  NOT NULL UNIQUE,
  attributes_json JSON NULL,  -- {"size":"M","color":"Black"}
  price           DECIMAL(12,2) NOT NULL CHECK (price >= 0),
  currency        CHAR(3)       NOT NULL DEFAULT 'USD',
  is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
  created_at      DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at      DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
  CONSTRAINT FK_Variant_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE ProductVariants COMMENT = 'Sellable product variants with SKU, price, and attributes';

-- Create index for product lookups
CREATE INDEX IX_Variant_Product ON ProductVariants(product_id);

-- Verify table creation
DESC ProductVariants;

-- Example: Insert sample product variants
/*
-- Assuming iPhone 15 Pro has product_id = 2
INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency, is_active) VALUES 
  (2, 'IPHONE15PRO-128GB-BLK', '{"storage":"128GB","color":"Black"}', 999.99, 'USD', TRUE),
  (2, 'IPHONE15PRO-256GB-BLK', '{"storage":"256GB","color":"Black"}', 1099.99, 'USD', TRUE),
  (2, 'IPHONE15PRO-128GB-WHT', '{"storage":"128GB","color":"White"}', 999.99, 'USD', TRUE);
*/

-- Example: Query to see variants with products
-- SELECT p.title, pv.sku, pv.attributes_json, pv.price, pv.currency
-- FROM ProductVariants pv
-- JOIN Products p ON pv.product_id = p.product_id
-- WHERE pv.is_active = TRUE;

