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

INSERT INTO Reviews (product_id, user_id, rating, title, body)
VALUES
(1, 1, 5, 'Excellent Product', 'Really loved this! Exceeded my expectations.'),
(2, 2, 4, 'Good Quality', 'The product works well, happy with my purchase.'),
(3, 3, 3, 'Average', 'It is okay, does the job but nothing special.'),
(4, 4, 2, 'Not great', 'Had some issues, expected better quality.'),
(5, 5, 1, 'Very Disappointed', 'Did not meet my expectations at all.'),
(1, 2, 4, 'Pretty Good', 'Overall satisfied, minor improvements needed.'),
(2, 3, 5, 'Loved it', 'Fantastic! Would recommend to friends.'),
(3, 4, 3, 'Decent', 'It works, but there are better options.'),
(4, 5, 2, 'Could be better', 'Some parts feel cheap, quality is low.'),
(5, 1, 5, 'Perfect', 'Exactly what I wanted, very happy!'),
(6, 2, 4, 'Good Value', 'Worth the price, solid product.'),
(7, 3, 3, 'Average Experience', 'Nothing special, but functional.'),
(8, 4, 2, 'Disappointed', 'Not as described, quality below expectation.'),
(9, 5, 1, 'Terrible', 'Broke within days, very unhappy.'),
(10, 1, 5, 'Highly Recommend', 'Excellent product, great quality.'),
(6, 3, 4, 'Works well', 'Satisfied with the purchase overall.'),
(7, 4, 3, 'Okay', 'Meets basic needs, nothing more.'),
(8, 2, 2, 'Poor Quality', 'Would not buy again.'),
(9, 1, 1, 'Do not buy', 'Extremely disappointing, avoid this product.'),
(10, 5, 5, 'Fantastic', 'Exceeded all expectations, love it!');
(1, 3, 4, 'Solid Choice', 'Product performs well and meets expectations.'),
(2, 4, 3, 'Just Okay', 'It’s fine, but could be improved in design.'),
(3, 5, 5, 'Amazing!', 'Works perfectly. I will buy again.'),
(4, 1, 4, 'Very Good', 'Met most of my needs, reliable quality.'),
(5, 2, 2, 'Not Worth It', 'Stopped working after a week. Disappointed.'),
(6, 4, 5, 'Excellent Value', 'High quality for the price, very pleased.'),
(7, 5, 3, 'Average', 'It does what it says, nothing exceptional.'),
(8, 1, 4, 'Good Overall', 'Nice build and functionality. Recommended.'),
(9, 2, 1, 'Terrible Experience', 'Arrived damaged, poor support.'),
(10, 3, 5, 'Fantastic Product', 'Best purchase this year! Worth every penny.');

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

