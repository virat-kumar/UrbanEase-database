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

INSERT INTO Addresses (user_id, label, name, line1, line2, city, state_region, postal_code, country_code, phone, is_default)
VALUES
(1, 'Home', 'Alice Johnson', '123 Maple St', NULL, 'Springfield', 'IL', '62701', 'US', '217-555-0123', TRUE),
(1, 'Office', 'Alice Johnson', '456 Oak Ave', 'Suite 200', 'Springfield', 'IL', '62702', 'US', '217-555-0456', FALSE),
(2, 'Home', 'Bob Smith', '789 Pine Rd', NULL, 'Austin', 'TX', '73301', 'US', '512-555-0678', TRUE),
(2, 'Vacation', 'Bob Smith', '321 Beach Dr', 'Apt 5', 'Galveston', 'TX', '77550', 'US', '409-555-0890', FALSE),
(3, 'Home', 'Carol Lee', '987 Cedar Blvd', NULL, 'Miami', 'FL', '33101', 'US', '305-555-1234', TRUE),
(3, 'Office', 'Carol Lee', '654 Palm St', 'Floor 3', 'Miami', 'FL', '33102', 'US', '305-555-5678', FALSE),
(4, 'Home', 'Emma Brown', '246 Elm St', NULL, 'Seattle', 'WA', '98101', 'US', '206-555-1357', TRUE),
(4, 'Office', 'Emma Brown', '135 Birch Ave', 'Suite 101', 'Seattle', 'WA', '98102', 'US', '206-555-2468', FALSE),
(5, 'Home', 'Grace Miller', '369 Willow Ln', NULL, 'Denver', 'CO', '80201', 'US', '303-555-3579', TRUE),
(5, 'Office', 'Grace Miller', '258 Aspen Rd', 'Suite 10', 'Denver', 'CO', '80202', 'US', '303-555-4680', FALSE),
(1, 'Billing', 'Alice Johnson', '147 Spruce St', NULL, 'Springfield', 'IL', '62703', 'US', '217-555-6789', FALSE),
(2, 'Office', 'Bob Smith', '753 Oak Dr', 'Building B', 'Austin', 'TX', '73302', 'US', '512-555-9012', FALSE),
(3, 'Vacation', 'Carol Lee', '852 Ocean Blvd', 'Unit 12', 'Key West', 'FL', '33040', 'US', '305-555-2345', FALSE),
(4, 'Vacation', 'Emma Brown', '159 Lakeview Rd', NULL, 'Olympia', 'WA', '98501', 'US', '360-555-3456', FALSE),
(5, 'Billing', 'Grace Miller', '357 Cherry St', NULL, 'Boulder', 'CO', '80301', 'US', '303-555-4567', FALSE),
(1, 'Shipping', 'Alice Johnson', '951 Pine St', NULL, 'Springfield', 'IL', '62704', 'US', '217-555-7890', FALSE),
(2, 'Home', 'Bob Smith', '369 Maple Ave', NULL, 'Austin', 'TX', '73303', 'US', '512-555-5670', FALSE),
(3, 'Office', 'Carol Lee', '741 Birch St', 'Suite 7', 'Miami', 'FL', '33103', 'US', '305-555-6780', FALSE),
(4, 'Shipping', 'Emma Brown', '852 Cedar Ave', NULL, 'Seattle', 'WA', '98103', 'US', '206-555-7891', FALSE),
(5, 'Vacation', 'Grace Miller', '963 Pine Ln', NULL, 'Aspen', 'CO', '81611', 'US', '970-555-8901', FALSE);
(6, 'Home', 'Kate Turner', '741 Oakwood Dr', NULL, 'Portland', 'OR', '97201', 'US', '503-555-1111', TRUE),
(6, 'Office', 'Kate Turner', '159 River Rd', 'Suite 12', 'Portland', 'OR', '97202', 'US', '503-555-2222', FALSE),
(7, 'Home', 'Leo Martinez', '852 Highland Ave', NULL, 'Atlanta', 'GA', '30301', 'US', '404-555-3333', TRUE),
(7, 'Billing', 'Leo Martinez', '963 Hilltop St', NULL, 'Atlanta', 'GA', '30302', 'US', '404-555-4444', FALSE),
(8, 'Home', 'Mia Anderson', '147 Forest Ln', NULL, 'Boston', 'MA', '02108', 'US', '617-555-5555', TRUE),
(8, 'Office', 'Mia Anderson', '258 Beacon St', 'Floor 4', 'Boston', 'MA', '02109', 'US', '617-555-6666', FALSE),
(9, 'Home', 'Nina Clark', '369 Brookside Rd', NULL, 'San Diego', 'CA', '92101', 'US', '619-555-7777', TRUE),
(9, 'Vacation', 'Nina Clark', '753 Ocean View Blvd', 'Unit 5', 'La Jolla', 'CA', '92037', 'US', '858-555-8888', FALSE),
(10, 'Home', 'Oliver Hall', '951 Sunset Blvd', NULL, 'Los Angeles', 'CA', '90001', 'US', '213-555-9999', TRUE),
(10, 'Office', 'Oliver Hall', '654 Vine St', 'Suite 300', 'Los Angeles', 'CA', '90002', 'US', '213-555-0000', FALSE);

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

