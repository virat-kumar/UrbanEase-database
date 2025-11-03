-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Create Users Table
-- Module: User Management & Authentication
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  user_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
  email         VARCHAR(320) NOT NULL UNIQUE,
  password_hash VARBINARY(256) NOT NULL,
  full_name     VARCHAR(120) NOT NULL,
  phone         VARCHAR(32) NULL,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at    DATETIME NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Users COMMENT = 'Customer and admin accounts with login credentials';

-- Verify table creation
DESC Users;

-- Example: Insert sample data for testing
/*
INSERT INTO Users (email, password_hash, full_name, phone, is_active) 
VALUES 
  ('admin@urbanease.com', SHA2('password123', 256), 'Admin User', '+1234567890', TRUE),
  ('customer@example.com', SHA2('password123', 256), 'John Doe', '+0987654321', TRUE);
*/

-- Example: Query to verify data
-- SELECT * FROM Users;

