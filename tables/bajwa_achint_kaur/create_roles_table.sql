-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Sample Data for Roles Table (30 entries)
-- Module: User Management & Authentication
-- =============================================

USE urbanease_shop;

-- Insert 30 different role types for the application
INSERT INTO Roles (role_name) VALUES
('SuperAdmin'),
('Admin'),
('Manager'),
('Customer'),
('VIPCustomer'),
('WarehouseManager'),
('InventoryClerk'),
('ShippingCoordinator'),
('CustomerSupport'),
('SalesAgent'),
('MarketingManager'),
('ContentCreator'),
('ProductManager'),
('CategoryManager'),
('PricingAnalyst'),
('OrderProcessor'),
('ReturnsSpecialist'),
('QualityAssurance'),
('DataAnalyst'),
('FinanceManager'),
('Accountant'),
('PaymentProcessor'),
('SecurityOfficer'),
('ComplianceOfficer'),
('Auditor'),
('Developer'),
('SystemAdministrator'),
('VendorManager'),
('SupplyChainManager'),
('Guest');

-- Verify inserted data
SELECT COUNT(*) AS total_roles FROM Roles;
SELECT * FROM Roles ORDER BY role_id;
