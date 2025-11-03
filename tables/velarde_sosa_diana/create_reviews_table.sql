-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Create Reviews Table
-- Module: User Addresses, Payments & Reviews
-- Note: Requires Products and Users tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Reviews;

CREATE TABLE Reviews (
  review_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  user_id    BIGINT NOT NULL,
  rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  title      VARCHAR(160) NULL,
  body       TEXT NULL,
  created_at DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  CONSTRAINT FK_Review_Product FOREIGN KEY (product_id) REFERENCES Products(product_id),
  CONSTRAINT FK_Review_User    FOREIGN KEY (user_id)    REFERENCES Users(user_id),
  CONSTRAINT UQ_Review_User_Product UNIQUE (product_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Reviews COMMENT = 'Product reviews and ratings by users';

-- Create indexes for lookups
CREATE INDEX IX_Reviews_Product ON Reviews(product_id);
CREATE INDEX IX_Reviews_User ON Reviews(user_id);

-- Verify table creation
DESC Reviews;

-- Example: Insert sample reviews
/*
INSERT INTO Reviews (product_id, user_id, rating, title, body) VALUES 
  (1, 2, 5, 'Excellent laptop!', 'Best laptop I have ever owned. Fast, reliable, and beautiful design.'),
  (2, 2, 4, 'Great phone', 'Amazing camera and battery life. Would have given 5 stars if it was cheaper.'),
  (3, 3, 5, 'Perfect mouse', 'Very comfortable for long hours of work. Highly recommended!');
*/

-- Example: Query to see product reviews with ratings
-- SELECT 
--   p.title as product,
--   u.full_name as reviewer,
--   r.rating,
--   r.title as review_title,
--   r.body as review_text,
--   r.created_at
-- FROM Reviews r
-- JOIN Products p ON r.product_id = p.product_id
-- JOIN Users u ON r.user_id = u.user_id
-- ORDER BY r.created_at DESC;

