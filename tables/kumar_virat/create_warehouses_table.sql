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

-- =============================================
-- Sample Data: 50 Warehouse Entries
-- =============================================

INSERT INTO Warehouses (name, code, city, state_region, country_code) VALUES 
  -- Major Distribution Centers (1-10)
  ('New York Distribution Center', 'NYC-DC-01', 'New York', 'NY', 'US'),
  ('Los Angeles Fulfillment Hub', 'LAX-FH-01', 'Los Angeles', 'CA', 'US'),
  ('Chicago Regional Center', 'CHI-RC-01', 'Chicago', 'IL', 'US'),
  ('Houston Distribution Facility', 'HOU-DF-01', 'Houston', 'TX', 'US'),
  ('Phoenix Logistics Center', 'PHX-LC-01', 'Phoenix', 'AZ', 'US'),
  ('Philadelphia Regional Hub', 'PHL-RH-01', 'Philadelphia', 'PA', 'US'),
  ('San Antonio Warehouse', 'SAT-WH-01', 'San Antonio', 'TX', 'US'),
  ('San Diego Fulfillment Center', 'SAN-FC-01', 'San Diego', 'CA', 'US'),
  ('Dallas Distribution Center', 'DAL-DC-01', 'Dallas', 'TX', 'US'),
  ('San Jose Tech Hub', 'SJC-TH-01', 'San Jose', 'CA', 'US'),
  
  -- Regional Warehouses (11-25)
  ('Austin Regional Warehouse', 'AUS-RW-01', 'Austin', 'TX', 'US'),
  ('Jacksonville Fulfillment Hub', 'JAX-FH-01', 'Jacksonville', 'FL', 'US'),
  ('Fort Worth Distribution Point', 'FTW-DP-01', 'Fort Worth', 'TX', 'US'),
  ('Columbus Central Warehouse', 'CMH-CW-01', 'Columbus', 'OH', 'US'),
  ('Charlotte Distribution Hub', 'CLT-DH-01', 'Charlotte', 'NC', 'US'),
  ('San Francisco Bay Center', 'SFO-BC-01', 'San Francisco', 'CA', 'US'),
  ('Indianapolis Logistics Hub', 'IND-LH-01', 'Indianapolis', 'IN', 'US'),
  ('Seattle Distribution Center', 'SEA-DC-01', 'Seattle', 'WA', 'US'),
  ('Denver Mountain Warehouse', 'DEN-MW-01', 'Denver', 'CO', 'US'),
  ('Washington DC Metro Hub', 'DCA-MH-01', 'Washington', 'DC', 'US'),
  ('Boston Northeast Center', 'BOS-NC-01', 'Boston', 'MA', 'US'),
  ('El Paso Border Warehouse', 'ELP-BW-01', 'El Paso', 'TX', 'US'),
  ('Detroit Midwest Hub', 'DTW-MH-01', 'Detroit', 'MI', 'US'),
  ('Nashville Central Facility', 'BNA-CF-01', 'Nashville', 'TN', 'US'),
  ('Memphis Logistics Center', 'MEM-LC-01', 'Memphis', 'TN', 'US'),
  
  -- Secondary Facilities (26-40)
  ('Portland Northwest Hub', 'PDX-NH-01', 'Portland', 'OR', 'US'),
  ('Oklahoma City Regional', 'OKC-RG-01', 'Oklahoma City', 'OK', 'US'),
  ('Las Vegas Desert Center', 'LAS-DC-01', 'Las Vegas', 'NV', 'US'),
  ('Louisville Distribution Hub', 'SDF-DH-01', 'Louisville', 'KY', 'US'),
  ('Baltimore East Coast Center', 'BWI-EC-01', 'Baltimore', 'MD', 'US'),
  ('Milwaukee Great Lakes Hub', 'MKE-GL-01', 'Milwaukee', 'WI', 'US'),
  ('Albuquerque Southwest Center', 'ABQ-SW-01', 'Albuquerque', 'NM', 'US'),
  ('Tucson Desert Warehouse', 'TUS-DW-01', 'Tucson', 'AZ', 'US'),
  ('Fresno Valley Center', 'FAT-VC-01', 'Fresno', 'CA', 'US'),
  ('Sacramento Capital Hub', 'SMF-CH-01', 'Sacramento', 'CA', 'US'),
  ('Kansas City Midwest Center', 'MCI-MC-01', 'Kansas City', 'MO', 'US'),
  ('Mesa Arizona Hub', 'AZA-AH-01', 'Mesa', 'AZ', 'US'),
  ('Atlanta Southeast Hub', 'ATL-SH-01', 'Atlanta', 'GA', 'US'),
  ('Colorado Springs Mountain', 'COS-MN-01', 'Colorado Springs', 'CO', 'US'),
  ('Raleigh Triangle Center', 'RDU-TC-01', 'Raleigh', 'NC', 'US'),
  
  -- Specialized Facilities (41-50)
  ('Miami Southeast Gateway', 'MIA-SG-01', 'Miami', 'FL', 'US'),
  ('Long Beach Port Warehouse', 'LGB-PW-01', 'Long Beach', 'CA', 'US'),
  ('Virginia Beach Coastal Hub', 'ORF-CH-01', 'Virginia Beach', 'VA', 'US'),
  ('Omaha Plains Distribution', 'OMA-PD-01', 'Omaha', 'NE', 'US'),
  ('Oakland Bay Area Facility', 'OAK-BA-01', 'Oakland', 'CA', 'US'),
  ('Minneapolis North Central', 'MSP-NC-01', 'Minneapolis', 'MN', 'US'),
  ('Tulsa Regional Hub', 'TUL-RH-01', 'Tulsa', 'OK', 'US'),
  ('Arlington Texas Center', 'DFW-TC-01', 'Arlington', 'TX', 'US'),
  ('Tampa Bay Distribution', 'TPA-BD-01', 'Tampa', 'FL', 'US'),
  ('Anaheim SoCal Warehouse', 'SNA-SC-01', 'Anaheim', 'CA', 'US');

