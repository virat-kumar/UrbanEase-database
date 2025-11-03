-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Create ProductImages Table
-- Module: Product Catalog
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS ProductImages;

CREATE TABLE ProductImages (
  image_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  url        VARCHAR(512) NOT NULL,
  alt_text   VARCHAR(160) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Image_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE ProductImages COMMENT = 'Multiple images per product with sort order';

-- Create index for product lookups
CREATE INDEX IX_Image_Product ON ProductImages(product_id);

-- Verify table creation
DESC ProductImages;

-- Example: Insert sample product images
/*
-- Assuming MacBook Pro has product_id = 1
INSERT INTO ProductImages (product_id, url, alt_text, sort_order) VALUES 
  (1, 'https://images.urbanease.com/macbook-pro-front.jpg', 'MacBook Pro front view', 1),
  (1, 'https://images.urbanease.com/macbook-pro-side.jpg', 'MacBook Pro side view', 2),
  (1, 'https://images.urbanease.com/macbook-pro-open.jpg', 'MacBook Pro open view', 3);
*/

-- Example: Query to see products with image count
-- SELECT p.title, COUNT(pi.image_id) as image_count
-- FROM Products p
-- LEFT JOIN ProductImages pi ON p.product_id = pi.product_id
-- GROUP BY p.product_id, p.title;

