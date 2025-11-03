-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Create Warehouses Table
-- Module: Product Variants & Inventory Management
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Warehouses;

CREATE TABLE Warehouses (
  warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(120) NOT NULL,
  code         VARCHAR(32)  NOT NULL UNIQUE,
  city         VARCHAR(80)  NULL,
  state_region VARCHAR(80)  NULL,
  country_code CHAR(2)      NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Warehouses COMMENT = 'Physical warehouse locations for inventory storage';

-- Verify table creation
DESC Warehouses;

-- Example: Insert sample warehouses
/*
INSERT INTO Warehouses (name, code, city, state_region, country_code) VALUES 
  ('New York Distribution Center', 'NYC-DC-01', 'New York', 'NY', 'US'),
  ('Los Angeles Warehouse', 'LAX-WH-01', 'Los Angeles', 'CA', 'US'),
  ('Chicago Fulfillment Center', 'CHI-FC-01', 'Chicago', 'IL', 'US'),
  ('Dallas Regional Hub', 'DAL-RH-01', 'Dallas', 'TX', 'US');
*/

-- Example: Query to see all warehouses
-- SELECT warehouse_id, name, code, CONCAT(city, ', ', state_region) as location
-- FROM Warehouses
-- ORDER BY name;

