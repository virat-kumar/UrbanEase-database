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
  (NULL);

-- Viewing sample values in carts table
select * from Carts;


