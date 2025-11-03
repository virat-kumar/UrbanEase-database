-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Create Roles Table
-- Module: User Management & Authentication
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Roles;

CREATE TABLE Roles (
  role_id   INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(64) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Roles COMMENT = 'Application roles (Admin, Customer, Manager, etc.)';

-- Verify table creation
DESC Roles;

-- Example: Insert default roles
/*
INSERT INTO Roles (role_name) 
VALUES 
  ('Admin'),
  ('Customer'),
  ('Manager'),
  ('Operations'),
  ('Support');
*/

-- Example: Query to verify data
-- SELECT * FROM Roles;

