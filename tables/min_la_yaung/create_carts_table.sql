-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Create Carts Table
-- Module: Shopping Cart & Promotions
-- Note: user_id can be NULL for guest carts
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Carts;

CREATE TABLE Carts (
  cart_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    BIGINT NULL,  -- allow guest carts if NULL (tracked externally)
  created_at DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at DATETIME NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
  CONSTRAINT FK_Cart_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Carts COMMENT = 'Shopping carts for registered users and guests';

-- Create index for user lookups
CREATE INDEX IX_Cart_User ON Carts(user_id);

-- Verify table creation
DESC Carts;

-- Example: Insert sample carts
/*
-- Cart for registered user (user_id = 2)
INSERT INTO Carts (user_id) VALUES (2);

-- Guest cart (NULL user_id)
INSERT INTO Carts (user_id) VALUES (NULL);
*/

-- Example: Query to see active carts
-- SELECT 
--   c.cart_id,
--   CASE WHEN c.user_id IS NULL THEN 'Guest' ELSE u.email END as customer,
--   c.created_at,
--   c.updated_at
-- FROM Carts c
-- LEFT JOIN Users u ON c.user_id = u.user_id;

