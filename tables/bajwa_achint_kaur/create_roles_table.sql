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

-- COMMENTS
-- 1) Inserts 30 well-defined roles for the Urbanease Shop system.
-- 2) Role names are concise, in PascalCase, and self-descriptive.
-- 3) Primary categories:
--      a) Administrative: SuperAdmin, Admin, Manager.
--      b) Customer-facing: Customer, VIPCustomer, SalesAgent, CustomerSupport.
--      c) Operations: WarehouseManager, InventoryClerk, ShippingCoordinator, OrderProcessor, ReturnsSpecialist.
--      d) Marketing/Creative: MarketingManager, ContentCreator, ProductManager, CategoryManager, PricingAnalyst.
--      e) Technical: Developer, SystemAdministrator, QualityAssurance, SecurityOfficer.
--      f) Finance/Compliance: FinanceManager, Accountant, PaymentProcessor, ComplianceOfficer, Auditor.
--      g) Data/Vendor: DataAnalyst, VendorManager, SupplyChainManager.
--      h) Misc: Guest (anonymous or temporary user).
-- 4) Ensure this table has an AUTO_INCREMENT `role_id` (PK) column for proper sequencing.
-- 5) Add a unique index to prevent duplicates:
--        ALTER TABLE roles ADD CONSTRAINT uq_role_name UNIQUE(role_name);
-- 6) Run this script before `user_roles` to avoid foreign-key violations.
-- 7) Keep capitalization consistent across all queries (use lower-case table names).
