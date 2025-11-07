-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Sample Data for Warehouses Table (30 entries)
-- Module: Inventory Management
-- =============================================

USE urbanease_shop;

-- Insert 30 warehouse locations across different regions
INSERT INTO Warehouses (name, code, city, state_region, country_code) VALUES
('New York Distribution Center', 'NYC-DC-001', 'New York', 'New York', 'US'),
('Los Angeles Fulfillment Hub', 'LAX-FH-002', 'Los Angeles', 'California', 'US'),
('Chicago Central Warehouse', 'CHI-CW-003', 'Chicago', 'Illinois', 'US'),
('Houston South Distribution', 'HOU-SD-004', 'Houston', 'Texas', 'US'),
('Phoenix West Warehouse', 'PHX-WW-005', 'Phoenix', 'Arizona', 'US'),
('Philadelphia East Hub', 'PHL-EH-006', 'Philadelphia', 'Pennsylvania', 'US'),
('San Antonio Regional Center', 'SAT-RC-007', 'San Antonio', 'Texas', 'US'),
('San Diego Coastal Warehouse', 'SAN-CW-008', 'San Diego', 'California', 'US'),
('Dallas North Distribution', 'DAL-ND-009', 'Dallas', 'Texas', 'US'),
('San Jose Tech Hub', 'SJC-TH-010', 'San Jose', 'California', 'US'),
('Austin Central Depot', 'AUS-CD-011', 'Austin', 'Texas', 'US'),
('Jacksonville Southeast Center', 'JAX-SC-012', 'Jacksonville', 'Florida', 'US'),
('Fort Worth Logistics Hub', 'FTW-LH-013', 'Fort Worth', 'Texas', 'US'),
('Columbus Midwest Warehouse', 'CMH-MW-014', 'Columbus', 'Ohio', 'US'),
('Charlotte East Coast Hub', 'CLT-ECH-015', 'Charlotte', 'North Carolina', 'US'),
('Seattle Northwest Center', 'SEA-NWC-016', 'Seattle', 'Washington', 'US'),
('Denver Mountain Hub', 'DEN-MH-017', 'Denver', 'Colorado', 'US'),
('Boston Northeast Depot', 'BOS-NED-018', 'Boston', 'Massachusetts', 'US'),
('Detroit Great Lakes Center', 'DTW-GLC-019', 'Detroit', 'Michigan', 'US'),
('Portland Pacific Warehouse', 'PDX-PW-020', 'Portland', 'Oregon', 'US'),
('Las Vegas Desert Hub', 'LAS-DH-021', 'Las Vegas', 'Nevada', 'US'),
('Miami Southeast Distribution', 'MIA-SED-022', 'Miami', 'Florida', 'US'),
('Atlanta Southern Hub', 'ATL-SH-023', 'Atlanta', 'Georgia', 'US'),
('Minneapolis North Central', 'MSP-NC-024', 'Minneapolis', 'Minnesota', 'US'),
('Orlando Florida Center', 'MCO-FC-025', 'Orlando', 'Florida', 'US'),
('San Francisco Bay Warehouse', 'SFO-BW-026', 'San Francisco', 'California', 'US'),
('Tampa Gulf Coast Hub', 'TPA-GCH-027', 'Tampa', 'Florida', 'US'),
('Sacramento Valley Center', 'SMF-VC-028', 'Sacramento', 'California', 'US'),
('Kansas City Heartland Hub', 'MCI-HH-029', 'Kansas City', 'Missouri', 'US'),
('Raleigh East Distribution', 'RDU-ED-030', 'Raleigh', 'North Carolina', 'US');

-- Verify inserted data
SELECT COUNT(*) AS total_warehouses FROM Warehouses;
SELECT * FROM Warehouses LIMIT 10;
