-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Create Addresses Table
-- Module: User Addresses, Payments & Reviews
-- Note: Requires Users table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Addresses;

CREATE TABLE Addresses (
  address_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id      BIGINT NOT NULL,
  label        VARCHAR(40) NULL,     -- Home/Office
  name         VARCHAR(120) NOT NULL,
  line1        VARCHAR(160) NOT NULL,
  line2        VARCHAR(160) NULL,
  city         VARCHAR(80)  NOT NULL,
  state_region VARCHAR(80)  NOT NULL,
  postal_code  VARCHAR(20)  NOT NULL,
  country_code CHAR(2)      NOT NULL,
  phone        VARCHAR(32)  NULL,
  is_default   BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at   DATETIME     NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at   DATETIME     NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
  CONSTRAINT FK_Address_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Addresses COMMENT = 'User shipping and billing addresses';

-- Create index for user lookups
CREATE INDEX IX_Address_User ON Addresses(user_id);

-- Verify table creation
DESC Addresses;

-- Example: Insert sample addresses
/*
INSERT INTO Addresses (user_id, label, name, line1, line2, city, state_region, postal_code, country_code, phone, is_default) VALUES 
  (2, 'Home', 'John Doe', '123 Main Street', 'Apt 4B', 'New York', 'NY', '10001', 'US', '+1-555-1234', TRUE),
  (2, 'Office', 'John Doe', '456 Business Ave', 'Suite 200', 'New York', 'NY', '10002', 'US', '+1-555-5678', FALSE);
*/

-- Example: Query to see user addresses
-- SELECT 
--   u.email,
--   a.label,
--   CONCAT(a.line1, ', ', a.city, ', ', a.state_region, ' ', a.postal_code) as full_address,
--   a.is_default
-- FROM Addresses a
-- JOIN Users u ON a.user_id = u.user_id;

