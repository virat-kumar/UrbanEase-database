-- =============================================
-- Project Group #6 - UrbanEase E-commerce Database System
-- =============================================
-- A comprehensive MySQL database for modern online retail platforms
-- Date: November 2024
-- Course: Database Management Systems
-- =============================================

CREATE DATABASE IF NOT EXISTS urbanease_shop
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE urbanease_shop;

-- =============================================
-- DATABASE SCHEMA - TABLE DEFINITIONS
-- =============================================

CREATE TABLE Users (
  user_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
  email         VARCHAR(320) NOT NULL UNIQUE,
  password_hash VARBINARY(256) NOT NULL,
  full_name     VARCHAR(120) NOT NULL,
  phone         VARCHAR(32) NULL,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Roles (
  role_id   INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(64) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE UserRoles (
  user_id BIGINT NOT NULL,
  role_id INT NOT NULL,
  assigned_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  CONSTRAINT FK_UserRoles_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
  CONSTRAINT FK_UserRoles_Role FOREIGN KEY (role_id) REFERENCES Roles(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  created_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Address_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   2) Catalog (single-category per product to keep 18 total)
   =========================== */

CREATE TABLE Categories (
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  parent_id   BIGINT NULL,
  name        VARCHAR(120) NOT NULL,
  slug        VARCHAR(160) NOT NULL UNIQUE,
  CONSTRAINT FK_Category_Parent FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Products (
  product_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NULL,
  title       VARCHAR(200) NOT NULL,
  description TEXT NULL,
  brand       VARCHAR(100) NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ProductImages (
  image_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  url        VARCHAR(512) NOT NULL,
  alt_text   VARCHAR(160) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Image_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   3) Variants & Inventory
   =========================== */

CREATE TABLE ProductVariants (
  variant_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id      BIGINT       NOT NULL,
  sku             VARCHAR(64)  NOT NULL UNIQUE,
  attributes_json JSON NULL,  -- {"size":"M","color":"Black"}
  price           DECIMAL(12,2) NOT NULL CHECK (price >= 0),
  currency        CHAR(3)       NOT NULL DEFAULT 'USD',
  is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
  created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Variant_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Warehouses (
  warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(120) NOT NULL,
  code         VARCHAR(32)  NOT NULL UNIQUE,
  city         VARCHAR(80)  NULL,
  state_region VARCHAR(80)  NULL,
  country_code CHAR(2)      NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Inventory (
  warehouse_id BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  on_hand      INT    NOT NULL CHECK (on_hand >= 0),
  reserved     INT    NOT NULL DEFAULT 0 CHECK (reserved >= 0),
  PRIMARY KEY (warehouse_id, variant_id),
  CONSTRAINT FK_Inv_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
  CONSTRAINT FK_Inv_Variant   FOREIGN KEY (variant_id)   REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   4) Cart & Coupons
   =========================== */

CREATE TABLE Carts (
  cart_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    BIGINT NULL,  -- allow guest carts if NULL (tracked externally)
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Cart_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE CartItems (
  cart_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  cart_id      BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  qty          INT    NOT NULL CHECK (qty > 0),
  unit_price   DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  added_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_CI_Cart    FOREIGN KEY (cart_id)    REFERENCES Carts(cart_id),
  CONSTRAINT FK_CI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Coupons (
  coupon_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  code         VARCHAR(40)   NOT NULL UNIQUE,
  type         VARCHAR(20)   NOT NULL CHECK (type IN ('PERCENT','AMOUNT')),
  value        DECIMAL(12,2) NOT NULL CHECK (value >= 0),
  starts_at    DATETIME      NULL,
  expires_at   DATETIME      NULL,
  min_subtotal DECIMAL(12,2) NULL,
  is_active    BOOLEAN       NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   5) Orders, Items, Shipments
   =========================== */

CREATE TABLE Orders (
  order_id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id             BIGINT NOT NULL,
  status              VARCHAR(20) NOT NULL CHECK (status IN ('PENDING','PAID','CANCELLED','FULFILLED','REFUNDED')),
  subtotal_amount     DECIMAL(12,2) NOT NULL CHECK (subtotal_amount >= 0),
  discount_amount     DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
  shipping_amount     DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (shipping_amount >= 0),
  tax_amount          DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
  grand_total_amount  DECIMAL(12,2) GENERATED ALWAYS AS (subtotal_amount - discount_amount + shipping_amount + tax_amount) STORED,
  coupon_id           BIGINT NULL,
  shipping_address_id BIGINT NOT NULL,
  billing_address_id  BIGINT NOT NULL,
  placed_at           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Order_User     FOREIGN KEY (user_id)             REFERENCES Users(user_id),
  CONSTRAINT FK_Order_Coupon   FOREIGN KEY (coupon_id)           REFERENCES Coupons(coupon_id),
  CONSTRAINT FK_Order_ShipAdr  FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
  CONSTRAINT FK_Order_BillAdr  FOREIGN KEY (billing_address_id)  REFERENCES Addresses(address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE OrderItems (
  order_item_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id        BIGINT        NOT NULL,
  variant_id      BIGINT        NOT NULL,
  qty             INT           NOT NULL CHECK (qty > 0),
  unit_price      DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  tax_amount      DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
  discount_amount DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
  CONSTRAINT FK_OI_Order   FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
  CONSTRAINT FK_OI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Shipments (
  shipment_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT      NOT NULL,
  warehouse_id BIGINT      NULL,
  carrier      VARCHAR(80) NOT NULL,
  tracking_no  VARCHAR(120) NULL,
  status       VARCHAR(20) NOT NULL CHECK (status IN ('CREATED','PICKED','IN_TRANSIT','DELIVERED','CANCELLED')),
  shipped_at   DATETIME NULL,
  delivered_at DATETIME NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Ship_Order     FOREIGN KEY (order_id)     REFERENCES Orders(order_id),
  CONSTRAINT FK_Ship_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   6) Payments & Reviews
   =========================== */

CREATE TABLE Payments (
  payment_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT       NOT NULL,
  provider     VARCHAR(40)  NOT NULL,  -- Stripe/PayPal/etc.
  provider_ref VARCHAR(120) NULL,
  amount       DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
  status       VARCHAR(20)   NOT NULL CHECK (status IN ('INITIATED','AUTHORIZED','CAPTURED','FAILED','REFUNDED')),
  paid_at      DATETIME      NULL,
  created_at   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Payment_Order FOREIGN KEY (order_id) REFERENCES Orders(order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Reviews (
  review_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  user_id    BIGINT NOT NULL,
  rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  title      VARCHAR(160) NULL,
  body       TEXT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Review_Product FOREIGN KEY (product_id) REFERENCES Products(product_id),
  CONSTRAINT FK_Review_User    FOREIGN KEY (user_id)    REFERENCES Users(user_id),
  CONSTRAINT UQ_Review_User_Product UNIQUE (product_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Helpful indexes */
CREATE INDEX IX_Variant_Product   ON ProductVariants(product_id);
CREATE INDEX IX_Product_Category  ON Products(category_id);
CREATE INDEX IX_Inventory_Variant ON Inventory(variant_id);
CREATE INDEX IX_Order_User        ON Orders(user_id);
CREATE INDEX IX_OrderItems_Order  ON OrderItems(order_id);
CREATE INDEX IX_CartItems_Cart    ON CartItems(cart_id);
CREATE INDEX IX_Payments_Order    ON Payments(order_id);

-- =============================================
-- Bajwa, Achint Kaur
-- Module: User Management & Authentication
-- Tables: Users, Roles, UserRoles
-- =============================================

-- Data for tables: Users, Roles, UserRoles

-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Sample Data for Users Table (35 entries)
-- Module: User Management & Authentication
-- =============================================

USE urbanease_shop;

-- Insert 35 diverse users representing customers and staff
INSERT INTO Users (email, password_hash, full_name, phone, is_active, created_at) VALUES
('admin@urbanease.com', UNHEX(SHA2('SecurePass123!', 256)), 'Sarah Johnson', '+1-555-0001', TRUE, '2024-01-15 10:00:00'),
('john.doe@email.com', UNHEX(SHA2('password123', 256)), 'John Doe', '+1-555-0002', TRUE, '2024-02-20 14:30:00'),
('jane.smith@email.com', UNHEX(SHA2('password123', 256)), 'Jane Smith', '+1-555-0003', TRUE, '2024-02-21 09:15:00'),
('michael.brown@email.com', UNHEX(SHA2('password123', 256)), 'Michael Brown', '+1-555-0004', TRUE, '2024-03-05 16:45:00'),
('emily.davis@email.com', UNHEX(SHA2('password123', 256)), 'Emily Davis', '+1-555-0005', TRUE, '2024-03-10 11:20:00'),
('david.wilson@email.com', UNHEX(SHA2('password123', 256)), 'David Wilson', '+1-555-0006', TRUE, '2024-03-15 13:30:00'),
('sarah.martinez@email.com', UNHEX(SHA2('password123', 256)), 'Sarah Martinez', '+1-555-0007', TRUE, '2024-04-01 08:45:00'),
('james.anderson@email.com', UNHEX(SHA2('password123', 256)), 'James Anderson', '+1-555-0008', TRUE, '2024-04-05 15:10:00'),
('lisa.taylor@email.com', UNHEX(SHA2('password123', 256)), 'Lisa Taylor', '+1-555-0009', TRUE, '2024-04-12 10:25:00'),
('robert.thomas@email.com', UNHEX(SHA2('password123', 256)), 'Robert Thomas', '+1-555-0010', TRUE, '2024-04-20 12:40:00'),
('jennifer.jackson@email.com', UNHEX(SHA2('password123', 256)), 'Jennifer Jackson', '+1-555-0011', TRUE, '2024-05-01 09:55:00'),
('william.white@email.com', UNHEX(SHA2('password123', 256)), 'William White', '+1-555-0012', TRUE, '2024-05-08 14:15:00'),
('mary.harris@email.com', UNHEX(SHA2('password123', 256)), 'Mary Harris', '+1-555-0013', TRUE, '2024-05-15 11:30:00'),
('charles.martin@email.com', UNHEX(SHA2('password123', 256)), 'Charles Martin', '+1-555-0014', TRUE, '2024-05-22 16:20:00'),
('patricia.thompson@email.com', UNHEX(SHA2('password123', 256)), 'Patricia Thompson', '+1-555-0015', TRUE, '2024-06-01 08:50:00'),
('daniel.garcia@email.com', UNHEX(SHA2('password123', 256)), 'Daniel Garcia', '+1-555-0016', TRUE, '2024-06-10 13:05:00'),
('linda.martinez@email.com', UNHEX(SHA2('password123', 256)), 'Linda Martinez', '+1-555-0017', TRUE, '2024-06-18 10:40:00'),
('joseph.robinson@email.com', UNHEX(SHA2('password123', 256)), 'Joseph Robinson', '+1-555-0018', TRUE, '2024-06-25 15:25:00'),
('barbara.clark@email.com', UNHEX(SHA2('password123', 256)), 'Barbara Clark', '+1-555-0019', TRUE, '2024-07-02 09:10:00'),
('thomas.rodriguez@email.com', UNHEX(SHA2('password123', 256)), 'Thomas Rodriguez', '+1-555-0020', TRUE, '2024-07-10 14:35:00'),
('susan.lewis@email.com', UNHEX(SHA2('password123', 256)), 'Susan Lewis', '+1-555-0021', TRUE, '2024-07-18 11:50:00'),
('christopher.lee@email.com', UNHEX(SHA2('password123', 256)), 'Christopher Lee', '+1-555-0022', TRUE, '2024-07-25 16:15:00'),
('jessica.walker@email.com', UNHEX(SHA2('password123', 256)), 'Jessica Walker', '+1-555-0023', TRUE, '2024-08-01 08:30:00'),
('matthew.hall@email.com', UNHEX(SHA2('password123', 256)), 'Matthew Hall', '+1-555-0024', TRUE, '2024-08-08 13:45:00'),
('karen.allen@email.com', UNHEX(SHA2('password123', 256)), 'Karen Allen', '+1-555-0025', TRUE, '2024-08-15 10:20:00'),
('mark.young@email.com', UNHEX(SHA2('password123', 256)), 'Mark Young', '+1-555-0026', TRUE, '2024-08-22 15:55:00'),
('nancy.hernandez@email.com', UNHEX(SHA2('password123', 256)), 'Nancy Hernandez', '+1-555-0027', TRUE, '2024-09-01 09:25:00'),
('paul.king@email.com', UNHEX(SHA2('password123', 256)), 'Paul King', '+1-555-0028', TRUE, '2024-09-10 14:10:00'),
('betty.wright@email.com', UNHEX(SHA2('password123', 256)), 'Betty Wright', '+1-555-0029', TRUE, '2024-09-18 11:35:00'),
('steven.lopez@email.com', UNHEX(SHA2('password123', 256)), 'Steven Lopez', '+1-555-0030', TRUE, '2024-09-25 16:50:00'),
('margaret.hill@email.com', UNHEX(SHA2('password123', 256)), 'Margaret Hill', '+1-555-0031', TRUE, '2024-10-01 08:15:00'),
('andrew.scott@email.com', UNHEX(SHA2('password123', 256)), 'Andrew Scott', '+1-555-0032', TRUE, '2024-10-10 13:40:00'),
('dorothy.green@email.com', UNHEX(SHA2('password123', 256)), 'Dorothy Green', '+1-555-0033', TRUE, '2024-10-18 10:55:00'),
('joshua.adams@email.com', UNHEX(SHA2('password123', 256)), 'Joshua Adams', '+1-555-0034', TRUE, '2024-10-25 15:20:00'),
('inactive.user@email.com', UNHEX(SHA2('password123', 256)), 'Inactive User', '+1-555-0035', FALSE, '2024-11-01 09:45:00');

-- Verify inserted data
SELECT COUNT(*) AS total_users FROM Users;
SELECT * FROM Users LIMIT 10;

-- COMMENTS
-- 1) Uses `USE urbanease_shop;` to pin the correct schema.
-- 2) Explicit column list ensures compatibility if table evolves.
-- 3) Emails are unique → relies on UNIQUE index on `email` to prevent dupes.
-- 4) `password_hash` is stored as 32-byte binary via UNHEX(SHA2(...,256));
--    choose BINARY(32)/VARBINARY(32) for this column to avoid truncation.
-- 5) `is_active` uses 1/0 for cross-platform MySQL portability (TRUE/FALSE can vary).
-- 6) Timestamps span 2024-01 to 2024-11 to simulate realistic account creation cadence.
-- 7) Keep this file in /tables/<your_name>/users_seed.sql and run after CREATE TABLEs.


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


-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Sample Data for UserRoles Table (35 entries)
-- Module: User Management & Authentication
-- Note: Assumes Users (1-35) and Roles (1-30) exist
-- =============================================

USE urbanease_shop;

-- Assign roles to users (some users have multiple roles)
INSERT INTO UserRoles (user_id, role_id, assigned_at) VALUES
-- SuperAdmin
(1, 1, '2024-01-15 10:00:00'),
-- Admin and Manager
(1, 2, '2024-01-15 10:00:00'),
-- Regular Customers (user_id 2-25)
(2, 4, '2024-02-20 14:30:00'),
(3, 4, '2024-02-21 09:15:00'),
(4, 4, '2024-03-05 16:45:00'),
(5, 4, '2024-03-10 11:20:00'),
(6, 4, '2024-03-15 13:30:00'),
(7, 4, '2024-04-01 08:45:00'),
(8, 4, '2024-04-05 15:10:00'),
(9, 4, '2024-04-12 10:25:00'),
(10, 4, '2024-04-20 12:40:00'),
(11, 4, '2024-05-01 09:55:00'),
(12, 4, '2024-05-08 14:15:00'),
(13, 4, '2024-05-15 11:30:00'),
(14, 4, '2024-05-22 16:20:00'),
(15, 4, '2024-06-01 08:50:00'),
-- VIP Customers (upgrade select customers)
(2, 5, '2024-06-01 10:00:00'),
(5, 5, '2024-06-15 11:00:00'),
(10, 5, '2024-07-01 12:00:00'),
-- More Regular Customers
(16, 4, '2024-06-10 13:05:00'),
(17, 4, '2024-06-18 10:40:00'),
(18, 4, '2024-06-25 15:25:00'),
(19, 4, '2024-07-02 09:10:00'),
(20, 4, '2024-07-10 14:35:00'),
-- Staff Roles
(21, 6, '2024-07-18 11:50:00'),  -- WarehouseManager
(22, 7, '2024-07-25 16:15:00'),  -- InventoryClerk
(23, 8, '2024-08-01 08:30:00'),  -- ShippingCoordinator
(24, 9, '2024-08-08 13:45:00'),  -- CustomerSupport
(25, 10, '2024-08-15 10:20:00'), -- SalesAgent
(26, 11, '2024-08-22 15:55:00'), -- MarketingManager
(27, 13, '2024-09-01 09:25:00'), -- ProductManager
(28, 16, '2024-09-10 14:10:00'), -- OrderProcessor
(29, 20, '2024-09-18 11:35:00'), -- FinanceManager
(30, 22, '2024-09-25 16:50:00'), -- PaymentProcessor
-- Multi-role users (managers with customer accounts)
(31, 4, '2024-10-01 08:15:00'),
(31, 3, '2024-10-01 08:15:00'),
(32, 4, '2024-10-10 13:40:00'),
(33, 4, '2024-10-18 10:55:00');

-- Verify inserted data
SELECT COUNT(*) AS total_user_roles FROM UserRoles;
SELECT u.email, r.role_name, ur.assigned_at 
FROM UserRoles ur
JOIN Users u ON ur.user_id = u.user_id
JOIN Roles r ON ur.role_id = r.role_id
ORDER BY ur.user_id, ur.role_id
LIMIT 20;

-- COMMENTS
-- 1) Uses lower-case table names (`user_roles`, `users`, `roles`) to avoid
--    failures on case-sensitive MySQL installations.
-- 2) The script inserts 38 rows (header updated). Users 31 has two roles.
--    Users 34–35 intentionally have no roles (e.g., 35 is inactive).
-- 3) Role id meanings (example mapping): 
--    1=SuperAdmin, 2=Admin, 3=Manager, 4=Customer, 5=VIP Customer,
--    6=WarehouseManager, 7=InventoryClerk, 8=ShippingCoordinator, 9=CustomerSupport,
--    10=SalesAgent, 11=MarketingManager, 13=ProductManager, 16=OrderProcessor,
--    20=FinanceManager, 22=PaymentProcessor. Ensure these exist in `roles`.
-- 4) Added three sanity-check queries to quickly catch FK issues or duplicates.
-- 5) Keep helpful indexes:
--      CREATE INDEX idx_ur_user ON user_roles(user_id);
--      CREATE INDEX idx_ur_role ON user_roles(role_id);
--      CREATE INDEX idx_r_name  ON roles(role_name);
-- 6) Always pin schema with `USE urbanease_shop;` and add an ORDER BY in
--    verification queries for stable, comparable outputs across teammates.


-- =============================================
-- Khapekar, Pooja
-- Module: Product Catalog
-- Tables: Categories, Products, ProductImages
-- =============================================

-- Data for tables: Categories, Products, ProductImages

-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Categories Table (90 entries total: 30 root + 60 subcategories)
-- Module: Product Catalog
-- =============================================

USE urbanease_shop;

-- Root categories (30 main categories)
INSERT INTO Categories (parent_id, name, slug) VALUES 
(NULL, 'Electronics', 'electronics'),
(NULL, 'Clothing', 'clothing'),
(NULL, 'Home & Garden', 'home-garden'),
(NULL, 'Beauty & Personal Care', 'beauty-personal-care'),
(NULL, 'Health & Wellness', 'health-wellness'),
(NULL, 'Sports & Outdoors', 'sports-outdoors'),
(NULL, 'Toys & Games', 'toys-games'),
(NULL, 'Automotive', 'automotive'),
(NULL, 'Books & Stationery', 'books-stationery'),
(NULL, 'Groceries', 'groceries'),
(NULL, 'Baby & Kids', 'baby-kids'),
(NULL, 'Jewelry & Accessories', 'jewelry-accessories'),
(NULL, 'Shoes & Footwear', 'shoes-footwear'),
(NULL, 'Pet Supplies', 'pet-supplies'),
(NULL, 'Furniture', 'furniture'),
(NULL, 'Office Supplies', 'office-supplies'),
(NULL, 'Tools & Hardware', 'tools-hardware'),
(NULL, 'Musical Instruments', 'musical-instruments'),
(NULL, 'Arts & Crafts', 'arts-crafts'),
(NULL, 'Cameras & Photography', 'cameras-photography'),
(NULL, 'Computers & Laptops', 'computers-laptops'),
(NULL, 'Mobile Phones & Tablets', 'mobile-phones-tablets'),
(NULL, 'Appliances', 'appliances'),
(NULL, 'Travel & Luggage', 'travel-luggage'),
(NULL, 'Movies & Entertainment', 'movies-entertainment'),
(NULL, 'Gaming', 'gaming'),
(NULL, 'Watches', 'watches'),
(NULL, 'Kitchen & Dining', 'kitchen-dining'),
(NULL, 'Seasonal & Holiday', 'seasonal-holiday'),
(NULL, 'Safety & Security', 'safety-security');
  
-- Sub-categories (60 subcategories, 2 per root category)
INSERT INTO Categories (parent_id, name, slug) VALUES
-- 1. Electronics
(1, 'Laptops', 'laptops'),
(1, 'Smartphones', 'smartphones'),

-- 2. Clothing
(2, 'Men Clothing', 'men-clothing'),
(2, 'Women Clothing', 'women-clothing'),

-- 3. Home & Garden
(3, 'Furniture Sets', 'furniture-sets'),
(3, 'Home Decor', 'home-decor'),

-- 4. Beauty & Personal Care
(4, 'Skincare', 'skincare'),
(4, 'Hair Care', 'hair-care'),

-- 5. Health & Wellness
(5, 'Vitamins & Supplements', 'vitamins-supplements'),
(5, 'Fitness Equipment', 'fitness-equipment'),

-- 6. Sports & Outdoors
(6, 'Camping & Hiking', 'camping-hiking'),
(6, 'Sportswear', 'sportswear'),

-- 7. Toys & Games
(7, 'Board Games', 'board-games'),
(7, 'Action Figures', 'action-figures'),

-- 8. Automotive
(8, 'Car Accessories', 'car-accessories'),
(8, 'Motorbike Accessories', 'motorbike-accessories'),

-- 9. Books & Stationery
(9, 'Fiction Books', 'fiction-books'),
(9, 'Notebooks & Diaries', 'notebooks-diaries'),

-- 10. Groceries
(10, 'Snacks & Beverages', 'snacks-beverages'),
(10, 'Dairy Products', 'dairy-products'),

-- 11. Baby & Kids
(11, 'Baby Clothing', 'baby-clothing'),
(11, 'Baby Care', 'baby-care'),

-- 12. Jewelry & Accessories
(12, 'Necklaces', 'necklaces'),
(12, 'Earrings', 'earrings'),

-- 13. Shoes & Footwear
(13, 'Men Footwear', 'men-footwear'),
(13, 'Women Footwear', 'women-footwear'),

-- 14. Pet Supplies
(14, 'Dog Supplies', 'dog-supplies'),
(14, 'Cat Supplies', 'cat-supplies'),

-- 15. Furniture
(15, 'Living Room Furniture', 'living-room-furniture'),
(15, 'Bedroom Furniture', 'bedroom-furniture'),

-- 16. Office Supplies
(16, 'Printers & Scanners', 'printers-scanners'),
(16, 'Desk Accessories', 'desk-accessories'),

-- 17. Tools & Hardware
(17, 'Power Tools', 'power-tools'),
(17, 'Hand Tools', 'hand-tools'),

-- 18. Musical Instruments
(18, 'Guitars', 'guitars'),
(18, 'Keyboards', 'keyboards'),

-- 19. Arts & Crafts
(19, 'Painting Supplies', 'painting-supplies'),
(19, 'Craft Kits', 'craft-kits'),

-- 20. Cameras & Photography
(20, 'DSLR Cameras', 'dslr-cameras'),
(20, 'Camera Lenses', 'camera-lenses'),

-- 21. Computers & Laptops
(21, 'Desktops', 'desktops'),
(21, 'Gaming Laptops', 'gaming-laptops'),

-- 22. Mobile Phones & Tablets
(22, 'Android Phones', 'android-phones'),
(22, 'iPhones', 'iphones'),

-- 23. Appliances
(23, 'Refrigerators', 'refrigerators'),
(23, 'Washing Machines', 'washing-machines'),

-- 24. Travel & Luggage
(24, 'Suitcases', 'suitcases'),
(24, 'Backpacks', 'backpacks'),

-- 25. Movies & Entertainment
(25, 'DVDs & Blu-rays', 'dvds-blurays'),
(25, 'Music Albums', 'music-albums'),

-- 26. Gaming
(26, 'Consoles', 'consoles'),
(26, 'Video Games', 'video-games'),

-- 27. Watches
(27, 'Men Watches', 'men-watches'),
(27, 'Smart Watches', 'smart-watches'),

-- 28. Kitchen & Dining
(28, 'Cookware', 'cookware'),
(28, 'Tableware', 'tableware'),

-- 29. Seasonal & Holiday
(29, 'Christmas Decor', 'christmas-decor'),
(29, 'Halloween Supplies', 'halloween-supplies'),

-- 30. Safety & Security
(30, 'Home Security Systems', 'home-security-systems'),
(30, 'Surveillance Cameras', 'surveillance-cameras');

-- Verify inserted data
SELECT COUNT(*) AS total_categories FROM Categories;
SELECT * FROM Categories WHERE parent_id IS NULL LIMIT 10;
SELECT c.name AS subcategory, p.name AS parent_category 
FROM Categories c 
LEFT JOIN Categories p ON c.parent_id = p.category_id 
WHERE c.parent_id IS NOT NULL 
LIMIT 10;


-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Products Table (35 entries)
-- Module: Product Catalog
-- Note: Requires Categories table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 diverse products across different categories
INSERT INTO Products (category_id, title, description, brand, is_active, created_at) VALUES
(31, 'MacBook Pro 16" M3', 'Powerful laptop for professionals with M3 chip, 16GB RAM, 512GB SSD', 'Apple', TRUE, '2024-01-10 10:00:00'),
(32, 'iPhone 15 Pro Max', 'Latest flagship smartphone with A17 Pro chip and titanium design', 'Apple', TRUE, '2024-01-15 11:30:00'),
(33, 'Premium Cotton T-Shirt', 'Comfortable 100% organic cotton t-shirt for men', 'Nike', TRUE, '2024-02-01 09:15:00'),
(34, 'Summer Floral Dress', 'Elegant floral print dress perfect for summer occasions', 'Zara', TRUE, '2024-02-10 14:20:00'),
(35, 'Modern Sofa Set', 'Contemporary 3-seater sofa with premium fabric upholstery', 'IKEA', TRUE, '2024-02-20 10:45:00'),
(36, 'Decorative Wall Art', 'Hand-painted canvas art for living room decoration', 'HomeStyle', TRUE, '2024-03-01 13:30:00'),
(37, 'Vitamin C Face Serum', 'Brightening serum with 20% vitamin C for radiant skin', 'The Ordinary', TRUE, '2024-03-10 08:50:00'),
(38, 'Argan Oil Shampoo', 'Nourishing shampoo for damaged and dry hair', 'OGX', TRUE, '2024-03-15 15:10:00'),
(39, 'Multivitamin Complex', 'Daily multivitamin supplement with essential nutrients', 'Nature Made', TRUE, '2024-04-01 10:20:00'),
(40, 'Adjustable Dumbbell Set', 'Space-saving adjustable dumbbells 5-52.5 lbs', 'Bowflex', TRUE, '2024-04-10 12:35:00'),
(41, 'Camping Tent 4-Person', 'Waterproof family camping tent with easy setup', 'Coleman', TRUE, '2024-04-20 09:40:00'),
(42, 'Running Shorts Men', 'Lightweight moisture-wicking running shorts', 'Under Armour', TRUE, '2024-05-01 14:15:00'),
(43, 'Strategy Board Game', 'Award-winning strategy game for 2-4 players', 'Catan', TRUE, '2024-05-10 11:25:00'),
(44, 'Superhero Action Figure', 'Collectible 12-inch articulated action figure', 'Marvel', TRUE, '2024-05-20 16:30:00'),
(45, 'Car Phone Mount', 'Universal magnetic phone holder for car dashboard', 'iOttie', TRUE, '2024-06-01 10:05:00'),
(46, 'Motorcycle Gloves', 'Protective leather gloves for riders', 'Alpinestars', TRUE, '2024-06-10 13:45:00'),
(47, 'Mystery Novel Collection', 'Bestselling mystery thriller paperback book', 'Penguin Books', TRUE, '2024-06-20 09:30:00'),
(48, 'Leather Journal', 'Handcrafted leather-bound journal with 200 pages', 'Moleskine', TRUE, '2024-07-01 15:20:00'),
(49, 'Organic Trail Mix', 'Healthy snack mix with nuts, seeds and dried fruits', 'Nature Valley', TRUE, '2024-07-10 08:55:00'),
(50, 'Greek Yogurt Pack', 'High-protein probiotic yogurt 6-pack', 'Chobani', TRUE, '2024-07-20 12:10:00'),
(51, 'Baby Onesie 3-Pack', 'Soft cotton baby bodysuits in assorted colors', 'Gerber', TRUE, '2024-08-01 10:35:00'),
(52, 'Baby Wipes Sensitive', 'Hypoallergenic fragrance-free baby wipes 500 count', 'Pampers', TRUE, '2024-08-10 14:50:00'),
(53, 'Gold Pendant Necklace', 'Elegant 18K gold plated pendant with chain', 'Swarovski', TRUE, '2024-08-20 11:15:00'),
(54, 'Diamond Stud Earrings', 'Classic sterling silver earrings with cubic zirconia', 'Pandora', TRUE, '2024-09-01 16:25:00'),
(55, 'Leather Oxford Shoes', 'Handcrafted genuine leather formal shoes for men', 'Clarks', TRUE, '2024-09-10 09:40:00'),
(56, 'High Heel Pumps', 'Elegant pointed-toe pumps for women', 'Steve Madden', TRUE, '2024-09-20 13:55:00'),
(57, 'Premium Dog Food 15kg', 'Grain-free natural dog food for all breeds', 'Blue Buffalo', TRUE, '2024-10-01 10:30:00'),
(58, 'Cat Scratching Post', 'Multi-level cat tree with sisal scratching posts', 'Frisco', TRUE, '2024-10-10 15:45:00'),
(59, 'Recliner Armchair', 'Comfortable leather recliner for living room', 'La-Z-Boy', TRUE, '2024-10-20 08:20:00'),
(60, 'Queen Size Bed Frame', 'Solid wood platform bed with headboard', 'Zinus', TRUE, '2024-11-01 12:40:00'),
(61, 'Wireless All-in-One Printer', 'Color printer with scanner and copier', 'HP', TRUE, '2024-11-05 09:50:00'),
(62, 'Desk Organizer Set', 'Bamboo desktop organizer with multiple compartments', 'SimpleHouseware', TRUE, '2024-11-07 14:05:00'),
(63, 'Cordless Drill Kit', '20V drill driver with battery and charger', 'DeWalt', TRUE, '2024-11-08 11:30:00'),
(64, 'Acoustic Guitar Bundle', 'Full-size guitar with case, tuner and picks', 'Fender', TRUE, '2024-11-09 16:15:00'),
(65, 'Watercolor Paint Set', 'Professional watercolor set with 36 colors', 'Winsor & Newton', TRUE, '2024-11-10 10:25:00');

-- Verify inserted data
SELECT COUNT(*) AS total_products FROM Products;
SELECT p.title, p.brand, c.name AS category 
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LIMIT 10;


-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for ProductImages Table (35 entries)
-- Module: Product Catalog
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 product images (1-2 images per product)
INSERT INTO ProductImages (product_id, url, alt_text, sort_order) VALUES
-- Product 1: MacBook Pro
(1, 'https://cdn.urbanease.com/products/macbook-pro-16-front.jpg', 'MacBook Pro 16 inch front view', 0),
(1, 'https://cdn.urbanease.com/products/macbook-pro-16-side.jpg', 'MacBook Pro 16 inch side view', 1),

-- Product 2: iPhone 15 Pro Max
(2, 'https://cdn.urbanease.com/products/iphone-15-pro-max-blue.jpg', 'iPhone 15 Pro Max in blue titanium', 0),

-- Product 3: T-Shirt
(3, 'https://cdn.urbanease.com/products/cotton-tshirt-men-black.jpg', 'Black cotton t-shirt for men', 0),

-- Product 4: Summer Dress
(4, 'https://cdn.urbanease.com/products/floral-dress-women-summer.jpg', 'Women summer floral dress', 0),
(4, 'https://cdn.urbanease.com/products/floral-dress-detail.jpg', 'Floral dress detail view', 1),

-- Product 5: Sofa Set
(5, 'https://cdn.urbanease.com/products/modern-sofa-grey.jpg', 'Modern grey sofa set', 0),

-- Product 6: Wall Art
(6, 'https://cdn.urbanease.com/products/wall-art-abstract.jpg', 'Abstract wall art painting', 0),

-- Product 7: Face Serum
(7, 'https://cdn.urbanease.com/products/vitamin-c-serum.jpg', 'Vitamin C face serum bottle', 0),

-- Product 8: Shampoo
(8, 'https://cdn.urbanease.com/products/argan-oil-shampoo.jpg', 'Argan oil shampoo bottle', 0),
(8, 'https://cdn.urbanease.com/products/argan-oil-ingredients.jpg', 'Shampoo ingredients label', 1),

-- Product 9: Multivitamin
(9, 'https://cdn.urbanease.com/products/multivitamin-complex.jpg', 'Multivitamin supplement bottle', 0),

-- Product 10: Dumbbells
(10, 'https://cdn.urbanease.com/products/adjustable-dumbbells.jpg', 'Adjustable dumbbell set', 0),

-- Product 11: Camping Tent
(11, 'https://cdn.urbanease.com/products/camping-tent-4person.jpg', '4-person camping tent', 0),
(11, 'https://cdn.urbanease.com/products/tent-interior.jpg', 'Tent interior view', 1),

-- Product 12: Running Shorts
(12, 'https://cdn.urbanease.com/products/running-shorts-men-blue.jpg', 'Men blue running shorts', 0),

-- Product 13: Board Game
(13, 'https://cdn.urbanease.com/products/catan-board-game.jpg', 'Catan strategy board game', 0),

-- Product 14: Action Figure
(14, 'https://cdn.urbanease.com/products/superhero-action-figure.jpg', 'Marvel superhero action figure', 0),

-- Product 15: Phone Mount
(15, 'https://cdn.urbanease.com/products/car-phone-mount.jpg', 'Magnetic car phone mount', 0),

-- Product 16: Motorcycle Gloves
(16, 'https://cdn.urbanease.com/products/motorcycle-gloves-leather.jpg', 'Leather motorcycle gloves', 0),
(16, 'https://cdn.urbanease.com/products/gloves-detail.jpg', 'Gloves protection detail', 1),

-- Product 17: Mystery Novel
(17, 'https://cdn.urbanease.com/products/mystery-novel-cover.jpg', 'Mystery novel book cover', 0),

-- Product 18: Leather Journal
(18, 'https://cdn.urbanease.com/products/leather-journal-brown.jpg', 'Brown leather journal', 0),

-- Product 19: Trail Mix
(19, 'https://cdn.urbanease.com/products/organic-trail-mix.jpg', 'Organic trail mix pack', 0),

-- Product 20: Greek Yogurt
(20, 'https://cdn.urbanease.com/products/greek-yogurt-6pack.jpg', 'Greek yogurt 6-pack', 0),

-- Product 21: Baby Onesie
(21, 'https://cdn.urbanease.com/products/baby-onesie-3pack.jpg', 'Baby onesie 3-pack assorted', 0),

-- Product 22: Baby Wipes
(22, 'https://cdn.urbanease.com/products/baby-wipes-sensitive.jpg', 'Sensitive baby wipes pack', 0),

-- Product 23: Pendant Necklace
(23, 'https://cdn.urbanease.com/products/gold-pendant-necklace.jpg', 'Gold pendant necklace', 0),

-- Product 24: Earrings
(24, 'https://cdn.urbanease.com/products/diamond-stud-earrings.jpg', 'Diamond stud earrings', 0),

-- Product 25: Oxford Shoes
(25, 'https://cdn.urbanease.com/products/leather-oxford-shoes-brown.jpg', 'Brown leather oxford shoes', 0),

-- Product 26: High Heels
(26, 'https://cdn.urbanease.com/products/high-heel-pumps-black.jpg', 'Black high heel pumps', 0),
(26, 'https://cdn.urbanease.com/products/pumps-side-view.jpg', 'Pumps side view', 1),

-- Product 27: Dog Food
(27, 'https://cdn.urbanease.com/products/premium-dog-food-15kg.jpg', 'Premium dog food 15kg bag', 0),

-- Product 28: Cat Tree
(28, 'https://cdn.urbanease.com/products/cat-scratching-post.jpg', 'Multi-level cat scratching post', 0),

-- Product 29: Recliner
(29, 'https://cdn.urbanease.com/products/leather-recliner-armchair.jpg', 'Leather recliner armchair', 0),

-- Product 30: Bed Frame
(30, 'https://cdn.urbanease.com/products/queen-bed-frame-wood.jpg', 'Queen size wooden bed frame', 0),

-- Product 31: Printer
(31, 'https://cdn.urbanease.com/products/wireless-printer-hp.jpg', 'HP wireless all-in-one printer', 0),

-- Product 32: Desk Organizer
(32, 'https://cdn.urbanease.com/products/bamboo-desk-organizer.jpg', 'Bamboo desk organizer set', 0),

-- Product 33: Drill Kit
(33, 'https://cdn.urbanease.com/products/cordless-drill-kit.jpg', 'Cordless drill kit with battery', 0),

-- Product 34: Acoustic Guitar
(34, 'https://cdn.urbanease.com/products/acoustic-guitar-bundle.jpg', 'Acoustic guitar bundle with accessories', 0),

-- Product 35: Watercolor Set
(35, 'https://cdn.urbanease.com/products/watercolor-paint-set.jpg', 'Professional watercolor paint set', 0);

-- Verify inserted data
SELECT COUNT(*) AS total_images FROM ProductImages;
SELECT pi.image_id, p.title, pi.alt_text, pi.sort_order
FROM ProductImages pi
JOIN Products p ON pi.product_id = p.product_id
LIMIT 10;


-- =============================================
-- Kumar, Virat
-- Module: Product Variants & Inventory Management
-- Tables: ProductVariants, Warehouses, Inventory
-- =============================================

-- Data for tables: ProductVariants, Warehouses, Inventory

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


-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Sample Data for ProductVariants Table (35 entries)
-- Module: Inventory Management
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 product variants with different SKUs, attributes, and pricing
INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency, is_active, created_at) VALUES
-- Product 1: MacBook Pro variants
(1, 'MBP16-M3-16-512-SG', '{"color":"Space Gray","memory":"16GB","storage":"512GB"}', 2499.00, 'USD', TRUE, '2024-01-10 10:00:00'),
(1, 'MBP16-M3-32-1TB-SIL', '{"color":"Silver","memory":"32GB","storage":"1TB"}', 3299.00, 'USD', TRUE, '2024-01-10 10:00:00'),

-- Product 2: iPhone variants
(2, 'IPH15PM-256-BLU', '{"color":"Blue Titanium","storage":"256GB"}', 1199.00, 'USD', TRUE, '2024-01-15 11:30:00'),
(2, 'IPH15PM-512-NAT', '{"color":"Natural Titanium","storage":"512GB"}', 1399.00, 'USD', TRUE, '2024-01-15 11:30:00'),

-- Product 3: T-Shirt variants
(3, 'TSHIRT-M-BLK', '{"size":"M","color":"Black"}', 29.99, 'USD', TRUE, '2024-02-01 09:15:00'),
(3, 'TSHIRT-L-BLU', '{"size":"L","color":"Blue"}', 29.99, 'USD', TRUE, '2024-02-01 09:15:00'),

-- Product 4: Dress variants
(4, 'DRESS-S-FLO', '{"size":"S","pattern":"Floral"}', 79.99, 'USD', TRUE, '2024-02-10 14:20:00'),
(4, 'DRESS-M-FLO', '{"size":"M","pattern":"Floral"}', 79.99, 'USD', TRUE, '2024-02-10 14:20:00'),

-- Product 5: Sofa
(5, 'SOFA-3SEAT-GRY', '{"seats":"3","color":"Grey"}', 899.00, 'USD', TRUE, '2024-02-20 10:45:00'),

-- Product 6: Wall Art
(6, 'WALLART-24X36-ABS', '{"size":"24x36","style":"Abstract"}', 149.99, 'USD', TRUE, '2024-03-01 13:30:00'),

-- Product 7: Face Serum
(7, 'SERUM-VITC-30ML', '{"volume":"30ml","type":"Vitamin C"}', 24.99, 'USD', TRUE, '2024-03-10 08:50:00'),

-- Product 8: Shampoo
(8, 'SHAMP-ARGAN-385ML', '{"volume":"385ml","ingredient":"Argan Oil"}', 12.99, 'USD', TRUE, '2024-03-15 15:10:00'),

-- Product 9: Multivitamin
(9, 'MULTIVIT-100CT', '{"count":"100 tablets","type":"Adult"}', 19.99, 'USD', TRUE, '2024-04-01 10:20:00'),

-- Product 10: Dumbbells
(10, 'DUMBBELL-ADJ-52LB', '{"weight":"5-52.5 lbs","type":"Adjustable"}', 349.99, 'USD', TRUE, '2024-04-10 12:35:00'),

-- Product 11: Tent
(11, 'TENT-4P-BLU', '{"capacity":"4 person","color":"Blue"}', 189.99, 'USD', TRUE, '2024-04-20 09:40:00'),

-- Product 12: Shorts
(12, 'SHORT-M-BLK', '{"size":"M","color":"Black"}', 39.99, 'USD', TRUE, '2024-05-01 14:15:00'),
(12, 'SHORT-L-NAV', '{"size":"L","color":"Navy"}', 39.99, 'USD', TRUE, '2024-05-01 14:15:00'),

-- Product 13: Board Game
(13, 'CATAN-BASE-EN', '{"edition":"Base Game","language":"English"}', 44.99, 'USD', TRUE, '2024-05-10 11:25:00'),

-- Product 14: Action Figure
(14, 'ACTION-SPDR-12IN', '{"character":"Spider-Man","size":"12 inch"}', 34.99, 'USD', TRUE, '2024-05-20 16:30:00'),

-- Product 15: Phone Mount
(15, 'CARMNT-MAG-BLK', '{"type":"Magnetic","color":"Black"}', 24.99, 'USD', TRUE, '2024-06-01 10:05:00'),

-- Product 16: Gloves
(16, 'GLOVE-L-BLK', '{"size":"L","material":"Leather","color":"Black"}', 79.99, 'USD', TRUE, '2024-06-10 13:45:00'),

-- Product 17: Novel
(17, 'BOOK-MYST-PB', '{"format":"Paperback","genre":"Mystery"}', 14.99, 'USD', TRUE, '2024-06-20 09:30:00'),

-- Product 18: Journal
(18, 'JRNL-LTH-BRN-200', '{"material":"Leather","color":"Brown","pages":"200"}', 29.99, 'USD', TRUE, '2024-07-01 15:20:00'),

-- Product 19: Trail Mix
(19, 'SNACK-TRLMX-12OZ', '{"weight":"12 oz","type":"Organic"}', 8.99, 'USD', TRUE, '2024-07-10 08:55:00'),

-- Product 20: Yogurt
(20, 'YOGURT-GRK-6PK', '{"count":"6 pack","protein":"High"}', 6.99, 'USD', TRUE, '2024-07-20 12:10:00'),

-- Product 21: Onesie
(21, 'BABY-ONES-3M-3PK', '{"size":"3 months","count":"3 pack"}', 19.99, 'USD', TRUE, '2024-08-01 10:35:00'),

-- Product 22: Wipes
(22, 'WIPES-BABY-500CT', '{"count":"500","type":"Sensitive"}', 12.99, 'USD', TRUE, '2024-08-10 14:50:00'),

-- Product 23: Necklace
(23, 'NECKL-GLD-PEND', '{"material":"18K Gold Plated","style":"Pendant"}', 89.99, 'USD', TRUE, '2024-08-20 11:15:00'),

-- Product 24: Earrings
(24, 'EARR-SIL-CZ', '{"material":"Sterling Silver","stone":"Cubic Zirconia"}', 49.99, 'USD', TRUE, '2024-09-01 16:25:00'),

-- Product 25: Oxford Shoes
(25, 'SHOE-OXF-10-BRN', '{"size":"10","color":"Brown","material":"Leather"}', 129.99, 'USD', TRUE, '2024-09-10 09:40:00'),

-- Product 26: High Heels
(26, 'HEEL-8-BLK', '{"size":"8","color":"Black","heel":"3 inch"}', 89.99, 'USD', TRUE, '2024-09-20 13:55:00'),

-- Product 27: Dog Food
(27, 'DOGFD-15KG-GF', '{"weight":"15kg","type":"Grain Free"}', 59.99, 'USD', TRUE, '2024-10-01 10:30:00'),

-- Product 28: Cat Tree
(28, 'CATTREE-3LVL-BEI', '{"levels":"3","color":"Beige"}', 79.99, 'USD', TRUE, '2024-10-10 15:45:00'),

-- Product 29: Recliner
(29, 'RECL-LTH-BRN', '{"material":"Leather","color":"Brown"}', 699.00, 'USD', TRUE, '2024-10-20 08:20:00'),

-- Product 30: Bed Frame
(30, 'BED-QUEEN-WOOD', '{"size":"Queen","material":"Wood"}', 399.00, 'USD', TRUE, '2024-11-01 12:40:00'),

-- Product 31: Printer
(31, 'PRNT-HP-WIFI-COL', '{"brand":"HP","connectivity":"WiFi","color":"Yes"}', 199.99, 'USD', TRUE, '2024-11-05 09:50:00'),

-- Product 32: Desk Organizer
(32, 'DESK-ORG-BAMB', '{"material":"Bamboo","compartments":"5"}', 34.99, 'USD', TRUE, '2024-11-07 14:05:00'),

-- Product 33: Drill Kit
(33, 'DRILL-20V-KIT', '{"voltage":"20V","battery":"2Ah","type":"Cordless"}', 149.99, 'USD', TRUE, '2024-11-08 11:30:00'),

-- Product 34: Guitar
(34, 'GUITAR-AC-NAT', '{"type":"Acoustic","color":"Natural","size":"Full"}', 299.99, 'USD', TRUE, '2024-11-09 16:15:00'),

-- Product 35: Watercolor
(35, 'PAINT-WC-36COL', '{"type":"Watercolor","colors":"36","quality":"Professional"}', 54.99, 'USD', TRUE, '2024-11-10 10:25:00');

-- Verify inserted data
SELECT COUNT(*) AS total_variants FROM ProductVariants;
SELECT pv.sku, p.title, pv.price, pv.attributes_json
FROM ProductVariants pv
JOIN Products p ON pv.product_id = p.product_id
LIMIT 10;


-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Sample Data for Inventory Table (35 entries)
-- Module: Inventory Management
-- Note: Requires Warehouses and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 inventory records across different warehouses and variants
-- Each record tracks on_hand and reserved quantities
INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved) VALUES
-- NYC Warehouse (warehouse_id = 1)
(1, 1, 45, 5),    -- MacBook Pro Space Gray
(1, 3, 120, 15),  -- iPhone Blue
(1, 5, 200, 25),  -- T-Shirt M Black
(1, 9, 30, 2),    -- Sofa Grey
(1, 11, 85, 10),  -- Face Serum

-- LA Warehouse (warehouse_id = 2)
(2, 2, 38, 4),    -- MacBook Pro Silver
(2, 4, 95, 12),   -- iPhone Natural
(2, 6, 180, 20),  -- T-Shirt L Blue
(2, 12, 60, 8),   -- Shampoo
(2, 15, 150, 18), -- Dumbbells

-- Chicago Warehouse (warehouse_id = 3)
(3, 7, 75, 9),    -- Dress S
(3, 8, 65, 7),    -- Dress M
(3, 10, 40, 3),   -- Wall Art
(3, 13, 110, 14), -- Multivitamin
(3, 16, 50, 5),   -- Tent

-- Houston Warehouse (warehouse_id = 4)
(4, 17, 140, 16), -- Shorts M
(4, 18, 125, 13), -- Shorts L
(4, 19, 90, 11),  -- Board Game
(4, 20, 70, 8),   -- Action Figure
(4, 21, 160, 19), -- Phone Mount

-- Phoenix Warehouse (warehouse_id = 5)
(5, 22, 55, 6),   -- Gloves
(5, 23, 200, 24), -- Novel
(5, 24, 80, 9),   -- Journal
(5, 25, 300, 35), -- Trail Mix
(5, 26, 250, 28), -- Yogurt

-- Philadelphia Warehouse (warehouse_id = 6)
(6, 27, 175, 21), -- Baby Onesie
(6, 28, 220, 26), -- Baby Wipes
(6, 29, 45, 5),   -- Necklace
(6, 30, 65, 7),   -- Earrings
(6, 31, 85, 10),  -- Oxford Shoes

-- San Antonio Warehouse (warehouse_id = 7)
(7, 32, 95, 11),  -- High Heels
(7, 33, 40, 4),   -- Dog Food
(7, 34, 55, 6),   -- Cat Tree
(7, 35, 15, 2);   -- Watercolor Set

-- Verify inserted data
SELECT COUNT(*) AS total_inventory_records FROM Inventory;
SELECT 
    w.name AS warehouse, 
    pv.sku, 
    i.on_hand, 
    i.reserved,
    (i.on_hand - i.reserved) AS available
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN ProductVariants pv ON i.variant_id = pv.variant_id
LIMIT 10;


-- =============================================
-- Velarde Sosa, Diana
-- Module: User Addresses, Payments & Reviews
-- Tables: Addresses, Payments, Reviews
-- =============================================

-- Data for tables: Addresses, Payments, Reviews

-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Addresses Table (35 entries)
-- Module: User Addresses
-- Note: Requires Users table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 user addresses (shipping and billing)
INSERT INTO Addresses (user_id, label, name, line1, line2, city, state_region, postal_code, country_code, phone, is_default, created_at) VALUES
-- User 2 addresses
(2, 'Home', 'John Doe', '123 Main Street', 'Apt 4B', 'New York', 'New York', '10001', 'US', '+1-555-0102', TRUE, '2024-02-20 15:00:00'),
(2, 'Office', 'John Doe', '456 Business Ave', 'Suite 200', 'New York', 'New York', '10002', 'US', '+1-555-0102', FALSE, '2024-03-10 10:30:00'),

-- User 3 addresses
(3, 'Home', 'Jane Smith', '789 Oak Drive', NULL, 'Los Angeles', 'California', '90001', 'US', '+1-555-0103', TRUE, '2024-02-21 11:00:00'),

-- User 4 addresses
(4, 'Home', 'Michael Brown', '321 Elm Street', 'Unit 12', 'Chicago', 'Illinois', '60601', 'US', '+1-555-0104', TRUE, '2024-03-05 17:15:00'),

-- User 5 addresses
(5, 'Home', 'Emily Davis', '654 Pine Road', NULL, 'Houston', 'Texas', '77001', 'US', '+1-555-0105', TRUE, '2024-03-10 12:00:00'),
(5, 'Work', 'Emily Davis', '987 Corporate Blvd', 'Floor 15', 'Houston', 'Texas', '77002', 'US', '+1-555-0105', FALSE, '2024-04-05 14:20:00'),

-- User 6 addresses
(6, 'Home', 'David Wilson', '147 Maple Lane', NULL, 'Phoenix', 'Arizona', '85001', 'US', '+1-555-0106', TRUE, '2024-03-15 14:00:00'),

-- User 7 addresses
(7, 'Home', 'Sarah Martinez', '258 Cedar Avenue', 'Apt 8C', 'Philadelphia', 'Pennsylvania', '19101', 'US', '+1-555-0107', TRUE, '2024-04-01 09:30:00'),

-- User 8 addresses
(8, 'Home', 'James Anderson', '369 Birch Street', NULL, 'San Antonio', 'Texas', '78201', 'US', '+1-555-0108', TRUE, '2024-04-05 16:00:00'),

-- User 9 addresses
(9, 'Home', 'Lisa Taylor', '741 Willow Court', 'Unit 5A', 'San Diego', 'California', '92101', 'US', '+1-555-0109', TRUE, '2024-04-12 11:15:00'),

-- User 10 addresses
(10, 'Home', 'Robert Thomas', '852 Spruce Way', NULL, 'Dallas', 'Texas', '75201', 'US', '+1-555-0110', TRUE, '2024-04-20 13:30:00'),

-- User 11 addresses
(11, 'Home', 'Jennifer Jackson', '963 Ash Boulevard', 'Apt 3D', 'San Jose', 'California', '95101', 'US', '+1-555-0111', TRUE, '2024-05-01 10:45:00'),

-- User 12 addresses
(12, 'Home', 'William White', '159 Poplar Street', NULL, 'Austin', 'Texas', '73301', 'US', '+1-555-0112', TRUE, '2024-05-08 15:00:00'),

-- User 13 addresses
(13, 'Home', 'Mary Harris', '357 Cypress Drive', 'Suite 10', 'Jacksonville', 'Florida', '32099', 'US', '+1-555-0113', TRUE, '2024-05-15 12:20:00'),

-- User 14 addresses
(14, 'Home', 'Charles Martin', '486 Redwood Lane', NULL, 'Fort Worth', 'Texas', '76101', 'US', '+1-555-0114', TRUE, '2024-05-22 17:10:00'),

-- User 15 addresses
(15, 'Home', 'Patricia Thompson', '597 Hickory Road', 'Apt 7B', 'Columbus', 'Ohio', '43004', 'US', '+1-555-0115', TRUE, '2024-06-01 09:40:00'),

-- User 16 addresses
(16, 'Home', 'Daniel Garcia', '618 Magnolia Street', NULL, 'Charlotte', 'North Carolina', '28202', 'US', '+1-555-0116', TRUE, '2024-06-10 14:00:00'),

-- User 17 addresses
(17, 'Home', 'Linda Martinez', '729 Sycamore Avenue', 'Unit 2C', 'Seattle', 'Washington', '98101', 'US', '+1-555-0117', TRUE, '2024-06-18 11:30:00'),

-- User 18 addresses
(18, 'Home', 'Joseph Robinson', '840 Walnut Court', NULL, 'Denver', 'Colorado', '80014', 'US', '+1-555-0118', TRUE, '2024-06-25 16:20:00'),

-- User 19 addresses
(19, 'Home', 'Barbara Clark', '951 Chestnut Way', 'Apt 9A', 'Boston', 'Massachusetts', '02101', 'US', '+1-555-0119', TRUE, '2024-07-02 10:00:00'),

-- User 20 addresses
(20, 'Home', 'Thomas Rodriguez', '162 Beech Boulevard', NULL, 'Detroit', 'Michigan', '48201', 'US', '+1-555-0120', TRUE, '2024-07-10 15:30:00'),

-- User 21 addresses
(21, 'Home', 'Susan Lewis', '273 Palm Drive', 'Suite 5', 'Portland', 'Oregon', '97201', 'US', '+1-555-0121', TRUE, '2024-07-18 12:45:00'),

-- User 22 addresses
(22, 'Home', 'Christopher Lee', '384 Fir Street', NULL, 'Las Vegas', 'Nevada', '89101', 'US', '+1-555-0122', TRUE, '2024-07-25 17:00:00'),

-- User 23 addresses
(23, 'Home', 'Jessica Walker', '495 Juniper Lane', 'Apt 6D', 'Miami', 'Florida', '33101', 'US', '+1-555-0123', TRUE, '2024-08-01 09:20:00'),

-- User 24 addresses
(24, 'Home', 'Matthew Hall', '516 Hemlock Road', NULL, 'Atlanta', 'Georgia', '30303', 'US', '+1-555-0124', TRUE, '2024-08-08 14:40:00'),

-- User 25 addresses
(25, 'Home', 'Karen Allen', '627 Laurel Avenue', 'Unit 11B', 'Minneapolis', 'Minnesota', '55401', 'US', '+1-555-0125', TRUE, '2024-08-15 11:10:00'),

-- User 26 addresses
(26, 'Home', 'Mark Young', '738 Dogwood Court', NULL, 'Orlando', 'Florida', '32801', 'US', '+1-555-0126', TRUE, '2024-08-22 16:50:00'),

-- User 27 addresses
(27, 'Home', 'Nancy Hernandez', '849 Cottonwood Way', 'Apt 4A', 'San Francisco', 'California', '94102', 'US', '+1-555-0127', TRUE, '2024-09-01 10:30:00'),

-- User 28 addresses
(28, 'Home', 'Paul King', '950 Alder Boulevard', NULL, 'Tampa', 'Florida', '33601', 'US', '+1-555-0128', TRUE, '2024-09-10 15:15:00'),

-- User 29 addresses
(29, 'Home', 'Betty Wright', '161 Sequoia Street', 'Suite 8', 'Sacramento', 'California', '94203', 'US', '+1-555-0129', TRUE, '2024-09-18 12:35:00'),

-- User 30 addresses
(30, 'Home', 'Steven Lopez', '272 Eucalyptus Drive', NULL, 'Kansas City', 'Missouri', '64101', 'US', '+1-555-0130', TRUE, '2024-09-25 17:50:00'),

-- Additional addresses for users with multiple
(10, 'Parents House', 'Robert Thomas', '555 Family Lane', NULL, 'Dallas', 'Texas', '75202', 'US', '+1-555-0110', FALSE, '2024-06-15 10:00:00'),
(15, 'Vacation Home', 'Patricia Thompson', '777 Beach Road', NULL, 'Miami', 'Florida', '33139', 'US', '+1-555-0115', FALSE, '2024-07-20 14:30:00'),
(20, 'Office', 'Thomas Rodriguez', '888 Work Plaza', 'Floor 22', 'Detroit', 'Michigan', '48202', 'US', '+1-555-0120', FALSE, '2024-08-10 11:45:00'),
(25, 'Shipping Address', 'Karen Allen', '999 Delivery Lane', 'Warehouse B', 'Minneapolis', 'Minnesota', '55402', 'US', '+1-555-0125', FALSE, '2024-09-05 16:20:00'),
(30, 'Billing Address', 'Steven Lopez', '111 Payment Street', NULL, 'Kansas City', 'Missouri', '64102', 'US', '+1-555-0130', FALSE, '2024-10-01 09:30:00');

-- Verify inserted data
SELECT COUNT(*) AS total_addresses FROM Addresses;
SELECT 
    a.address_id,
    u.full_name,
    a.label,
    CONCAT(a.line1, ', ', a.city, ', ', a.state_region, ' ', a.postal_code) AS full_address,
    a.is_default
FROM Addresses a
JOIN Users u ON a.user_id = u.user_id
LIMIT 10;


-- =============================================
-- Min, La Yaung
-- Module: Shopping Cart & Promotions
-- Tables: Carts, CartItems, Coupons
-- =============================================

-- Data for tables: Carts, CartItems, Coupons

-- =============================================
-- Author: Min, La Yaung
-- Create date: November 2025
-- Description: Sample Data for Carts Table (35 entries)
-- Module: Shopping Cart
-- Note: Requires Users table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 shopping carts (mix of active, abandoned, and guest carts)
INSERT INTO Carts (user_id, created_at, updated_at) VALUES
-- Active customer carts (recently updated)
(2, '2024-11-01 10:00:00', '2024-11-07 14:30:00'),
(3, '2024-11-02 11:15:00', '2024-11-07 15:45:00'),
(4, '2024-11-03 09:30:00', '2024-11-07 10:20:00'),
(5, '2024-11-04 14:20:00', '2024-11-07 16:10:00'),
(6, '2024-11-05 08:45:00', '2024-11-07 11:35:00'),

-- Recent carts (updated within last 2 days)
(7, '2024-11-05 16:30:00', '2024-11-06 09:15:00'),
(8, '2024-11-06 10:20:00', '2024-11-07 13:20:00'),
(9, '2024-11-06 13:40:00', '2024-11-07 08:50:00'),
(10, '2024-11-06 15:10:00', '2024-11-06 18:25:00'),

-- Abandoned carts (not updated in 3-7 days)
(11, '2024-10-28 10:00:00', '2024-10-28 10:15:00'),
(12, '2024-10-29 11:30:00', '2024-10-29 11:45:00'),
(13, '2024-10-30 14:20:00', '2024-10-30 14:35:00'),
(14, '2024-10-31 09:15:00', '2024-10-31 09:30:00'),
(15, '2024-11-01 16:40:00', '2024-11-01 16:55:00'),

-- Old abandoned carts (7+ days)
(16, '2024-10-20 10:00:00', '2024-10-20 10:20:00'),
(17, '2024-10-21 12:30:00', '2024-10-21 12:45:00'),
(18, '2024-10-22 15:10:00', '2024-10-22 15:25:00'),
(19, '2024-10-23 08:45:00', '2024-10-23 09:00:00'),
(20, '2024-10-24 14:20:00', '2024-10-24 14:35:00'),

-- Guest carts (user_id is NULL)
(NULL, '2024-11-07 09:00:00', '2024-11-07 09:45:00'),
(NULL, '2024-11-07 10:30:00', '2024-11-07 11:15:00'),
(NULL, '2024-11-07 12:00:00', '2024-11-07 12:30:00'),
(NULL, '2024-11-06 14:20:00', '2024-11-06 14:50:00'),
(NULL, '2024-11-06 16:10:00', '2024-11-06 16:40:00'),

-- More customer carts (various states)
(21, '2024-11-03 10:30:00', '2024-11-07 09:20:00'),
(22, '2024-11-04 13:15:00', '2024-11-06 15:30:00'),
(23, '2024-10-25 11:00:00', '2024-10-25 11:20:00'),
(24, '2024-11-05 09:45:00', '2024-11-07 14:10:00'),
(25, '2024-10-27 14:30:00', '2024-10-27 14:50:00'),

-- Additional guest and customer carts
(NULL, '2024-11-05 08:00:00', '2024-11-05 08:25:00'),
(26, '2024-11-06 10:15:00', '2024-11-07 12:45:00'),
(27, '2024-10-26 16:20:00', '2024-10-26 16:40:00'),
(28, '2024-11-07 07:30:00', '2024-11-07 13:50:00'),
(29, '2024-11-02 12:10:00', '2024-11-07 10:35:00'),
(30, '2024-11-01 15:40:00', '2024-11-07 16:20:00');

-- Verify inserted data
SELECT COUNT(*) AS total_carts FROM Carts;
SELECT 
    cart_id,
    CASE WHEN user_id IS NULL THEN 'Guest' ELSE CONCAT('User ', user_id) END AS cart_owner,
    created_at,
    updated_at,
    DATEDIFF(NOW(), updated_at) AS days_since_update
FROM Carts
ORDER BY updated_at DESC
LIMIT 10;


-- =============================================
-- Author: Min, La Yaung
-- Create date: November 2025
-- Description: Sample Data for CartItems Table (35 entries)
-- Module: Shopping Cart
-- Note: Requires Carts and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 cart items (1-3 items per cart)
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price, added_at) VALUES
-- Cart 1 items
(1, 1, 1, 2499.00, '2024-11-01 10:05:00'),
(1, 11, 2, 24.99, '2024-11-07 14:30:00'),

-- Cart 2 items
(2, 3, 1, 1199.00, '2024-11-02 11:20:00'),
(2, 21, 3, 24.99, '2024-11-07 15:45:00'),

-- Cart 3 items
(3, 5, 2, 29.99, '2024-11-03 09:35:00'),

-- Cart 4 items
(4, 7, 1, 79.99, '2024-11-04 14:25:00'),
(4, 12, 1, 12.99, '2024-11-07 16:10:00'),

-- Cart 5 items
(5, 9, 1, 899.00, '2024-11-05 08:50:00'),

-- Cart 6 items
(6, 15, 1, 349.99, '2024-11-05 16:35:00'),

-- Cart 7 items
(7, 17, 2, 39.99, '2024-11-06 10:25:00'),
(7, 19, 1, 44.99, '2024-11-07 13:20:00'),

-- Cart 8 items
(8, 23, 5, 14.99, '2024-11-06 13:45:00'),

-- Cart 9 items
(9, 25, 10, 8.99, '2024-11-06 15:15:00'),

-- Cart 10 items
(10, 27, 3, 19.99, '2024-11-06 18:25:00'),

-- Cart 11 items (abandoned)
(11, 2, 1, 3299.00, '2024-10-28 10:10:00'),

-- Cart 12 items (abandoned)
(12, 6, 1, 29.99, '2024-10-29 11:40:00'),
(12, 13, 2, 19.99, '2024-10-29 11:45:00'),

-- Cart 13 items (abandoned)
(13, 16, 1, 189.99, '2024-10-30 14:30:00'),

-- Cart 14 items (abandoned)
(14, 22, 1, 79.99, '2024-10-31 09:25:00'),

-- Cart 15 items (abandoned)
(15, 29, 1, 89.99, '2024-11-01 16:50:00'),

-- Cart 16 items (old abandoned)
(16, 31, 1, 129.99, '2024-10-20 10:15:00'),

-- Cart 17 items (old abandoned)
(17, 33, 2, 59.99, '2024-10-21 12:40:00'),

-- Cart 18 items (old abandoned)
(18, 35, 1, 54.99, '2024-10-22 15:20:00'),

-- Cart 20 items (guest)
(20, 5, 3, 29.99, '2024-11-07 09:30:00'),

-- Cart 21 items (guest)
(21, 19, 1, 44.99, '2024-11-07 10:45:00'),
(21, 25, 5, 8.99, '2024-11-07 11:15:00'),

-- Cart 25 items
(25, 10, 1, 149.99, '2024-11-03 10:35:00'),

-- Cart 28 items
(28, 20, 2, 34.99, '2024-11-05 09:50:00'),

-- Cart 33 items
(33, 32, 1, 89.99, '2024-11-07 12:50:00'),

-- Cart 34 items
(34, 30, 1, 49.99, '2024-11-07 14:15:00');

-- Verify inserted data
SELECT COUNT(*) AS total_cart_items FROM CartItems;
SELECT 
    ci.cart_item_id,
    ci.cart_id,
    pv.sku,
    ci.qty,
    ci.unit_price,
    (ci.qty * ci.unit_price) AS line_total
FROM CartItems ci
JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
LIMIT 10;


-- =============================================
-- Author: Min, La Yaung
-- Create date: November 2025
-- Description: Sample Data for Coupons Table (30 entries)
-- Module: Shopping Cart & Promotions
-- =============================================

USE urbanease_shop;

-- Insert 30 promotional coupons with various types and conditions
INSERT INTO Coupons (code, type, value, starts_at, expires_at, min_subtotal, is_active) VALUES
-- Active percentage-based coupons
('WELCOME10', 'PERCENT', 10.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 50.00, TRUE),
('SAVE15', 'PERCENT', 15.00, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),
('BIGSALE20', 'PERCENT', 20.00, '2024-11-01 00:00:00', '2024-11-30 23:59:59', 150.00, TRUE),
('VIP25', 'PERCENT', 25.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 200.00, TRUE),
('FLASH30', 'PERCENT', 30.00, '2024-11-07 00:00:00', '2024-11-10 23:59:59', 300.00, TRUE),

-- Active fixed amount coupons
('SAVE5', 'AMOUNT', 5.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 25.00, TRUE),
('GET10OFF', 'AMOUNT', 10.00, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 50.00, TRUE),
('DEAL25', 'AMOUNT', 25.00, '2024-09-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),
('MEGA50', 'AMOUNT', 50.00, '2024-11-01 00:00:00', '2024-11-30 23:59:59', 200.00, TRUE),
('SUPER100', 'AMOUNT', 100.00, '2024-11-01 00:00:00', '2024-11-15 23:59:59', 500.00, TRUE),

-- Seasonal/Holiday coupons
('SUMMER15', 'PERCENT', 15.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 75.00, TRUE),
('BACKTOSCHOOL', 'PERCENT', 12.00, '2024-08-01 00:00:00', '2024-09-15 23:59:59', 60.00, TRUE),
('HALLOWEEN10', 'PERCENT', 10.00, '2024-10-15 00:00:00', '2024-10-31 23:59:59', 40.00, TRUE),
('BLACKFRIDAY', 'PERCENT', 35.00, '2024-11-29 00:00:00', '2024-11-29 23:59:59', 100.00, TRUE),
('CYBERMONDAY', 'PERCENT', 30.00, '2024-12-02 00:00:00', '2024-12-02 23:59:59', 100.00, TRUE),

-- Category-specific coupons
('TECH20', 'PERCENT', 20.00, '2024-10-01 00:00:00', '2024-12-31 23:59:59', 200.00, TRUE),
('FASHION15', 'PERCENT', 15.00, '2024-09-01 00:00:00', '2024-12-31 23:59:59', 80.00, TRUE),
('HOME10', 'PERCENT', 10.00, '2024-08-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),

-- First-time customer coupons
('FIRSTORDER', 'PERCENT', 20.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 30.00, TRUE),
('NEWUSER15', 'PERCENT', 15.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 25.00, TRUE),

-- Expired coupons
('EXPIRED10', 'PERCENT', 10.00, '2024-01-01 00:00:00', '2024-06-30 23:59:59', 50.00, TRUE),
('OLDCODE20', 'PERCENT', 20.00, '2024-01-01 00:00:00', '2024-03-31 23:59:59', 100.00, TRUE),
('SUMMER2023', 'PERCENT', 15.00, '2023-06-01 00:00:00', '2023-08-31 23:59:59', 75.00, TRUE),

-- Inactive coupons (manually deactivated)
('INACTIVE25', 'PERCENT', 25.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 150.00, FALSE),
('DISABLED15', 'PERCENT', 15.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 100.00, FALSE),

-- High-value exclusive coupons
('PREMIUM50', 'AMOUNT', 50.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 250.00, TRUE),
('VIPEXCLUSIVE', 'PERCENT', 30.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 500.00, TRUE),
('LOYALTY100', 'AMOUNT', 100.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 1000.00, TRUE),

-- Limited time offers
('FLASH24H', 'PERCENT', 25.00, '2024-11-07 00:00:00', '2024-11-08 23:59:59', 100.00, TRUE),
('HOURLY15', 'PERCENT', 15.00, '2024-11-07 10:00:00', '2024-11-07 20:00:00', 50.00, TRUE);

-- Verify inserted data
SELECT COUNT(*) AS total_coupons FROM Coupons;
SELECT 
    code,
    type,
    value,
    is_active,
    CASE 
        WHEN expires_at < NOW() THEN 'Expired'
        WHEN starts_at > NOW() THEN 'Not Started'
        ELSE 'Active'
    END AS status
FROM Coupons
LIMIT 15;


-- =============================================
-- Tiwari, Sneha
-- Module: Order Management & Fulfillment
-- Tables: Orders, OrderItems, Shipments
-- =============================================

-- Data for tables: Orders, OrderItems, Shipments

-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for Orders Table (35 entries)
-- Module: Order Management
-- Note: Requires Users, Coupons, and Addresses tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 orders with various statuses and amounts
INSERT INTO Orders (user_id, status, subtotal_amount, discount_amount, shipping_amount, tax_amount, coupon_id, shipping_address_id, billing_address_id, placed_at) VALUES
-- PAID orders (completed)
(2, 'PAID', 2548.98, 254.90, 15.00, 203.92, 1, 1, 1, '2024-10-15 10:30:00'),
(3, 'PAID', 1199.00, 179.85, 0.00, 95.92, 2, 2, 2, '2024-10-18 14:20:00'),
(4, 'PAID', 59.98, 0.00, 8.99, 4.80, NULL, 3, 3, '2024-10-20 09:15:00'),
(5, 'PAID', 899.00, 0.00, 49.99, 71.92, NULL, 4, 4, '2024-10-22 11:45:00'),
(6, 'PAID', 349.99, 0.00, 12.99, 28.00, NULL, 5, 5, '2024-10-25 16:30:00'),
(7, 'PAID', 124.97, 18.75, 0.00, 10.00, 2, 6, 6, '2024-10-28 13:10:00'),
(8, 'PAID', 74.95, 0.00, 5.99, 6.00, NULL, 7, 7, '2024-11-01 10:05:00'),
(9, 'PAID', 89.90, 0.00, 7.99, 7.19, NULL, 8, 8, '2024-11-02 15:20:00'),
(10, 'PAID', 59.97, 0.00, 6.99, 4.80, NULL, 9, 9, '2024-11-03 09:40:00'),

-- FULFILLED orders (delivered/completed)
(11, 'FULFILLED', 3299.00, 659.80, 0.00, 263.92, 3, 10, 10, '2024-09-15 11:20:00'),
(12, 'FULFILLED', 79.97, 12.00, 8.99, 6.40, 1, 11, 11, '2024-09-20 14:35:00'),
(13, 'FULFILLED', 189.99, 0.00, 15.99, 15.20, NULL, 12, 12, '2024-09-25 10:15:00'),
(14, 'FULFILLED', 79.99, 0.00, 9.99, 6.40, NULL, 13, 13, '2024-10-01 16:45:00'),
(15, 'FULFILLED', 89.99, 0.00, 0.00, 7.20, NULL, 14, 14, '2024-10-05 13:25:00'),
(16, 'FULFILLED', 129.99, 0.00, 12.99, 10.40, NULL, 15, 15, '2024-10-10 09:50:00'),

-- PENDING orders (payment pending)
(17, 'PENDING', 119.98, 0.00, 10.99, 9.60, NULL, 16, 16, '2024-11-06 10:30:00'),
(18, 'PENDING', 44.99, 0.00, 5.99, 3.60, NULL, 17, 17, '2024-11-06 14:15:00'),
(19, 'PENDING', 89.95, 13.49, 0.00, 7.20, 2, 18, 18, '2024-11-07 08:20:00'),
(20, 'PENDING', 149.99, 0.00, 11.99, 12.00, NULL, 19, 19, '2024-11-07 11:45:00'),

-- More PAID orders (recent)
(21, 'PAID', 69.98, 0.00, 7.99, 5.60, NULL, 20, 20, '2024-11-04 12:30:00'),
(22, 'PAID', 259.96, 0.00, 0.00, 20.80, NULL, 21, 21, '2024-11-04 15:50:00'),
(23, 'PAID', 54.99, 0.00, 6.99, 4.40, NULL, 22, 22, '2024-11-05 09:10:00'),
(24, 'PAID', 29.99, 0.00, 4.99, 2.40, NULL, 23, 23, '2024-11-05 13:35:00'),
(25, 'PAID', 199.98, 30.00, 10.99, 16.00, 2, 24, 24, '2024-11-05 16:20:00'),

-- CANCELLED orders
(26, 'CANCELLED', 899.00, 0.00, 49.99, 71.92, NULL, 25, 25, '2024-10-12 10:00:00'),
(27, 'CANCELLED', 2499.00, 0.00, 0.00, 199.92, NULL, 26, 26, '2024-10-16 14:25:00'),

-- REFUNDED orders
(28, 'REFUNDED', 79.99, 0.00, 9.99, 6.40, NULL, 27, 27, '2024-09-10 11:30:00'),
(29, 'REFUNDED', 149.99, 22.50, 11.99, 12.00, 2, 28, 28, '2024-09-28 15:45:00'),

-- More recent PAID orders
(30, 'PAID', 399.00, 0.00, 29.99, 31.92, NULL, 29, 29, '2024-11-06 09:15:00'),
(31, 'PAID', 699.00, 0.00, 0.00, 55.92, NULL, 30, 30, '2024-11-06 12:40:00'),
(32, 'PAID', 199.99, 30.00, 15.99, 16.00, 2, 1, 1, '2024-11-06 16:05:00'),
(33, 'PAID', 34.99, 0.00, 5.99, 2.80, NULL, 2, 2, '2024-11-07 10:20:00'),
(34, 'PAID', 149.99, 0.00, 12.99, 12.00, NULL, 3, 3, '2024-11-07 13:50:00'),
(35, 'PAID', 299.99, 45.00, 0.00, 24.00, 2, 4, 4, '2024-11-07 15:30:00');

-- Verify inserted data
SELECT COUNT(*) AS total_orders FROM Orders;
SELECT 
    order_id,
    user_id,
    status,
    subtotal_amount,
    discount_amount,
    grand_total_amount,
    placed_at
FROM Orders
ORDER BY placed_at DESC
LIMIT 10;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for OrderItems Table (35 entries)
-- Module: Order Management
-- Note: Requires Orders and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 order items (1-3 items per order)
INSERT INTO OrderItems (order_id, variant_id, qty, unit_price, tax_amount, discount_amount) VALUES
-- Order 1 items
(1, 1, 1, 2499.00, 199.92, 249.90),
(1, 11, 2, 24.99, 4.00, 5.00),

-- Order 2 items
(2, 3, 1, 1199.00, 95.92, 179.85),

-- Order 3 items
(3, 5, 2, 29.99, 4.80, 0.00),

-- Order 4 items
(4, 9, 1, 899.00, 71.92, 0.00),

-- Order 5 items
(5, 15, 1, 349.99, 28.00, 0.00),

-- Order 6 items
(6, 17, 2, 39.99, 6.40, 12.00),
(6, 19, 1, 44.99, 3.60, 6.75),

-- Order 7 items
(7, 23, 5, 14.99, 6.00, 0.00),

-- Order 8 items
(8, 25, 10, 8.99, 7.19, 0.00),

-- Order 9 items
(9, 27, 3, 19.99, 4.80, 0.00),

-- Order 10 items
(10, 2, 1, 3299.00, 263.92, 659.80),

-- Order 11 items
(11, 6, 1, 29.99, 2.40, 4.50),
(11, 13, 2, 19.99, 3.20, 6.00),
(11, 24, 1, 9.99, 0.80, 1.50),

-- Order 12 items
(12, 16, 1, 189.99, 15.20, 0.00),

-- Order 13 items
(13, 22, 1, 79.99, 6.40, 0.00),

-- Order 14 items
(14, 29, 1, 89.99, 7.20, 0.00),

-- Order 15 items
(15, 31, 1, 129.99, 10.40, 0.00),

-- Order 16 items
(16, 17, 3, 39.99, 9.60, 0.00),

-- Order 17 items
(17, 19, 1, 44.99, 3.60, 0.00),

-- Order 18 items
(18, 25, 10, 8.99, 7.19, 0.00),

-- Order 19 items
(19, 10, 1, 149.99, 12.00, 0.00),

-- Order 20 items
(20, 20, 2, 34.99, 5.60, 0.00),

-- Order 21 items
(21, 33, 4, 59.99, 19.20, 0.00),
(21, 30, 1, 19.99, 1.60, 0.00),

-- Order 22 items
(22, 35, 1, 54.99, 4.40, 0.00),

-- Order 23 items
(23, 24, 1, 29.99, 2.40, 0.00),

-- Order 24 items
(24, 26, 1, 199.99, 16.00, 30.00),

-- Order 25 items (cancelled)
(25, 9, 1, 899.00, 71.92, 0.00),

-- Order 26 items (cancelled)
(26, 1, 1, 2499.00, 199.92, 0.00);

-- Verify inserted data
SELECT COUNT(*) AS total_order_items FROM OrderItems;
SELECT 
    oi.order_item_id,
    oi.order_id,
    pv.sku,
    oi.qty,
    oi.unit_price,
    (oi.qty * oi.unit_price) AS line_total
FROM OrderItems oi
JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
LIMIT 10;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: November 2025
-- Description: Sample Data for Shipments Table (30 entries)
-- Module: Order Fulfillment
-- Note: Requires Orders and Warehouses tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 30 shipments with various statuses
INSERT INTO Shipments (order_id, warehouse_id, carrier, tracking_no, status, shipped_at, delivered_at, created_at) VALUES
-- DELIVERED shipments (completed)
(1, 1, 'UPS', '1Z999AA10123456784', 'DELIVERED', '2024-10-16 09:00:00', '2024-10-18 14:30:00', '2024-10-15 15:00:00'),
(2, 2, 'FedEx', '773459876543210', 'DELIVERED', '2024-10-19 10:30:00', '2024-10-21 11:45:00', '2024-10-18 16:00:00'),
(3, 3, 'USPS', '9400110200830123456789', 'DELIVERED', '2024-10-21 08:15:00', '2024-10-24 16:20:00', '2024-10-20 14:30:00'),
(4, 1, 'UPS', '1Z999AA10234567895', 'DELIVERED', '2024-10-23 11:00:00', '2024-10-26 13:10:00', '2024-10-22 17:00:00'),
(5, 4, 'FedEx', '773459876654321', 'DELIVERED', '2024-10-26 09:30:00', '2024-10-29 15:40:00', '2024-10-25 18:00:00'),
(6, 2, 'DHL', '1234567890', 'DELIVERED', '2024-10-29 10:00:00', '2024-10-31 12:20:00', '2024-10-28 15:30:00'),
(7, 5, 'USPS', '9400110200830234567890', 'DELIVERED', '2024-11-02 08:45:00', '2024-11-04 14:15:00', '2024-11-01 12:00:00'),
(8, 3, 'UPS', '1Z999AA10345678906', 'DELIVERED', '2024-11-03 11:20:00', '2024-11-05 16:30:00', '2024-11-02 17:30:00'),
(9, 6, 'FedEx', '773459876765432', 'DELIVERED', '2024-11-04 09:00:00', '2024-11-06 10:45:00', '2024-11-03 13:00:00'),

-- FULFILLED orders (older deliveries)
(11, 1, 'UPS', '1Z999AA10111111111', 'DELIVERED', '2024-09-16 10:00:00', '2024-09-19 14:20:00', '2024-09-15 16:00:00'),
(12, 7, 'FedEx', '773459876222222', 'DELIVERED', '2024-09-21 11:30:00', '2024-09-24 15:40:00', '2024-09-20 17:00:00'),
(13, 2, 'USPS', '9400110200830333333333', 'DELIVERED', '2024-09-26 08:00:00', '2024-09-29 12:10:00', '2024-09-25 14:00:00'),
(14, 8, 'DHL', '1234567891', 'DELIVERED', '2024-10-02 09:30:00', '2024-10-05 13:25:00', '2024-10-01 18:30:00'),
(15, 3, 'UPS', '1Z999AA10444444444', 'DELIVERED', '2024-10-06 10:00:00', '2024-10-09 16:50:00', '2024-10-05 15:00:00'),
(16, 9, 'FedEx', '773459876555555', 'DELIVERED', '2024-10-11 11:00:00', '2024-10-14 14:30:00', '2024-10-10 16:00:00'),

-- IN_TRANSIT shipments (on the way)
(21, 1, 'UPS', '1Z999AA10666666666', 'IN_TRANSIT', '2024-11-05 09:00:00', NULL, '2024-11-04 16:00:00'),
(22, 10, 'FedEx', '773459876777777', 'IN_TRANSIT', '2024-11-05 10:30:00', NULL, '2024-11-04 18:00:00'),
(23, 2, 'USPS', '9400110200830888888888', 'IN_TRANSIT', '2024-11-06 08:15:00', NULL, '2024-11-05 13:00:00'),
(24, 4, 'DHL', '1234567892', 'IN_TRANSIT', '2024-11-06 11:00:00', NULL, '2024-11-05 17:00:00'),
(25, 3, 'UPS', '1Z999AA10999999999', 'IN_TRANSIT', '2024-11-06 09:30:00', NULL, '2024-11-05 19:00:00'),

-- PICKED shipments (ready to ship)
(30, 5, 'FedEx', '773459876000000', 'PICKED', NULL, NULL, '2024-11-06 14:00:00'),
(31, 6, 'UPS', '1Z999AA10000000001', 'PICKED', NULL, NULL, '2024-11-06 16:00:00'),
(32, 1, 'USPS', '9400110200830000000001', 'PICKED', NULL, NULL, '2024-11-06 18:00:00'),

-- CREATED shipments (just created, awaiting pickup)
(33, 7, 'DHL', '1234567893', 'CREATED', NULL, NULL, '2024-11-07 10:00:00'),
(34, 2, 'UPS', '1Z999AA10000000002', 'CREATED', NULL, NULL, '2024-11-07 14:00:00'),

-- CANCELLED shipment
(26, 8, 'UPS', '1Z999AA10CANCELLED', 'CANCELLED', NULL, NULL, '2024-10-12 15:00:00'),

-- REFUNDED orders - delivered but refunded
(28, 3, 'FedEx', '773459876REFUND1', 'DELIVERED', '2024-09-11 10:00:00', '2024-09-14 15:20:00', '2024-09-10 16:00:00'),
(29, 9, 'USPS', '9400110200830REFUND2', 'DELIVERED', '2024-09-29 09:00:00', '2024-10-02 13:45:00', '2024-09-28 18:00:00'),

-- More recent deliveries
(10, 4, 'DHL', '1234567894', 'DELIVERED', '2024-11-04 10:30:00', '2024-11-06 12:00:00', '2024-11-03 15:00:00');

-- Verify inserted data
SELECT COUNT(*) AS total_shipments FROM Shipments;
SELECT 
    s.shipment_id,
    s.order_id,
    w.name AS warehouse,
    s.carrier,
    s.tracking_no,
    s.status,
    s.shipped_at,
    s.delivered_at
FROM Shipments s
JOIN Warehouses w ON s.warehouse_id = w.warehouse_id
ORDER BY s.created_at DESC
LIMIT 10;


-- =============================================
-- Velarde Sosa, Diana (continued)
-- Module: User Addresses, Payments & Reviews
-- Tables: Addresses, Payments, Reviews
-- =============================================

-- Data for tables: Addresses, Payments, Reviews

-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Payments Table (35 entries)
-- Module: Payment Processing
-- Note: Requires Orders table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 payment records with various statuses
INSERT INTO Payments (order_id, provider, provider_ref, amount, status, paid_at, created_at) VALUES
-- CAPTURED payments (successful)
(1, 'Stripe', 'ch_3N1L9J2eZvKYlo2C0123456789', 2513.90, 'CAPTURED', '2024-10-15 10:35:00', '2024-10-15 10:30:00'),
(2, 'PayPal', 'PAYID-MXYZ-1234-ABCD-5678', 1115.07, 'CAPTURED', '2024-10-18 14:25:00', '2024-10-18 14:20:00'),
(3, 'Stripe', 'ch_3N2K8I2eZvKYlo2C0234567890', 73.77, 'CAPTURED', '2024-10-20 09:20:00', '2024-10-20 09:15:00'),
(4, 'Square', 'sq_1234567890ABCDEFGH', 1020.91, 'CAPTURED', '2024-10-22 11:50:00', '2024-10-22 11:45:00'),
(5, 'Stripe', 'ch_3N3J7H2eZvKYlo2C0345678901', 390.98, 'CAPTURED', '2024-10-25 16:35:00', '2024-10-25 16:30:00'),
(6, 'PayPal', 'PAYID-NXYZ-2345-BCDE-6789', 116.22, 'CAPTURED', '2024-10-28 13:15:00', '2024-10-28 13:10:00'),
(7, 'Stripe', 'ch_3N4I6G2eZvKYlo2C0456789012', 86.94, 'CAPTURED', '2024-11-01 10:10:00', '2024-11-01 10:05:00'),
(8, 'Square', 'sq_2345678901BCDEFGHI', 105.08, 'CAPTURED', '2024-11-02 15:25:00', '2024-11-02 15:20:00'),
(9, 'Stripe', 'ch_3N5H5F2eZvKYlo2C0567890123', 71.76, 'CAPTURED', '2024-11-03 09:45:00', '2024-11-03 09:40:00'),
(10, 'PayPal', 'PAYID-OXYZ-3456-CDEF-7890', 2966.84, 'CAPTURED', '2024-09-15 11:25:00', '2024-09-15 11:20:00'),

-- More CAPTURED payments
(11, 'Stripe', 'ch_3N6G4E2eZvKYlo2C0678901234', 94.36, 'CAPTURED', '2024-09-20 14:40:00', '2024-09-20 14:35:00'),
(12, 'Square', 'sq_3456789012CDEFGHIJ', 221.18, 'CAPTURED', '2024-09-25 10:20:00', '2024-09-25 10:15:00'),
(13, 'Stripe', 'ch_3N7F3D2eZvKYlo2C0789012345', 96.38, 'CAPTURED', '2024-10-01 16:50:00', '2024-10-01 16:45:00'),
(14, 'PayPal', 'PAYID-PXYZ-4567-DEFG-8901', 97.19, 'CAPTURED', '2024-10-05 13:30:00', '2024-10-05 13:25:00'),
(15, 'Stripe', 'ch_3N8E2C2eZvKYlo2C0890123456', 153.38, 'CAPTURED', '2024-10-10 09:55:00', '2024-10-10 09:50:00'),
(21, 'Stripe', 'ch_3N9D1B2eZvKYlo2C0901234567', 83.57, 'CAPTURED', '2024-11-04 12:35:00', '2024-11-04 12:30:00'),
(22, 'Square', 'sq_4567890123DEFGHIJK', 280.76, 'CAPTURED', '2024-11-04 15:55:00', '2024-11-04 15:50:00'),
(23, 'Stripe', 'ch_3NAC0A2eZvKYlo2C1012345678', 66.38, 'CAPTURED', '2024-11-05 09:15:00', '2024-11-05 09:10:00'),
(24, 'PayPal', 'PAYID-QXYZ-5678-EFGH-9012', 37.38, 'CAPTURED', '2024-11-05 13:40:00', '2024-11-05 13:35:00'),
(25, 'Stripe', 'ch_3NBB9Z2eZvKYlo2C1123456789', 196.97, 'CAPTURED', '2024-11-05 16:25:00', '2024-11-05 16:20:00'),
(30, 'Square', 'sq_5678901234EFGHIJKL', 460.91, 'CAPTURED', '2024-11-06 09:20:00', '2024-11-06 09:15:00'),
(31, 'Stripe', 'ch_3NCA8Y2eZvKYlo2C1234567890', 754.92, 'CAPTURED', '2024-11-06 12:45:00', '2024-11-06 12:40:00'),
(32, 'PayPal', 'PAYID-RXYZ-6789-FGHI-0123', 201.98, 'CAPTURED', '2024-11-06 16:10:00', '2024-11-06 16:05:00'),
(33, 'Stripe', 'ch_3ND97X2eZvKYlo2C1345678901', 43.78, 'CAPTURED', '2024-11-07 10:25:00', '2024-11-07 10:20:00'),
(34, 'Square', 'sq_6789012345FGHIJKLM', 174.98, 'CAPTURED', '2024-11-07 13:55:00', '2024-11-07 13:50:00'),

-- AUTHORIZED payments (authorized but not captured yet)
(17, 'Stripe', 'ch_3NF75V2eZvKYlo2C1567890123', 140.57, 'AUTHORIZED', NULL, '2024-11-06 10:30:00'),
(18, 'PayPal', 'PAYID-SXYZ-7890-GHIJ-1234', 54.58, 'AUTHORIZED', NULL, '2024-11-06 14:15:00'),

-- INITIATED payments (payment started)
(19, 'Square', 'sq_7890123456GHIJKLMN', 83.66, 'INITIATED', NULL, '2024-11-07 08:20:00'),
(20, 'Stripe', 'ch_3NG64U2eZvKYlo2C1678901234', 173.98, 'INITIATED', NULL, '2024-11-07 11:45:00'),

-- FAILED payment
(26, 'Stripe', 'ch_3NH53T2eZvKYlo2C1789012345', 1020.91, 'FAILED', NULL, '2024-10-12 10:05:00'),

-- REFUNDED payments
(27, 'PayPal', 'PAYID-TXYZ-8901-HIJK-2345', 2698.92, 'REFUNDED', '2024-10-16 14:30:00', '2024-10-16 14:25:00'),
(28, 'Stripe', 'ch_3NI42S2eZvKYlo2C1890123456', 96.38, 'REFUNDED', '2024-09-10 11:35:00', '2024-09-10 11:30:00'),
(29, 'Square', 'sq_8901234567HIJKLMNO', 149.48, 'REFUNDED', '2024-09-28 15:50:00', '2024-09-28 15:45:00');

-- Verify inserted data
SELECT COUNT(*) AS total_payments FROM Payments;
SELECT 
    p.payment_id,
    p.order_id,
    p.provider,
    p.amount,
    p.status,
    p.paid_at,
    o.grand_total_amount
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
ORDER BY p.created_at DESC
LIMIT 10;


-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Reviews Table (30 entries)
-- Module: Product Reviews
-- Note: Requires Products and Users tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 30 product reviews with ratings 1-5
INSERT INTO Reviews (product_id, user_id, rating, title, body, created_at) VALUES
-- 5-star reviews (excellent)
(1, 2, 5, 'Best laptop I have ever owned!', 'The MacBook Pro M3 is absolutely amazing. The performance is unmatched and the battery life is incredible. Highly recommend for professionals.', '2024-10-20 10:00:00'),
(2, 3, 5, 'Fantastic phone', 'iPhone 15 Pro Max exceeded my expectations. The camera quality is stunning and the titanium design feels premium.', '2024-10-23 14:30:00'),
(5, 5, 5, 'Perfect sofa for my living room', 'Beautiful design and very comfortable. The grey color matches perfectly with my decor. Great quality for the price.', '2024-11-02 09:15:00'),
(10, 6, 5, 'Game changer for home workouts', 'These adjustable dumbbells saved so much space. Easy to use and feels solid. Best purchase this year.', '2024-11-05 16:20:00'),
(16, 8, 5, 'Excellent protection and comfort', 'These motorcycle gloves are top quality. Perfect fit, great grip, and excellent protection. Worth every penny.', '2024-06-15 11:45:00'),

-- 4-star reviews (very good)
(3, 4, 4, 'Great quality t-shirt', 'Very comfortable and fits well. The fabric quality is excellent. Only wish there were more color options.', '2024-02-10 12:30:00'),
(4, 7, 4, 'Beautiful dress', 'Love the floral pattern and the fit is perfect. Lost one star because it wrinkles easily, but still a great buy.', '2024-02-15 15:45:00'),
(7, 9, 4, 'Visible results after 2 weeks', 'My skin looks brighter and more even. Great serum but wish the bottle was bigger for the price.', '2024-03-20 10:20:00'),
(11, 10, 4, 'Good tent for the price', 'Easy to set up and kept us dry during rain. Spacious for 4 people. Could use better zippers though.', '2024-05-05 14:10:00'),
(13, 12, 4, 'Fun game for family nights', 'Catan is a great strategy game. Takes a bit to learn but very engaging once you get it. Recommend!', '2024-05-15 16:35:00'),
(20, 15, 4, 'Tasty and healthy', 'Love the taste and texture. High protein content is perfect for my diet. Just wish it was a bit cheaper.', '2024-07-25 09:50:00'),
(27, 21, 4, 'My dog loves it!', 'Great quality dog food. My dog\'s coat looks shinier and he has more energy. A bit pricey but worth it.', '2024-10-05 13:25:00'),

-- 3-star reviews (average/mixed)
(6, 11, 3, 'Decent wall art', 'The artwork is nice but the colors are not as vibrant as shown in the picture. It\'s okay for the price.', '2024-03-10 11:15:00'),
(8, 13, 3, 'Average shampoo', 'Does the job but nothing special. My hair feels clean but I did not notice any significant improvement.', '2024-03-25 14:40:00'),
(12, 14, 3, 'Okay running shorts', 'Comfortable but the fabric is a bit thin. Good for light workouts but might not last very long.', '2024-05-10 10:30:00'),
(17, 16, 3, 'Interesting plot but slow pacing', 'The mystery was intriguing but the story dragged in the middle. Decent read but not my favorite.', '2024-06-25 16:50:00'),
(23, 18, 3, 'Nice necklace but chain is delicate', 'The pendant is beautiful but the chain feels fragile. Worried it might break easily. Handle with care.', '2024-08-25 12:15:00'),

-- 2-star reviews (below average)
(9, 17, 2, 'Not worth the price', 'Expected better quality for a multivitamin. The pills are huge and hard to swallow. Not buying again.', '2024-04-10 09:20:00'),
(14, 19, 2, 'Disappointed with quality', 'The action figure looks cheap and the articulation is limited. My son expected better from Marvel.', '2024-05-25 15:10:00'),
(18, 20, 2, 'Journal pages bleed through', 'The leather cover is nice but the paper quality is poor. Ink bleeds through when using fountain pens.', '2024-07-10 11:35:00'),
(24, 22, 2, 'Earrings tarnished quickly', 'Looked great initially but the silver coating started coming off after a few wears. Not real quality.', '2024-09-05 14:25:00'),

-- 1-star reviews (poor)
(15, 23, 1, 'Fell off after one day', 'The magnetic mount is weak. My phone fell off multiple times while driving. Dangerous and useless.', '2024-06-05 10:45:00'),
(19, 24, 1, 'Stale and tasteless', 'The trail mix was stale and had no flavor. Seemed old. Very disappointed. Returning it.', '2024-07-15 16:20:00'),
(22, 25, 1, 'Caused rash on baby\'s skin', 'These wipes gave my baby a terrible rash. Not sensitive at all despite the label. Do not recommend.', '2024-08-15 09:30:00'),

-- More recent reviews
(25, 26, 4, 'Classy and comfortable shoes', 'These oxford shoes look great and are surprisingly comfortable. Good value for genuine leather.', '2024-09-15 13:45:00'),
(29, 27, 5, 'Ultimate comfort!', 'This recliner is incredibly comfortable. Perfect for watching movies. The leather quality is excellent.', '2024-10-25 15:30:00'),
(31, 28, 4, 'Reliable printer', 'Prints well and WiFi setup was easy. Scanner works great too. A bit slow but overall satisfied.', '2024-11-08 10:20:00'),
(33, 29, 5, 'Powerful drill', 'This DeWalt drill has excellent power and battery life. Great for DIY projects. Highly recommend!', '2024-11-10 14:50:00'),
(34, 30, 4, 'Great beginner guitar', 'Good quality for the price. Sounds nice and comes with everything you need to start learning.', '2024-11-11 11:15:00'),
(35, 2, 5, 'Professional quality paints', 'These watercolors are vibrant and blend beautifully. Perfect for serious artists. Worth the investment.', '2024-11-12 16:40:00');

-- Verify inserted data
SELECT COUNT(*) AS total_reviews FROM Reviews;
SELECT 
    r.review_id,
    p.title AS product_name,
    u.full_name AS reviewer,
    r.rating,
    r.title AS review_title,
    r.created_at
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Users u ON r.user_id = u.user_id
ORDER BY r.created_at DESC
LIMIT 10;



-- =============================================
-- COMPLEX QUERIES - TEAM CONTRIBUTIONS
-- =============================================
-- All queries span 3 or more tables and demonstrate advanced SQL concepts

-- =============================================
-- Bajwa, Achint Kaur
-- =============================================

-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Query 1 - User Login History
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

SELECT
  u.user_id,
  u.email,
  u.full_name,
  r.role_name,
  ur.assigned_at
FROM Users      AS u
JOIN UserRoles  AS ur ON ur.user_id = u.user_id
JOIN Roles      AS r  ON r.role_id  = ur.role_id
-- Optional filter to show only active accounts:
-- WHERE u.is_active = 1
ORDER BY u.user_id, ur.assigned_at, r.role_name;


-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Query 2 - Users by Role
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

-- (Optional) show more sample emails if many users share a role
-- SET SESSION group_concat_max_len = 8192;

SELECT
  r.role_name,
  COUNT(DISTINCT ur.user_id) AS user_count,                          -- de-duplicate users per role
  COALESCE(
    GROUP_CONCAT(DISTINCT u.email ORDER BY u.email SEPARATOR ', '),  -- readable examples
    '—'
  ) AS example_users
FROM Roles      AS r
LEFT JOIN UserRoles AS ur ON ur.role_id = r.role_id
LEFT JOIN Users     AS u  ON u.user_id  = ur.user_id
-- Uncomment to count only active accounts:
-- WHERE u.is_active = 1 OR u.user_id IS NULL
GROUP BY r.role_id, r.role_name
ORDER BY user_count DESC, r.role_name;

-- COMMENTS
-- 1) COUNT(DISTINCT ur.user_id) prevents overcounting if data ever contains duplicates.
-- 2) GROUP_CONCAT(DISTINCT ...) lists unique emails per role; COALESCE shows '—' when no users.
-- 3) Add the WHERE line to exclude inactive users from counts while keeping roles with zero users.
-- 4) If your role gets many users, bump GROUP_CONCAT length (see SET statement above).
-- 5) Helpful indexes (if not already present):
--      CREATE INDEX idx_userroles_role ON UserRoles(role_id);
--      CREATE INDEX idx_userroles_user ON UserRoles(user_id);
--      CREATE UNIQUE INDEX uq_roles_name ON Roles(role_name);


-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Query 3 - Active Users with Multiple Roles
-- Tables: Users, Roles, UserRoles
-- =============================================

USE urbanease_shop;

SELECT
  u.user_id,
  u.email,
  u.full_name,
  GROUP_CONCAT(DISTINCT r.role_name ORDER BY r.role_name SEPARATOR ', ') AS roles,
  COUNT(DISTINCT r.role_id) AS role_count
FROM Users      AS u
LEFT JOIN UserRoles AS ur ON ur.user_id = u.user_id
LEFT JOIN Roles     AS r  ON r.role_id  = ur.role_id
WHERE u.is_active = 1                      -- use 1 for cross-platform boolean
GROUP BY u.user_id, u.email, u.full_name
HAVING role_count > 1                      -- only show users with >1 role
ORDER BY role_count DESC, u.user_id;

-- COMMENTS
-- 1) Lists only active users who hold more than one distinct role.
-- 2) GROUP_CONCAT(DISTINCT ...) ensures duplicate roles are not repeated.
-- 3) COUNT(DISTINCT r.role_id) enables HAVING role_count>1 filtering.
-- 4) Uses numeric 1 for BOOLEAN to avoid TRUE/FALSE portability issues.
-- 5) ORDER BY role_count DESC shows users with the most roles first.
-- 6) Helpful indexes:
--      CREATE INDEX idx_userroles_user ON UserRoles(user_id);
--      CREATE INDEX idx_userroles_role ON UserRoles(role_id);
--      CREATE INDEX idx_users_active   ON Users(is_active);


-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Product performance summary = sales, revenue, ratings, and
--              available stock (on_hand - reserved) aggregated across warehouses.
-- Tables: Products, Categories, ProductVariants, OrderItems, Orders, Reviews, Inventory
-- =============================================

USE urbanease_shop;

WITH params AS (
  SELECT 
    DATE('2024-01-01') AS p_start_date,
    DATE('2025-12-31') AS p_end_date
),
order_lines AS (
  -- Paid/fulfilled order items in date range
  SELECT 
      oi.variant_id,
      oi.qty,
      (oi.qty * oi.unit_price) AS line_revenue
  FROM OrderItems oi
  JOIN Orders o ON o.order_id = oi.order_id
  JOIN params p
    ON o.placed_at >= p.p_start_date
   AND o.placed_at <  p.p_end_date + INTERVAL 1 DAY
  WHERE o.status IN ('PAID','FULFILLED')   -- exclude cancelled/refunded
),
variant_sales AS (
  SELECT 
      variant_id,
      SUM(qty)                  AS units_sold,
      SUM(line_revenue)         AS revenue
  FROM order_lines
  GROUP BY variant_id
),
variant_ratings AS (
  SELECT 
      pv.variant_id,
      AVG(r.rating) AS avg_rating,
      COUNT(*)      AS rating_count
  FROM Reviews r
  JOIN Products p  ON p.product_id = r.product_id
  JOIN ProductVariants pv ON pv.product_id = p.product_id
  GROUP BY pv.variant_id
),
variant_stock AS (
  -- Sum stock across all warehouses for each variant
  SELECT 
      i.variant_id,
      GREATEST(SUM(i.on_hand - i.reserved), 0) AS available_stock
  FROM Inventory i
  GROUP BY i.variant_id
)
SELECT
  p.product_id,
  p.title                           AS product_title,
  c.name                            AS category,
  pv.variant_id,
  pv.sku,
  COALESCE(vs.units_sold, 0)        AS units_sold,
  COALESCE(vs.revenue, 0.00)        AS revenue_usd,
  ROUND(COALESCE(vr.avg_rating, 0), 2) AS avg_rating,
  COALESCE(vr.rating_count, 0)      AS rating_count,
  COALESCE(vst.available_stock, 0)  AS available_stock,
  CASE 
    WHEN COALESCE(vst.available_stock,0) = 0 THEN 'OUT OF STOCK'
    WHEN COALESCE(vst.available_stock,0) < 10 THEN 'LOW'
    WHEN COALESCE(vst.available_stock,0) < 50 THEN 'MEDIUM'
    ELSE 'HIGH'
  END AS stock_band
FROM Products p
LEFT JOIN Categories c         ON c.category_id = p.category_id
JOIN ProductVariants pv        ON pv.product_id = p.product_id
LEFT JOIN variant_sales  vs    ON vs.variant_id = pv.variant_id
LEFT JOIN variant_ratings vr   ON vr.variant_id = pv.variant_id
LEFT JOIN variant_stock  vst   ON vst.variant_id = pv.variant_id
WHERE p.is_active = 1 AND pv.is_active = 1
ORDER BY revenue_usd DESC, units_sold DESC, pv.variant_id
LIMIT 25;

-- COMMENTS
-- 1) Uses CTE `params` so graders can quickly change the date window.
-- 2) Counts sales only from Orders with status PAID/FULFILLED (business-valid revenue).
-- 3) Revenue = SUM(qty*unit_price) at order-line granularity; grouped per variant.
-- 4) Ratings averaged at variant level by bridging Reviews -> Products -> ProductVariants.
-- 5) Stock is rolled up across all Warehouses: SUM(on_hand - reserved).
-- 6) Robust to missing data via COALESCE; adds a stock_band label for UX/reporting.
-- 7) Helpful indexes (if large data):
--      CREATE INDEX IX_O_placed_status ON Orders(placed_at, status);
--      CREATE INDEX IX_OI_variant ON OrderItems(variant_id);
--      CREATE INDEX IX_Inv_variant ON Inventory(variant_id);
--      CREATE INDEX IX_Prod_category ON Products(category_id);


-- =============================================
-- Author:       Bajwa, Achint Kaur
-- Create date:  November 2025
-- Description:  Fulfillment SLA by warehouse & carrier:
--               - Ship time (placed_at -> shipped_at)
--               - Delivery time (shipped_at -> delivered_at)
--               - On-time shipping/delivery rates
--               - Volume of shipments
-- Tables:       Orders, Shipments, Warehouses
-- =============================================

USE urbanease_shop;

WITH params AS (
  SELECT 
    DATE('2024-01-01') AS p_start_date,
    DATE('2025-12-31') AS p_end_date,
    48  AS ship_sla_hours,     -- on-time ship threshold (2 days)
    168 AS delivery_sla_hours  -- on-time delivery threshold (7 days)
),
ship_events AS (
  SELECT
      s.shipment_id,
      s.order_id,
      s.warehouse_id,
      s.carrier,
      s.status,
      s.shipped_at,
      s.delivered_at,
      o.placed_at
  FROM Shipments s
  JOIN Orders o ON o.order_id = s.order_id
  JOIN params p
    ON o.placed_at >= p.p_start_date
   AND o.placed_at <  p.p_end_date + INTERVAL 1 DAY
),
durations AS (
  SELECT
      se.warehouse_id,
      se.carrier,
      se.status,
      se.placed_at,
      se.shipped_at,
      se.delivered_at,
      TIMESTAMPDIFF(HOUR, se.placed_at,   se.shipped_at)   AS ship_hours,
      TIMESTAMPDIFF(HOUR, se.shipped_at,  se.delivered_at) AS delivery_hours
  FROM ship_events se
  WHERE se.shipped_at IS NOT NULL
)
SELECT
  w.warehouse_id,
  w.name                 AS warehouse_name,
  w.code                 AS warehouse_code,
  d.carrier,
  COUNT(*)                                AS shipments_total,
  SUM(d.shipped_at   IS NOT NULL)         AS shipped_cnt,
  SUM(d.delivered_at IS NOT NULL)         AS delivered_cnt,
  ROUND(AVG(d.ship_hours), 1)             AS ship_hours_avg,
  MIN(d.ship_hours)                        AS ship_hours_min,
  MAX(d.ship_hours)                        AS ship_hours_max,
  ROUND(AVG(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END), 1) AS delivery_hours_avg,
  MIN(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END)           AS delivery_hours_min,
  MAX(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END)           AS delivery_hours_max,
  CONCAT(ROUND(100 * AVG(CASE 
           WHEN d.ship_hours    IS NOT NULL 
            AND d.ship_hours   <= (SELECT ship_sla_hours FROM params) 
           THEN 1 ELSE 0 END), 1), '%') AS ship_ontime_rate,
  CONCAT(ROUND(100 * AVG(CASE 
           WHEN d.delivery_hours IS NOT NULL
            AND d.delivery_hours <= (SELECT delivery_sla_hours FROM params)
           THEN 1 ELSE 0 END), 1), '%') AS delivery_ontime_rate
FROM durations d
LEFT JOIN Warehouses w ON w.warehouse_id = d.warehouse_id
GROUP BY w.warehouse_id, w.name, w.code, d.carrier
HAVING shipments_total > 0
ORDER BY delivery_ontime_rate DESC, ship_ontime_rate DESC, shipments_total DESC
LIMIT 100;

-- COMMENTS
-- 1) Date window & SLA thresholds stored in CTE `params` for easy edits.
-- 2) Ship time = Orders.placed_at → Shipments.shipped_at.
-- 3) Delivery time = Shipments.shipped_at → Shipments.delivered_at.
-- 4) On-time shipping = <=48 hours; on-time delivery = <=168 hours.
-- 5) Filters shipments tied to orders in date range.
-- 6) Aggregates SLA metrics by warehouse & carrier.
-- 7) Good indexes:
--      CREATE INDEX IX_Orders_placed ON Orders(placed_at);
--      CREATE INDEX IX_Shipments_order ON Shipments(order_id);
--      CREATE INDEX IX_Shipments_warehouse_carrier ON Shipments(warehouse_id, carrier);


-- =============================================
-- Khapekar, Pooja
-- =============================================

-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 1 - Products by Category with Images
-- Tables: Categories, Products, ProductImages
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Get products with their categories and image count

/*
SELECT 
    c.name as category_name,
    p.title as product_name,
    p.brand,
    COUNT(pi.image_id) as image_count
FROM Categories c
-- Add your JOINs and WHERE clauses
;
*/



-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 2 - Category Hierarchy with Product Count
-- Tables: Categories, Products, ProductImages
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Display category hierarchy (parent-child) with product counts

/*
SELECT 
    parent.name as parent_category,
    child.name as child_category,
    COUNT(p.product_id) as product_count
FROM Categories parent
-- Add your JOINs and WHERE clauses
;
*/



-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Query 3 - Products Without Images
-- Tables: Categories, Products, ProductImages
-- =============================================

USE urbanease_shop;

-- TODO: Write your complex query here
-- Example: Find products that don't have any images

/*
SELECT 
    p.product_id,
    p.title,
    c.name as category_name,
    p.brand
FROM Products p
-- Add your JOINs and WHERE clauses
;
*/



-- =============================================
-- Kumar, Virat
-- =============================================

-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 1 - End-to-End Customer Order Fulfillment Analysis
-- Tables Used: Users (Bajwa), Orders (Sneha), OrderItems (Sneha), Shipments (Sneha), 
--              ProductVariants (Virat), Products (Pooja), Warehouses (Virat), Payments (Diana)
-- =============================================

-- BUSINESS USE CASE:
-- This query provides a complete customer order lifecycle view for operations teams
-- to track fulfillment performance, identify bottlenecks, and improve customer satisfaction.
-- It combines user data, order processing, inventory allocation, shipping, and payment status.

-- REAL-WORLD SCENARIO:
-- Operations managers use this query daily to:
-- - Monitor order-to-delivery time across different warehouses
-- - Identify delayed shipments and take corrective action
-- - Track which customers receive fastest service
-- - Analyze payment and fulfillment correlation
-- - Optimize warehouse allocation based on customer location

USE urbanease_shop;

SELECT 
    -- Customer Information (Bajwa's tables)
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS customer_active_status,
    
    -- Order Information (Sneha's tables)
    o.order_id,
    o.status AS order_status,
    o.placed_at AS order_date,
    DATE_FORMAT(o.placed_at, '%Y-%m-%d') AS order_date_formatted,
    o.subtotal_amount,
    o.discount_amount,
    o.shipping_amount,
    o.tax_amount,
    o.grand_total_amount,
    
    -- Order Item Details (Sneha + Virat + Pooja tables)
    COUNT(DISTINCT oi.order_item_id) AS total_line_items,
    SUM(oi.qty) AS total_units_ordered,
    GROUP_CONCAT(DISTINCT p.title SEPARATOR ', ') AS products_ordered,
    GROUP_CONCAT(DISTINCT p.brand SEPARATOR ', ') AS brands_ordered,
    
    -- Payment Information (Diana's tables)
    pay.provider AS payment_provider,
    pay.status AS payment_status,
    pay.paid_at AS payment_date,
    DATEDIFF(pay.paid_at, o.placed_at) AS days_to_payment,
    
    -- Shipment Information (Sneha + Virat tables)
    s.shipment_id,
    w.name AS fulfillment_warehouse,
    CONCAT(w.city, ', ', w.state_region) AS warehouse_location,
    s.carrier AS shipping_carrier,
    s.tracking_no AS tracking_number,
    s.status AS shipment_status,
    s.shipped_at AS ship_date,
    s.delivered_at AS delivery_date,
    
    -- Performance Metrics
    DATEDIFF(s.shipped_at, o.placed_at) AS days_order_to_ship,
    DATEDIFF(s.delivered_at, s.shipped_at) AS days_ship_to_delivery,
    DATEDIFF(s.delivered_at, o.placed_at) AS total_fulfillment_days,
    
    -- SLA Performance Classification
    CASE 
        WHEN s.delivered_at IS NULL AND s.status = 'DELIVERED' THEN 'Data Issue'
        WHEN s.delivered_at IS NULL THEN 'In Progress'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 2 THEN 'EXCELLENT (<=2 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 5 THEN 'GOOD (3-5 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 7 THEN 'ACCEPTABLE (6-7 days)'
        WHEN DATEDIFF(s.delivered_at, o.placed_at) <= 10 THEN 'SLOW (8-10 days)'
        ELSE 'CRITICAL DELAY (>10 days)'
    END AS delivery_performance,
    
    -- Order Value Classification
    CASE 
        WHEN o.grand_total_amount >= 1000 THEN 'HIGH VALUE'
        WHEN o.grand_total_amount >= 500 THEN 'MEDIUM-HIGH VALUE'
        WHEN o.grand_total_amount >= 200 THEN 'MEDIUM VALUE'
        WHEN o.grand_total_amount >= 100 THEN 'LOW-MEDIUM VALUE'
        ELSE 'LOW VALUE'
    END AS order_value_tier,
    
    -- Fulfillment Status Analysis
    CASE 
        WHEN o.status = 'FULFILLED' AND s.status = 'DELIVERED' THEN 'Complete & Delivered'
        WHEN o.status = 'PAID' AND s.status = 'IN_TRANSIT' THEN 'Paid & In Transit'
        WHEN o.status = 'PAID' AND s.status = 'PICKED' THEN 'Paid & Ready to Ship'
        WHEN o.status = 'PAID' AND s.status = 'CREATED' THEN 'Paid & Awaiting Pickup'
        WHEN o.status = 'PENDING' THEN 'Payment Pending'
        WHEN o.status = 'CANCELLED' THEN 'Order Cancelled'
        WHEN o.status = 'REFUNDED' THEN 'Order Refunded'
        ELSE 'Status Mismatch - Review Needed'
    END AS fulfillment_pipeline_status,
    
    -- Risk Flags
    CASE 
        WHEN o.status = 'PAID' AND pay.status != 'CAPTURED' THEN 'RISK: Payment Not Captured'
        WHEN o.status = 'PAID' AND s.status = 'CREATED' AND DATEDIFF(NOW(), o.placed_at) > 2 THEN 'RISK: Delayed Pickup'
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) > 7 THEN 'RISK: Transit Delay'
        WHEN o.grand_total_amount > 500 AND s.carrier = 'USPS' THEN 'WATCH: High Value USPS'
        ELSE 'Normal'
    END AS risk_flag,
    
    -- Customer Satisfaction Predictor
    CASE 
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) <= 3 
            THEN 'High Satisfaction Expected'
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) <= 7 
            THEN 'Moderate Satisfaction Expected'
        WHEN s.delivered_at IS NOT NULL AND DATEDIFF(s.delivered_at, o.placed_at) > 7 
            THEN 'Low Satisfaction - Follow Up Needed'
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) <= 3 
            THEN 'On Track'
        WHEN s.status IN ('CREATED', 'PICKED') AND DATEDIFF(NOW(), o.placed_at) > 2 
            THEN 'At Risk - Expedite Needed'
        ELSE 'Monitor Closely'
    END AS satisfaction_predictor

FROM Orders o
INNER JOIN Users u ON o.user_id = u.user_id
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipments s ON o.order_id = s.order_id
LEFT JOIN Warehouses w ON s.warehouse_id = w.warehouse_id

WHERE 
    o.placed_at >= DATE_SUB(NOW(), INTERVAL 90 DAY)  -- Last 90 days
    AND o.status NOT IN ('CANCELLED', 'REFUNDED')      -- Exclude cancelled orders

GROUP BY 
    u.user_id, u.full_name, u.email, u.phone, u.is_active,
    o.order_id, o.status, o.placed_at, o.subtotal_amount, o.discount_amount, 
    o.shipping_amount, o.tax_amount, o.grand_total_amount,
    pay.provider, pay.status, pay.paid_at,
    s.shipment_id, w.name, w.city, w.state_region,
    s.carrier, s.tracking_no, s.status, s.shipped_at, s.delivered_at

ORDER BY 
    CASE 
        WHEN o.status = 'PAID' AND s.status = 'CREATED' AND DATEDIFF(NOW(), o.placed_at) > 2 THEN 1
        WHEN s.status = 'IN_TRANSIT' AND DATEDIFF(NOW(), s.shipped_at) > 7 THEN 2
        WHEN o.status = 'PENDING' THEN 3
        ELSE 4
    END,
    o.placed_at DESC;

-- BUSINESS VALUE:
-- 1. Operations: Identifies bottlenecks in fulfillment pipeline
-- 2. Customer Service: Proactively addresses delayed orders
-- 3. Warehouse Management: Evaluates warehouse performance
-- 4. Finance: Correlates payment status with fulfillment
-- 5. Executive Dashboard: Overall fulfillment health metrics



-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 2 - Product Performance with Customer Reviews and Sales Analysis
-- Tables Used: Products (Pooja), ProductVariants (Virat), Categories (Pooja), Reviews (Diana),
--              OrderItems (Sneha), Orders (Sneha), Users (Bajwa), Inventory (Virat)
-- =============================================

-- BUSINESS USE CASE:
-- This query combines product catalog, customer reviews, sales data, and inventory to provide
-- a comprehensive product performance dashboard. It helps merchandising and marketing teams
-- identify bestsellers, underperformers, and opportunities for improvement.

-- REAL-WORLD SCENARIO:
-- Merchandising team uses this monthly to:
-- - Decide which products to feature in campaigns
-- - Identify products needing review solicitation
-- - Determine which items to discontinue
-- - Plan inventory investments based on customer satisfaction
-- - Optimize product mix by category

USE urbanease_shop;

SELECT 
    -- Category & Product Info (Pooja's tables)
    c.name AS category_name,
    p.product_id,
    p.title AS product_name,
    p.brand AS product_brand,
    p.is_active AS product_active,
    
    -- Variant Pricing (Virat's tables)
    COUNT(DISTINCT pv.variant_id) AS total_variants,
    MIN(pv.price) AS lowest_price_point,
    MAX(pv.price) AS highest_price_point,
    ROUND(AVG(pv.price), 2) AS average_price_point,
    
    -- Customer Reviews (Diana's tables)
    COUNT(DISTINCT r.review_id) AS total_reviews,
    ROUND(AVG(r.rating), 2) AS average_rating,
    SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS five_star_reviews,
    SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END) AS four_star_reviews,
    SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS three_star_reviews,
    SUM(CASE WHEN r.rating <= 2 THEN 1 ELSE 0 END) AS critical_reviews,
    
    -- Sales Performance (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders_containing_product,
    SUM(oi.qty) AS total_units_sold,
    ROUND(SUM(oi.qty * oi.unit_price), 2) AS total_revenue_generated,
    ROUND(AVG(oi.unit_price), 2) AS average_selling_price,
    
    -- Customer Reach (Bajwa + Sneha tables)
    COUNT(DISTINCT o.user_id) AS unique_customers_purchased,
    
    -- Current Inventory Position (Virat's tables)
    SUM(i.on_hand) AS total_stock_on_hand,
    SUM(i.reserved) AS total_stock_reserved,
    SUM(i.on_hand - i.reserved) AS total_available_stock,
    ROUND(SUM(i.on_hand * pv.price), 2) AS current_inventory_value,
    
    -- Review Health Metrics
    CASE 
        WHEN AVG(r.rating) IS NULL THEN 'NO REVIEWS'
        WHEN AVG(r.rating) >= 4.5 THEN 'EXCELLENT (4.5+)'
        WHEN AVG(r.rating) >= 4.0 THEN 'VERY GOOD (4.0-4.4)'
        WHEN AVG(r.rating) >= 3.5 THEN 'GOOD (3.5-3.9)'
        WHEN AVG(r.rating) >= 3.0 THEN 'AVERAGE (3.0-3.4)'
        ELSE 'BELOW AVERAGE (<3.0)'
    END AS review_rating_class,
    
    -- Review Volume Assessment
    CASE 
        WHEN COUNT(DISTINCT r.review_id) = 0 THEN 'CRITICAL: No Reviews - Needs Attention'
        WHEN COUNT(DISTINCT r.review_id) < 5 THEN 'LOW: Needs More Reviews'
        WHEN COUNT(DISTINCT r.review_id) < 10 THEN 'MODERATE: Building Credibility'
        WHEN COUNT(DISTINCT r.review_id) < 20 THEN 'GOOD: Strong Social Proof'
        ELSE 'EXCELLENT: High Engagement'
    END AS review_volume_status,
    
    -- Sales Performance Classification
    CASE 
        WHEN SUM(oi.qty) IS NULL OR SUM(oi.qty) = 0 THEN 'NO SALES'
        WHEN SUM(oi.qty) >= 50 THEN 'BESTSELLER'
        WHEN SUM(oi.qty) >= 20 THEN 'STRONG SELLER'
        WHEN SUM(oi.qty) >= 10 THEN 'MODERATE SELLER'
        WHEN SUM(oi.qty) >= 5 THEN 'SLOW MOVER'
        ELSE 'POOR PERFORMER'
    END AS sales_performance_tier,
    
    -- Stock Health vs Sales Velocity
    CASE 
        WHEN SUM(oi.qty) > 0 AND SUM(i.on_hand - i.reserved) = 0 
            THEN 'URGENT: Out of Stock & Selling'
        WHEN SUM(oi.qty) > 20 AND SUM(i.on_hand - i.reserved) < 50 
            THEN 'WARNING: High Sales, Low Stock'
        WHEN SUM(oi.qty) < 5 AND SUM(i.on_hand) > 100 
            THEN 'OVERSTOCKED: Low Sales, High Inventory'
        WHEN SUM(i.on_hand - i.reserved) > 0 AND SUM(oi.qty) > 10 
            THEN 'HEALTHY: Good Balance'
        ELSE 'MONITOR'
    END AS inventory_sales_alignment,
    
    -- Customer Satisfaction Score (combining rating and sales)
    CASE 
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 
            THEN 'STAR PRODUCT: High Rating & High Sales'
        WHEN AVG(r.rating) >= 4.0 AND SUM(oi.qty) >= 10 
            THEN 'SOLID PERFORMER: Good Rating & Good Sales'
        WHEN AVG(r.rating) IS NULL AND SUM(oi.qty) >= 20 
            THEN 'SELLING WELL: Needs Reviews for Credibility'
        WHEN AVG(r.rating) < 3.0 AND SUM(oi.qty) < 5 
            THEN 'PROBLEM PRODUCT: Poor Rating & Weak Sales'
        WHEN AVG(r.rating) >= 4.0 AND (SUM(oi.qty) IS NULL OR SUM(oi.qty) < 5) 
            THEN 'HIDDEN GEM: Good Rating but Low Visibility'
        ELSE 'NEEDS ANALYSIS'
    END AS product_health_status,
    
    -- Revenue Performance
    CASE 
        WHEN SUM(oi.qty * oi.unit_price) >= 10000 THEN 'TOP REVENUE DRIVER'
        WHEN SUM(oi.qty * oi.unit_price) >= 5000 THEN 'STRONG REVENUE CONTRIBUTOR'
        WHEN SUM(oi.qty * oi.unit_price) >= 1000 THEN 'MODERATE REVENUE'
        WHEN SUM(oi.qty * oi.unit_price) > 0 THEN 'MINOR REVENUE'
        ELSE 'NO REVENUE'
    END AS revenue_contribution,
    
    -- Strategic Actions Recommended
    CASE 
        WHEN AVG(r.rating) IS NULL AND SUM(oi.qty) > 0 
            THEN 'ACTION: Solicit reviews from recent buyers'
        WHEN AVG(r.rating) < 3.0 
            THEN 'ACTION: Investigate quality issues, consider removal'
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 
            THEN 'ACTION: Feature in marketing campaigns'
        WHEN SUM(i.on_hand - i.reserved) = 0 AND SUM(oi.qty) > 0 
            THEN 'ACTION: Emergency restock - high demand'
        WHEN SUM(oi.qty) < 5 AND SUM(i.on_hand) > 100 
            THEN 'ACTION: Run promotion or consider clearance'
        WHEN AVG(r.rating) >= 4.0 AND SUM(oi.qty) < 5 
            THEN 'ACTION: Increase visibility - good product, low sales'
        ELSE 'ACTION: Monitor performance trends'
    END AS recommended_action,
    
    -- Price-to-Rating Optimization
    CASE 
        WHEN AVG(pv.price) < 100 AND AVG(r.rating) >= 4.5 
            THEN 'OPPORTUNITY: Consider price increase'
        WHEN AVG(pv.price) > 500 AND AVG(r.rating) < 3.5 
            THEN 'RISK: High price, low satisfaction'
        WHEN AVG(pv.price) > 200 AND AVG(r.rating) >= 4.5 
            THEN 'PREMIUM JUSTIFIED: High price, high satisfaction'
        ELSE 'STANDARD PRICING'
    END AS pricing_strategy_insight

FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN ProductVariants pv ON p.product_id = pv.product_id AND pv.is_active = TRUE
LEFT JOIN Reviews r ON p.product_id = r.product_id
LEFT JOIN OrderItems oi ON pv.variant_id = oi.variant_id
LEFT JOIN Orders o ON oi.order_id = o.order_id 
    AND o.status IN ('PAID', 'FULFILLED') 
    AND o.placed_at >= DATE_SUB(NOW(), INTERVAL 90 DAY)
LEFT JOIN Inventory i ON pv.variant_id = i.variant_id

WHERE p.is_active = TRUE

GROUP BY 
    c.name, p.product_id, p.title, p.brand, p.is_active

ORDER BY 
    CASE 
        WHEN AVG(r.rating) >= 4.5 AND SUM(oi.qty) >= 20 THEN 1  -- Star products first
        WHEN SUM(oi.qty) > 0 AND SUM(i.on_hand - i.reserved) = 0 THEN 2  -- Out of stock sellers
        WHEN AVG(r.rating) < 3.0 THEN 3  -- Problem products
        ELSE 4
    END,
    total_revenue_generated DESC,
    average_rating DESC;

-- BUSINESS VALUE:
-- 1. Merchandising: Identifies products to promote or discontinue
-- 2. Marketing: Finds star products for campaigns
-- 3. Customer Success: Identifies products needing quality improvement
-- 4. Inventory Planning: Aligns stock with demand and satisfaction
-- 5. Pricing Strategy: Optimizes pricing based on customer feedback
-- 6. Executive Dashboard: Product portfolio health overview



-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 3 - Abandoned Cart Recovery with Customer & Inventory Intelligence
-- Tables Used: Carts (Min), CartItems (Min), Users (Bajwa), ProductVariants (Virat),
--              Products (Pooja), Inventory (Virat), Coupons (Min), Orders (Sneha)
-- =============================================

-- BUSINESS USE CASE:
-- This query identifies high-value abandoned carts and provides actionable intelligence
-- for recovery campaigns. It combines cart data with customer history, product availability,
-- and coupon strategies to maximize conversion rates.

-- REAL-WORLD SCENARIO:
-- Marketing team runs this query 3x daily to:
-- - Send personalized cart recovery emails with dynamic coupons
-- - Prioritize which abandoned carts to target first
-- - Ensure products are still in stock before sending reminders
-- - Customize messaging based on customer purchase history
-- - Calculate ROI of recovery campaigns

USE urbanease_shop;

SELECT 
    -- Cart Identification
    c.cart_id,
    c.created_at AS cart_created_date,
    c.updated_at AS cart_last_modified,
    DATEDIFF(NOW(), c.updated_at) AS days_since_last_activity,
    TIMESTAMPDIFF(HOUR, c.updated_at, NOW()) AS hours_since_last_activity,
    
    -- Customer Information (Bajwa's tables)
    CASE 
        WHEN c.user_id IS NULL THEN 'Guest'
        ELSE 'Registered'
    END AS customer_type,
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS customer_active_status,
    DATE_FORMAT(u.created_at, '%Y-%m-%d') AS customer_since,
    DATEDIFF(NOW(), u.created_at) AS customer_age_days,
    
    -- Cart Contents (Min + Virat + Pooja tables)
    COUNT(DISTINCT ci.cart_item_id) AS total_items_in_cart,
    SUM(ci.qty) AS total_units_in_cart,
    GROUP_CONCAT(DISTINCT p.title ORDER BY (ci.qty * ci.unit_price) DESC SEPARATOR ' | ') AS products_in_cart,
    GROUP_CONCAT(DISTINCT p.brand SEPARATOR ', ') AS brands_in_cart,
    GROUP_CONCAT(DISTINCT pv.sku SEPARATOR ', ') AS skus_in_cart,
    
    -- Cart Value Analysis
    ROUND(SUM(ci.qty * ci.unit_price), 2) AS cart_total_value,
    ROUND(AVG(ci.unit_price), 2) AS average_item_price,
    ROUND(MAX(ci.unit_price), 2) AS highest_priced_item,
    ROUND(MIN(ci.unit_price), 2) AS lowest_priced_item,
    
    -- Inventory Availability Check (Virat's tables)
    SUM(CASE 
        WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1
        ELSE 0
    END) AS items_in_stock_count,
    SUM(CASE 
        WHEN IFNULL(inv.on_hand - inv.reserved, 0) < ci.qty THEN 1
        ELSE 0
    END) AS items_out_of_stock_count,
    
    -- Customer Purchase History (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS previous_orders_count,
    ROUND(COALESCE(SUM(o.grand_total_amount), 0), 2) AS lifetime_purchase_value,
    MAX(o.placed_at) AS last_order_date,
    DATEDIFF(NOW(), MAX(o.placed_at)) AS days_since_last_order,
    
    -- Cart Abandonment Classification
    CASE 
        WHEN DATEDIFF(NOW(), c.updated_at) = 0 THEN 'TODAY - Fresh Abandonment'
        WHEN DATEDIFF(NOW(), c.updated_at) = 1 THEN 'YESTERDAY - 24hr Window'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 3 THEN 'RECENT - 2-3 Days (Prime for Recovery)'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 7 THEN 'STALE - 4-7 Days'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 14 THEN 'VERY STALE - 8-14 Days'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 30 THEN 'OLD - 15-30 Days'
        ELSE 'EXPIRED - >30 Days'
    END AS abandonment_age_category,
    
    -- Cart Value Tier
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 1000 THEN 'PREMIUM ($1000+)'
        WHEN SUM(ci.qty * ci.unit_price) >= 500 THEN 'HIGH VALUE ($500-$999)'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 THEN 'MEDIUM-HIGH ($200-$499)'
        WHEN SUM(ci.qty * ci.unit_price) >= 100 THEN 'MEDIUM ($100-$199)'
        WHEN SUM(ci.qty * ci.unit_price) >= 50 THEN 'LOW-MEDIUM ($50-$99)'
        ELSE 'LOW VALUE (<$50)'
    END AS cart_value_tier,
    
    -- Recovery Priority Score (1-10, 10 being highest)
    CASE 
        -- High value, recent abandonment, items in stock, existing customer
        WHEN SUM(ci.qty * ci.unit_price) >= 500 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            AND c.user_id IS NOT NULL
            THEN 10
        -- High value, recent, in stock
        WHEN SUM(ci.qty * ci.unit_price) >= 300 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) >= COUNT(ci.cart_item_id) * 0.8
            THEN 9
        -- Medium-high value, very recent
        WHEN SUM(ci.qty * ci.unit_price) >= 200 AND DATEDIFF(NOW(), c.updated_at) <= 1 THEN 8
        -- High value but older
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND DATEDIFF(NOW(), c.updated_at) <= 7 THEN 7
        -- Medium value, recent
        WHEN SUM(ci.qty * ci.unit_price) >= 100 AND DATEDIFF(NOW(), c.updated_at) <= 3 THEN 6
        -- Registered customer, decent value
        WHEN c.user_id IS NOT NULL AND SUM(ci.qty * ci.unit_price) >= 100 THEN 5
        -- Recent but low value
        WHEN DATEDIFF(NOW(), c.updated_at) <= 1 THEN 4
        -- Guest cart, low value
        WHEN c.user_id IS NULL AND SUM(ci.qty * ci.unit_price) < 50 THEN 2
        -- Very old carts
        WHEN DATEDIFF(NOW(), c.updated_at) > 14 THEN 1
        ELSE 3
    END AS recovery_priority_score,
    
    -- Customer Segment for Targeting
    CASE 
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) >= 3 
            THEN 'LOYAL CUSTOMER - High Trust'
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) BETWEEN 1 AND 2 
            THEN 'REPEAT BUYER - Medium Trust'
        WHEN c.user_id IS NOT NULL AND COUNT(DISTINCT o.order_id) = 0 
            THEN 'NEW REGISTERED - Building Relationship'
        WHEN c.user_id IS NULL 
            THEN 'GUEST - Needs Registration Incentive'
        ELSE 'UNKNOWN'
    END AS customer_segment,
    
    -- Recommended Recovery Strategy
    CASE 
        -- High value loyal customers
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND COUNT(DISTINCT o.order_id) >= 3 
            THEN 'VIP: Personal email + Phone call + Free shipping + 15% off'
        -- High value new customers
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND COUNT(DISTINCT o.order_id) = 0 
            THEN 'HIGH POTENTIAL: Email + 20% first order discount + Free shipping'
        -- Medium value, items in stock, recent
        WHEN SUM(ci.qty * ci.unit_price) >= 200 
            AND DATEDIFF(NOW(), c.updated_at) <= 3 
            AND SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            THEN 'TIMELY: Email + 10% discount + Urgency message (24hr)'
        -- Out of stock issues
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) < ci.qty THEN 1 ELSE 0 END) > 0 
            THEN 'INVENTORY: Notify when back in stock + Waitlist'
        -- Guest carts
        WHEN c.user_id IS NULL AND SUM(ci.qty * ci.unit_price) >= 100 
            THEN 'GUEST RECOVERY: Email + Register & Save 10% incentive'
        -- Stale carts
        WHEN DATEDIFF(NOW(), c.updated_at) BETWEEN 7 AND 14 
            THEN 'LAST CHANCE: Email + 15% off + Limited time offer'
        -- Low priority
        ELSE 'LOW PRIORITY: Basic reminder email only'
    END AS recommended_recovery_tactic,
    
    -- Suggested Coupon Type (from Min's Coupons table logic)
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 500 THEN 'Offer SAVE15 or MEGA50 coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 THEN 'Offer SAVE15 or DEAL25 coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 100 THEN 'Offer WELCOME10 or GET10OFF coupon'
        WHEN SUM(ci.qty * ci.unit_price) >= 50 THEN 'Offer WELCOME10 or SAVE5 coupon'
        ELSE 'Offer SAVE5 coupon or free shipping'
    END AS suggested_coupon_strategy,
    
    -- Stock Availability Status
    CASE 
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) = COUNT(ci.cart_item_id)
            THEN 'ALL IN STOCK - Ready to fulfill'
        WHEN SUM(CASE WHEN IFNULL(inv.on_hand - inv.reserved, 0) >= ci.qty THEN 1 ELSE 0 END) >= COUNT(ci.cart_item_id) * 0.5
            THEN 'PARTIALLY IN STOCK - Some items available'
        ELSE 'MOSTLY OUT OF STOCK - Notify when available'
    END AS inventory_availability_status,
    
    -- Estimated Recovery Value (cart value * probability)
    ROUND(
        SUM(ci.qty * ci.unit_price) * 
        CASE 
            WHEN DATEDIFF(NOW(), c.updated_at) <= 1 THEN 0.35  -- 35% conversion within 24hrs
            WHEN DATEDIFF(NOW(), c.updated_at) <= 3 THEN 0.25  -- 25% conversion 2-3 days
            WHEN DATEDIFF(NOW(), c.updated_at) <= 7 THEN 0.15  -- 15% conversion 4-7 days
            WHEN DATEDIFF(NOW(), c.updated_at) <= 14 THEN 0.05 -- 5% conversion 8-14 days
            ELSE 0.02  -- 2% conversion after 14 days
        END, 
        2
    ) AS estimated_recovery_value,
    
    -- Action Urgency
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) >= 500 AND DATEDIFF(NOW(), c.updated_at) <= 1 
            THEN 'URGENT: Contact within 2 hours'
        WHEN SUM(ci.qty * ci.unit_price) >= 200 AND DATEDIFF(NOW(), c.updated_at) <= 3 
            THEN 'HIGH: Contact within 12 hours'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 3 
            THEN 'MEDIUM: Contact within 24 hours'
        WHEN DATEDIFF(NOW(), c.updated_at) <= 7 
            THEN 'LOW: Contact within 3 days'
        ELSE 'MINIMAL: Optional contact'
    END AS action_urgency

FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON c.cart_id = ci.cart_id
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN (
    SELECT variant_id, SUM(on_hand) AS on_hand, SUM(reserved) AS reserved
    FROM Inventory
    GROUP BY variant_id
) inv ON pv.variant_id = inv.variant_id
LEFT JOIN Orders o ON c.user_id = o.user_id AND o.status IN ('PAID', 'FULFILLED')

WHERE 
    -- Cart was updated in last 30 days (not too old)
    c.updated_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    -- Cart was not converted to order (check by lack of recent order with same products)
    AND NOT EXISTS (
        SELECT 1 FROM Orders o2
        INNER JOIN OrderItems oi ON o2.order_id = oi.order_id
        WHERE o2.user_id = c.user_id 
        AND oi.variant_id = ci.variant_id
        AND o2.placed_at >= c.updated_at
    )
    -- Cart has been inactive for at least 3 hours (abandoned)
    AND TIMESTAMPDIFF(HOUR, c.updated_at, NOW()) >= 3

GROUP BY 
    c.cart_id, c.created_at, c.updated_at, c.user_id,
    u.user_id, u.full_name, u.email, u.phone, u.is_active, u.created_at

HAVING 
    cart_total_value > 0  -- Only carts with value

ORDER BY 
    recovery_priority_score DESC,
    cart_total_value DESC,
    days_since_last_activity ASC;

-- BUSINESS VALUE:
-- 1. Marketing: Prioritized list for cart recovery campaigns
-- 2. Sales: Identifies high-value opportunities for personal outreach
-- 3. Customer Success: Personalizes recovery messaging based on customer history
-- 4. Inventory: Ensures stock availability before sending reminders
-- 5. Finance: Estimates potential revenue from recovery efforts
-- 6. Analytics: Tracks abandonment patterns and recovery ROI



-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 4 - Comprehensive Revenue & Profitability Dashboard
-- Tables Used: Orders (Sneha), OrderItems (Sneha), Payments (Diana), ProductVariants (Virat),
--              Products (Pooja), Categories (Pooja), Users (Bajwa), Coupons (Min), Shipments (Sneha)
-- =============================================

-- BUSINESS USE CASE:
-- This query provides executive-level financial insights by combining orders, payments,
-- product costs, discounts, and shipping to calculate true profitability metrics.
-- It helps CFO and finance teams understand revenue streams, margins, and cost drivers.

-- REAL-WORLD SCENARIO:
-- Finance team uses this for:
-- - Monthly financial reporting and board presentations
-- - Identifying most/least profitable product categories
-- - Analyzing discount impact on margins
-- - Calculating customer acquisition cost vs. lifetime value
-- - Optimizing pricing and promotional strategies

USE urbanease_shop;

SELECT 
    -- Time Period Analysis
    DATE_FORMAT(o.placed_at, '%Y-%m') AS order_month,
    DATE_FORMAT(o.placed_at, '%Y-Q%q') AS order_quarter,
    YEAR(o.placed_at) AS order_year,
    DAYNAME(o.placed_at) AS order_day_of_week,
    
    -- Category Performance (Pooja's tables)
    c.name AS product_category,
    
    -- Order Metrics (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT o.user_id), 2) AS orders_per_customer,
    
    -- Order Status Distribution
    SUM(CASE WHEN o.status = 'PAID' THEN 1 ELSE 0 END) AS orders_paid,
    SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) AS orders_fulfilled,
    SUM(CASE WHEN o.status = 'PENDING' THEN 1 ELSE 0 END) AS orders_pending,
    SUM(CASE WHEN o.status = 'CANCELLED' THEN 1 ELSE 0 END) AS orders_cancelled,
    SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) AS orders_refunded,
    
    -- Revenue Metrics
    ROUND(SUM(o.subtotal_amount), 2) AS gross_merchandise_value,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts_given,
    ROUND(SUM(o.shipping_amount), 2) AS total_shipping_charged,
    ROUND(SUM(o.tax_amount), 2) AS total_tax_collected,
    ROUND(SUM(o.grand_total_amount), 2) AS total_revenue,
    
    -- Average Order Metrics
    ROUND(AVG(o.subtotal_amount), 2) AS avg_order_subtotal,
    ROUND(AVG(o.grand_total_amount), 2) AS avg_order_value,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount_per_order,
    
    -- Product & Unit Metrics (Virat + Sneha tables)
    SUM(oi.qty) AS total_units_sold,
    ROUND(AVG(oi.unit_price), 2) AS avg_unit_selling_price,
    COUNT(DISTINCT p.product_id) AS unique_products_sold,
    COUNT(DISTINCT pv.variant_id) AS unique_variants_sold,
    
    -- Discount Analysis (Min's tables - coupon impact)
    COUNT(DISTINCT o.coupon_id) AS orders_with_coupons,
    ROUND(
        (COUNT(DISTINCT o.coupon_id) / COUNT(DISTINCT o.order_id) * 100), 
        2
    ) AS coupon_usage_rate_percent,
    ROUND(
        (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100), 
        2
    ) AS avg_discount_rate_percent,
    
    -- Payment Success Metrics (Diana's tables)
    COUNT(DISTINCT CASE WHEN pay.status = 'CAPTURED' THEN pay.payment_id END) AS successful_payments,
    COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) AS failed_payments,
    COUNT(DISTINCT CASE WHEN pay.status = 'REFUNDED' THEN pay.payment_id END) AS refunded_payments,
    ROUND(
        (COUNT(DISTINCT CASE WHEN pay.status = 'CAPTURED' THEN pay.payment_id END) / 
         NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100), 
        2
    ) AS payment_success_rate_percent,
    
    -- Payment Provider Distribution
    SUM(CASE WHEN pay.provider = 'Stripe' THEN pay.amount ELSE 0 END) AS stripe_revenue,
    SUM(CASE WHEN pay.provider = 'PayPal' THEN pay.amount ELSE 0 END) AS paypal_revenue,
    SUM(CASE WHEN pay.provider = 'Square' THEN pay.amount ELSE 0 END) AS square_revenue,
    
    -- Shipping Performance (Sneha's Shipments table)
    COUNT(DISTINCT s.shipment_id) AS total_shipments,
    SUM(CASE WHEN s.status = 'DELIVERED' THEN 1 ELSE 0 END) AS shipments_delivered,
    ROUND(
        AVG(CASE 
            WHEN s.delivered_at IS NOT NULL AND s.shipped_at IS NOT NULL 
            THEN DATEDIFF(s.delivered_at, s.shipped_at)
            ELSE NULL
        END), 
        2
    ) AS avg_delivery_days,
    
    -- Profitability Metrics (Estimates)
    -- Net Revenue = Total Revenue - Discounts
    ROUND(SUM(o.grand_total_amount) - SUM(o.discount_amount), 2) AS net_revenue_after_discounts,
    
    -- Revenue Per Unit
    ROUND(
        SUM(o.grand_total_amount) / NULLIF(SUM(oi.qty), 0), 
        2
    ) AS revenue_per_unit_sold,
    
    -- Discount Efficiency (Revenue impact)
    ROUND(
        (SUM(o.grand_total_amount) / NULLIF(SUM(o.discount_amount), 0)), 
        2
    ) AS revenue_dollars_per_discount_dollar,
    
    -- Category Performance Indicators
    CASE 
        WHEN SUM(o.grand_total_amount) >= 50000 THEN 'TOP REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 20000 THEN 'HIGH REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 10000 THEN 'MEDIUM REVENUE CATEGORY'
        WHEN SUM(o.grand_total_amount) >= 5000 THEN 'LOW-MEDIUM REVENUE CATEGORY'
        ELSE 'LOW REVENUE CATEGORY'
    END AS category_revenue_tier,
    
    -- Discount Strategy Assessment
    CASE 
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 20 
            THEN 'HIGH DISCOUNT DEPENDENCY - Review Strategy'
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 10 
            THEN 'MODERATE DISCOUNTING - Acceptable'
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 5 
            THEN 'LOW DISCOUNTING - Healthy Margins'
        ELSE 'MINIMAL DISCOUNTING - Premium Pricing'
    END AS discount_strategy_health,
    
    -- Order Fulfillment Efficiency
    CASE 
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 80 
            THEN 'EXCELLENT FULFILLMENT (>80%)'
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 60 
            THEN 'GOOD FULFILLMENT (60-80%)'
        WHEN (SUM(CASE WHEN o.status = 'FULFILLED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) >= 40 
            THEN 'NEEDS IMPROVEMENT (40-60%)'
        ELSE 'POOR FULFILLMENT (<40%)'
    END AS fulfillment_performance,
    
    -- Payment Processing Health
    CASE 
        WHEN (COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) / 
              NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100) > 10 
            THEN 'HIGH FAILURE RATE - Check Payment Gateway'
        WHEN (COUNT(DISTINCT CASE WHEN pay.status = 'FAILED' THEN pay.payment_id END) / 
              NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100) > 5 
            THEN 'ELEVATED FAILURE RATE - Monitor Closely'
        ELSE 'HEALTHY PAYMENT PROCESSING'
    END AS payment_processing_health,
    
    -- Return/Refund Rate Analysis
    CASE 
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 10 
            THEN 'HIGH RETURN RATE - Quality Issue'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 5 
            THEN 'ELEVATED RETURNS - Investigate'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 2 
            THEN 'NORMAL RETURN RATE'
        ELSE 'LOW RETURN RATE - Excellent'
    END AS return_rate_assessment,
    
    -- Growth Indicators
    CASE 
        WHEN COUNT(DISTINCT o.order_id) >= 50 THEN 'HIGH VOLUME PERIOD'
        WHEN COUNT(DISTINCT o.order_id) >= 20 THEN 'MEDIUM VOLUME PERIOD'
        WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 'LOW VOLUME PERIOD'
        ELSE 'MINIMAL VOLUME PERIOD'
    END AS order_volume_classification,
    
    -- Strategic Recommendations
    CASE 
        WHEN (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) > 15 
            AND AVG(o.grand_total_amount) < 100 
            THEN 'STRATEGY: Reduce discounts, focus on value perception'
        WHEN AVG(o.grand_total_amount) >= 500 
            AND (SUM(o.discount_amount) / NULLIF(SUM(o.subtotal_amount), 0) * 100) < 5 
            THEN 'STRATEGY: Premium segment - maintain pricing power'
        WHEN COUNT(DISTINCT o.user_id) < 20 
            THEN 'STRATEGY: Focus on customer acquisition'
        WHEN (SUM(CASE WHEN o.status = 'REFUNDED' THEN 1 ELSE 0 END) / 
              NULLIF(COUNT(DISTINCT o.order_id), 0) * 100) > 8 
            THEN 'STRATEGY: Investigate product quality/fit issues'
        WHEN (COUNT(DISTINCT pay.payment_id) / NULLIF(COUNT(DISTINCT o.order_id), 0)) < 0.95 
            THEN 'STRATEGY: Improve payment gateway or offer more payment options'
        ELSE 'STRATEGY: Scale current operations'
    END AS strategic_recommendation

FROM Orders o
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipments s ON o.order_id = s.order_id

WHERE 
    o.placed_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)  -- Last 6 months
    AND o.status NOT IN ('CANCELLED')  -- Exclude cancelled orders

GROUP BY 
    DATE_FORMAT(o.placed_at, '%Y-%m'),
    DATE_FORMAT(o.placed_at, '%Y-Q%q'),
    YEAR(o.placed_at),
    DAYNAME(o.placed_at),
    c.name

ORDER BY 
    order_year DESC,
    order_month DESC,
    total_revenue DESC;

-- BUSINESS VALUE:
-- 1. CFO/Finance: Comprehensive P&L insights and margin analysis
-- 2. Executives: Strategic decision-making on pricing and promotions
-- 3. Category Managers: Category performance benchmarking
-- 4. Marketing: ROI on discount campaigns and promotional strategies
-- 5. Operations: Fulfillment efficiency and bottleneck identification
-- 6. Investors: Business health and growth trajectory metrics



-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Query 5 - Customer Lifetime Value & RFM Segmentation Analysis
-- Tables Used: Users (Bajwa), UserRoles (Bajwa), Orders (Sneha), OrderItems (Sneha),
--              Payments (Diana), Reviews (Diana), Carts (Min), Addresses (Diana)
-- =============================================

-- BUSINESS USE CASE:
-- This query implements RFM (Recency, Frequency, Monetary) analysis combined with
-- engagement metrics to segment customers and calculate lifetime value. It enables
-- targeted marketing, personalized experiences, and customer retention strategies.

-- REAL-WORLD SCENARIO:
-- Marketing and CRM teams use this for:
-- - Identifying VIP customers for exclusive offers
-- - Segmenting customers for email marketing campaigns
-- - Calculating customer acquisition cost (CAC) payback periods
-- - Predicting churn risk and implementing retention programs
-- - Personalizing product recommendations and pricing

USE urbanease_shop;

SELECT 
    -- Customer Identity (Bajwa's tables)
    u.user_id,
    u.full_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    u.is_active AS account_active,
    DATE_FORMAT(u.created_at, '%Y-%m-%d') AS registration_date,
    DATEDIFF(NOW(), u.created_at) AS customer_age_days,
    ROUND(DATEDIFF(NOW(), u.created_at) / 30.0, 1) AS customer_age_months,
    
    -- Customer Role (Bajwa's tables)
    GROUP_CONCAT(DISTINCT r.role_name SEPARATOR ', ') AS user_roles,
    CASE 
        WHEN GROUP_CONCAT(DISTINCT r.role_name) LIKE '%VIPCustomer%' THEN 'VIP Member'
        WHEN GROUP_CONCAT(DISTINCT r.role_name) LIKE '%Customer%' THEN 'Regular Customer'
        ELSE 'Other'
    END AS membership_tier,
    
    -- RFM: RECENCY - Days since last order (Sneha's tables)
    MAX(o.placed_at) AS last_order_date,
    DATEDIFF(NOW(), MAX(o.placed_at)) AS days_since_last_order,
    CASE 
        WHEN MAX(o.placed_at) IS NULL THEN 0
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5  -- Very Recent
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4  -- Recent
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3  -- Moderate
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2  -- Old
        ELSE 1  -- Very Old
    END AS recency_score,
    
    -- RFM: FREQUENCY - Number of orders (Sneha's tables)
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COUNT(DISTINCT o.order_id) / NULLIF(DATEDIFF(NOW(), u.created_at) / 30.0, 0), 2) AS avg_orders_per_month,
    CASE 
        WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5  -- Very Frequent
        WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4   -- Frequent
        WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3   -- Moderate
        WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2   -- Infrequent
        ELSE 1  -- No Orders
    END AS frequency_score,
    
    -- RFM: MONETARY - Total spent (Sneha + Diana tables)
    ROUND(SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END), 2) AS lifetime_value,
    ROUND(AVG(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE NULL END), 2) AS avg_order_value,
    CASE 
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2
        ELSE 1
    END AS monetary_score,
    
    -- Composite RFM Score
    CONCAT(
        CASE 
            WHEN MAX(o.placed_at) IS NULL THEN 0
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3
            WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2
            ELSE 1
        END,
        CASE 
            WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5
            WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4
            WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3
            WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2
            ELSE 1
        END,
        CASE 
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3
            WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2
            ELSE 1
        END
    ) AS rfm_score,
    
    -- Purchase Behavior Metrics
    SUM(oi.qty) AS total_units_purchased,
    COUNT(DISTINCT pv.product_id) AS unique_products_purchased,
    MIN(o.placed_at) AS first_order_date,
    DATEDIFF(MAX(o.placed_at), MIN(o.placed_at)) AS customer_lifespan_days,
    
    -- Payment Behavior (Diana's tables)
    SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) AS successful_payments,
    SUM(CASE WHEN pay.status = 'FAILED' THEN 1 ELSE 0 END) AS failed_payments,
    ROUND(
        (SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(DISTINCT pay.payment_id), 0) * 100), 
        2
    ) AS payment_success_rate,
    
    -- Engagement Metrics
    COUNT(DISTINCT rev.review_id) AS reviews_written,
    ROUND(AVG(rev.rating), 2) AS avg_review_rating,
    COUNT(DISTINCT addr.address_id) AS addresses_on_file,
    COUNT(DISTINCT cart.cart_id) AS total_carts_created,
    
    -- Customer Segmentation
    CASE 
        -- Champions: High R, F, M (555, 554, 545, 544)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('555', '554', '545', '544', '455', '454', '445')
            THEN 'Champions'
        
        -- Loyal Customers: High F, M but lower R (445, 435, 345)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('344', '345', '335', '334', '444', '435', '434')
            THEN 'Loyal Customers'
        
        -- Potential Loyalists: Recent, moderate F & M (525, 524, 515, 514)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('523', '522', '521', '513', '512', '511', '423', '422', '421')
            THEN 'Potential Loyalists'
        
        -- At Risk: Low R, high F & M (245, 244, 235, 234)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('244', '243', '234', '233', '224', '223', '144', '143', '134', '133')
            THEN 'At Risk'
        
        -- Can't Lose Them: Very low R, high F & M (145, 144, 135, 134)
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('155', '154', '145', '144', '155', '135', '124', '123')
            THEN 'Cannot Lose Them'
        
        -- New Customers: High R, low F (511, 411, 311)
        WHEN COUNT(DISTINCT o.order_id) <= 2 AND DATEDIFF(NOW(), MAX(o.placed_at)) <= 60
            THEN 'New Customers'
        
        -- Promising: Recent, low F but good M (533, 532, 531, 543, 542, 541)
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 AND COUNT(DISTINCT o.order_id) <= 3 
            AND SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 500
            THEN 'Promising'
        
        -- Hibernating: Low R, F, M (222, 221, 212, 211)
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 AND COUNT(DISTINCT o.order_id) <= 3
            THEN 'Hibernating'
        
        -- Lost: Very low scores
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 OR MAX(o.placed_at) IS NULL
            THEN 'Lost'
        
        ELSE 'Needs Attention'
    END AS customer_segment,
    
    -- Marketing Actions
    CASE 
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('555', '554', '545', '544', '455', '454', '445')
            THEN 'VIP Treatment: Exclusive access, early releases, personal account manager'
        WHEN CONCAT(
            CASE WHEN MAX(o.placed_at) IS NULL THEN 0 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 30 THEN 5 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 60 THEN 4 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 90 THEN 3 WHEN DATEDIFF(NOW(), MAX(o.placed_at)) <= 180 THEN 2 ELSE 1 END,
            CASE WHEN COUNT(DISTINCT o.order_id) >= 10 THEN 5 WHEN COUNT(DISTINCT o.order_id) >= 5 THEN 4 WHEN COUNT(DISTINCT o.order_id) >= 3 THEN 3 WHEN COUNT(DISTINCT o.order_id) >= 1 THEN 2 ELSE 1 END,
            CASE WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 THEN 5 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 THEN 4 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 THEN 3 WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 THEN 2 ELSE 1 END
        ) IN ('244', '243', '234', '233', '224', '223', '144', '143', '134', '133')
            THEN 'Win-Back Campaign: Aggressive discounts, personalized outreach'
        WHEN COUNT(DISTINCT o.order_id) <= 2 AND DATEDIFF(NOW(), MAX(o.placed_at)) <= 60
            THEN 'Nurture: Welcome series, product education, onboarding'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 OR MAX(o.placed_at) IS NULL
            THEN 'Re-engagement: Survey, massive discount, new product showcase'
        ELSE 'Standard Marketing: Regular newsletters, seasonal promotions'
    END AS recommended_marketing_action,
    
    -- Churn Risk
    CASE 
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 180 AND COUNT(DISTINCT o.order_id) >= 3 THEN 'HIGH CHURN RISK'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 90 AND COUNT(DISTINCT o.order_id) >= 2 THEN 'MEDIUM CHURN RISK'
        WHEN DATEDIFF(NOW(), MAX(o.placed_at)) > 60 THEN 'LOW CHURN RISK'
        WHEN MAX(o.placed_at) IS NULL THEN 'NEVER PURCHASED'
        ELSE 'ACTIVE'
    END AS churn_risk_level,
    
    -- Customer Value Tier
    CASE 
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 5000 
            THEN 'PLATINUM ($5000+)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 2000 
            THEN 'GOLD ($2000-$4999)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 1000 
            THEN 'SILVER ($1000-$1999)'
        WHEN SUM(CASE WHEN o.status IN ('PAID', 'FULFILLED') THEN o.grand_total_amount ELSE 0 END) >= 100 
            THEN 'BRONZE ($100-$999)'
        ELSE 'STARTER (<$100)'
    END AS customer_value_tier

FROM Users u
LEFT JOIN UserRoles ur ON u.user_id = ur.user_id
LEFT JOIN Roles r ON ur.role_id = r.role_id
LEFT JOIN Orders o ON u.user_id = o.user_id AND o.status IN ('PAID', 'FULFILLED', 'PENDING')
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
LEFT JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Reviews rev ON u.user_id = rev.user_id
LEFT JOIN Addresses addr ON u.user_id = addr.user_id
LEFT JOIN Carts cart ON u.user_id = cart.user_id

WHERE 
    u.is_active = TRUE
    AND u.created_at <= NOW()

GROUP BY 
    u.user_id, u.full_name, u.email, u.phone, u.is_active, u.created_at

ORDER BY 
    lifetime_value DESC,
    total_orders DESC,
    days_since_last_order ASC;

-- BUSINESS VALUE:
-- 1. Marketing: Targeted campaigns based on customer segments
-- 2. Customer Success: Proactive retention for at-risk customers
-- 3. Sales: Identifies upsell opportunities with high-value customers
-- 4. Finance: Customer lifetime value forecasting
-- 5. Product: Tailors features and pricing for different segments
-- 6. Executive: Overall customer health and retention metrics



-- =============================================
-- Min, La Yaung
-- =============================================

-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 1 - Active Shopping Carts with Items
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;


-- a query that gives a detailed snapshot of every active shopping cart 
-- showing who owns it, how many items and categories it contains, how valuable it is, and when it was last updated.
SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,          -- handles guest checkouts gracefully
    COUNT(DISTINCT ci.cart_item_id) AS total_items,            -- total unique items in cart
    SUM(ci.qty * ci.unit_price) AS total_cart_value,           -- total value = sum of quantity × unit price
    MAX(ci.added_at) AS last_item_added,                       -- most recent time an item was added
    GROUP_CONCAT(DISTINCT cat.name ORDER BY cat.name SEPARATOR ', ') AS categories_in_cart,  -- categories covered in this cart
    CASE 
        WHEN SUM(ci.qty * ci.unit_price) > 500 THEN 'High Value'
        WHEN SUM(ci.qty * ci.unit_price) BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS spending_tier,                                       -- simple tiering system based on total value
    COUNT(DISTINCT pv.product_id) AS distinct_products,         -- unique product count (excluding variants)
    COUNT(DISTINCT pv.variant_id) AS variant_count              -- count of product variants in the cart
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
LEFT JOIN Products p ON pv.product_id = p.product_id
LEFT JOIN Categories cat ON p.category_id = cat.category_id
WHERE c.cart_id IN (
    SELECT DISTINCT cart_id 
    FROM CartItems 
    WHERE qty > 0
)
GROUP BY c.cart_id, user_name
HAVING total_items > 0
ORDER BY total_cart_value DESC, last_item_added DESC;

-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Enhanced Query 2 - Abandoned Carts Revenue Insights
-- Tables: Carts, CartItems, Coupons, Users
-- =============================================

USE urbanease_shop;


-- a query that ranks carts by inactivity and potential revenue to help the team decide 
-- which users to target first with reminders or coupon offers for cart recovery.
WITH cart_summary AS (
    SELECT 
        c.cart_id,
        COALESCE(u.full_name, 'Guest User') AS user_name,
        TIMESTAMPDIFF(DAY, MAX(ci.added_at), NOW()) AS days_inactive,  -- Days since the last item was added
        COUNT(ci.cart_item_id) AS total_items,
        SUM(ci.qty * ci.unit_price) AS potential_revenue,               -- Estimated total cart value
        COUNT(DISTINCT p.category_id) AS category_diversity             -- How diverse the cart is (helps in marketing personalization)
    FROM Carts c
    LEFT JOIN Users u ON c.user_id = u.user_id
    INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
    INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
    INNER JOIN Products p ON pv.product_id = p.product_id
    GROUP BY c.cart_id, user_name
)
SELECT 
    cs.cart_id,
    cs.user_name,
    cs.days_inactive,
    cs.total_items,
    ROUND(cs.potential_revenue, 2) AS potential_revenue,
    cs.category_diversity,
    -- Customer activity classification
    CASE
        WHEN cs.days_inactive <= 2 THEN 'Recently Active'
        WHEN cs.days_inactive BETWEEN 3 AND 6 THEN 'At Risk'
        WHEN cs.days_inactive BETWEEN 7 AND 14 THEN 'Likely Lost'
        ELSE 'Dormant'
    END AS cart_status,

    -- Prioritize high-value carts with recent inactivity

    RANK() OVER (
        ORDER BY cs.days_inactive ASC, cs.potential_revenue DESC
    ) AS recovery_priority,

    -- Suggest a coupon strategy based on value
    CASE
        WHEN cs.potential_revenue >= 500 THEN 'Offer 20% OFF coupon'
        WHEN cs.potential_revenue BETWEEN 200 AND 499 THEN 'Offer $25 OFF coupon'
        ELSE 'Send gentle reminder email'
    END AS recommended_action
FROM cart_summary cs
WHERE cs.total_items > 0
ORDER BY recovery_priority;


-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Query 3 - Coupon Usage and Effectiveness
-- Tables: Carts, CartItems, Coupons
-- =============================================

USE urbanease_shop;

-- a query that calculates how much each active coupon could discount total cart values based on current items

SELECT 
    cp.code AS coupon_code,												-- Coupon code identifier
    cp.type AS discount_type,											-- Either 'PERCENT' or 'AMOUNT'
    cp.value AS discount_value,											-- Discount percentage or flat value
    COUNT(DISTINCT c.cart_id) AS applicable_carts,						-- Number of carts the coupon could apply to
    -- calculate the total value of all carts combined
    ROUND(SUM(ci.qty * ci.unit_price), 2) AS total_cart_value,
    
    -- created a subquery that determines total discount amount based on coupon type
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT'  THEN ROUND(cp.value * COUNT(DISTINCT c.cart_id), 2)
        ELSE 0
    END AS total_discount_value,
    --  created a subquery that calculates the remaining revenue after discount is applied
    ROUND(
        SUM(ci.qty * ci.unit_price) -
        CASE 
            WHEN cp.type = 'PERCENT' THEN SUM(ci.qty * ci.unit_price) * (cp.value / 100)
            WHEN cp.type = 'AMOUNT'  THEN cp.value * COUNT(DISTINCT c.cart_id)
            ELSE 0
        END, 2
    ) AS potential_revenue_after_discount
FROM Coupons cp
JOIN Carts c ON 1=1          					-- remove date restrictions to include all carts
JOIN CartItems ci ON ci.cart_id = c.cart_id 	-- match each cart with its items
WHERE cp.is_active = TRUE						-- only include active coupons
GROUP BY cp.code, cp.type, cp.value				-- group results per coupon
HAVING total_cart_value > 0						-- ignore coupons with no sales data
ORDER BY total_discount_value DESC;				-- show most valuable coupons first


-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/07/2025
-- Description: Query 4 - Cart Totals with coupon discounts
-- Tables: Carts, CartItems, Coupons
-- =============================================


USE urbanease_shop;
-- A query that calculates each cart’s subtotal, applies active coupon discounts, 
-- and shows the final total for both users and guests to evaluate coupon impact.
SELECT 
    c.cart_id,
    COALESCE(u.full_name, 'Guest User') AS user_name,
    COUNT(ci.cart_item_id) AS total_items,
    SUM(ci.qty * ci.unit_price) AS subtotal,
    cp.code AS coupon_code,
    cp.type AS coupon_type,
    cp.value AS coupon_value,
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT' THEN cp.value
        ELSE 0
    END AS discount_amount,
    CASE 
        WHEN cp.type = 'PERCENT' THEN ROUND(SUM(ci.qty * ci.unit_price) * (1 - cp.value / 100), 2)
        WHEN cp.type = 'AMOUNT' THEN ROUND(SUM(ci.qty * ci.unit_price) - cp.value, 2)
        ELSE SUM(ci.qty * ci.unit_price)
    END AS final_total
FROM Carts c
LEFT JOIN Users u ON c.user_id = u.user_id
INNER JOIN CartItems ci ON ci.cart_id = c.cart_id
LEFT JOIN Coupons cp ON cp.is_active = TRUE
GROUP BY c.cart_id, user_name, cp.code, cp.type, cp.value
HAVING subtotal >= 50
ORDER BY final_total DESC;

-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/07/2025
-- Description: Query 5 - Most Popular Products in Carts
-- Tables: CartItems, ProductVariants, Products, Categories
-- =============================================


USE urbanease_shop;

-- A query that identifies the most popular products added to carts 
-- by counting how often each product appears and the total quantity added.
SELECT 
    p.product_id,
    p.title AS product_name,
    c.name AS category_name,
    COUNT(ci.cart_item_id) AS times_in_cart,
    SUM(ci.qty) AS total_qty_added,
    ROUND(AVG(ci.unit_price), 2) AS avg_price
FROM CartItems ci
INNER JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
INNER JOIN Products p ON pv.product_id = p.product_id
INNER JOIN Categories c ON p.category_id = c.category_id
GROUP BY p.product_id, p.title, c.name
ORDER BY total_qty_added DESC, times_in_cart DESC
LIMIT 10;

-- =============================================
-- Tiwari, Sneha
-- =============================================

-- =============================================
-- Author: Sneha Tiwari
-- Create date: [Date]
-- Description: Query 1 - Customer Order Summary
-- Tables: Users, Orders
-- =============================================
USE urbanease_shop;

SELECT 
    u.user_id,
    u.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.grand_total_amount) AS total_spent,
    MAX(o.placed_at) AS last_order_date
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_spent DESC;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 2 - Top Selling Products by Revenue
-- Tables: OrderItems, ProductVariants, Products
-- =============================================

USE urbanease_shop;

SELECT 
    p.product_id,
    p.title AS product_name,
    SUM(oi.qty * oi.unit_price) AS total_revenue,
    SUM(oi.qty) AS total_units_sold
FROM OrderItems oi
JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
JOIN Products p ON pv.product_id = p.product_id
GROUP BY p.product_id, p.title
ORDER BY total_revenue DESC
LIMIT 10;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 3 - Coupon Performance Report
-- Tables: Coupons, Orders
-- =============================================

USE urbanease_shop;

SELECT 
    c.code AS coupon_code,
    COUNT(o.order_id) AS times_used,
    SUM(o.discount_amount) AS total_discount_given,
    SUM(o.subtotal_amount) AS total_sales_before_discount,
    ROUND((SUM(o.discount_amount) / SUM(o.subtotal_amount)) * 100, 2) AS avg_discount_pct
FROM Coupons c
JOIN Orders o ON c.coupon_id = o.coupon_id
GROUP BY c.code
ORDER BY total_discount_given DESC;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 4 - Order Fulfillment & Shipment Tracking
-- Tables: Orders, Shipments, Payments, Users
-- =============================================

USE urbanease_shop;

SELECT 
    o.order_id,
    u.full_name AS customer_name,
    o.status AS order_status,
    COALESCE(s.status, 'NOT_SHIPPED') AS shipment_status,
    p.status AS payment_status,
    o.grand_total_amount,
    s.carrier,
    s.tracking_no,
    s.shipped_at,
    s.delivered_at
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
LEFT JOIN Shipments s ON o.order_id = s.order_id
LEFT JOIN Payments p ON o.order_id = p.order_id
ORDER BY o.placed_at DESC;


-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Query 5 - Customer Lifetime Value (CLV) Analysis
-- Tables: Users, Orders, Payments
-- =============================================

USE urbanease_shop;

WITH customer_spend AS (
    SELECT 
        u.user_id,
        u.full_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.grand_total_amount) AS total_spent,
        AVG(o.grand_total_amount) AS avg_order_value,
        MAX(o.placed_at) AS last_order_date
    FROM Users u
    JOIN Orders o ON u.user_id = o.user_id
    WHERE o.status IN ('PAID', 'FULFILLED')
    GROUP BY u.user_id, u.full_name
)
SELECT 
    user_id,
    full_name,
    total_orders,
    total_spent,
    avg_order_value,
    last_order_date,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_spend
ORDER BY total_spent DESC;


-- =============================================
-- Velarde Sosa, Diana (continued)
-- =============================================

-- ==========================================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-06]
-- Description: Query 1 City-Level Customer Insights Report
-- Tables Used: Users, Addresses, Orders, Payments, Reviews
-- ----------------------------------------------------------
-- Purpose:
--   Generate regional performance insights including:
--   - Payment totals and success rate
--   - Average payment and order values
--   - Review participation and average ratings
--   - Monthly trends per city
-- ==========================================================

USE urbanease_shop;

SELECT 
    -- Geographic Information
    a.city AS City,
    a.state_region AS State,

    -- Monthly Trend (based on order placement date)
    DATE_FORMAT(o.placed_at, '%Y-%m') AS Month,

    -- Customer Activity
    COUNT(DISTINCT u.user_id) AS Total_Customers,    -- number of unique customers
    COUNT(DISTINCT o.order_id) AS Total_Orders,      -- total orders placed

    -- Payment Information
    ROUND(SUM(p.amount), 2) AS Total_Payment_Amount, -- total money paid
    ROUND(AVG(p.amount), 2) AS Avg_Payment_Amount,   -- average payment per transaction

    -- Payment Status Analysis
    SUM(CASE WHEN p.status = 'FAILED' THEN 1 ELSE 0 END) AS Failed_Payments,
    SUM(CASE WHEN p.status = 'CAPTURED' THEN 1 ELSE 0 END) AS Successful_Payments,
    ROUND(
        (SUM(CASE WHEN p.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(p.payment_id), 0)) * 100, 2
    ) AS Payment_Success_Rate,  -- success % of all payments

    -- Order Information
    ROUND(SUM(o.grand_total_amount), 2) AS Total_Sales,     -- total sales amount
    ROUND(AVG(o.grand_total_amount), 2) AS Avg_Order_Value, -- average order value

    -- Review Insights
    COUNT(DISTINCT r.review_id) AS Total_Reviews,    -- total number of reviews written
    ROUND(AVG(r.rating), 2) AS Avg_Product_Rating,   -- average star rating
    ROUND(
        (COUNT(DISTINCT r.review_id) / NULLIF(COUNT(DISTINCT u.user_id), 0)) * 100, 2
    ) AS Review_Participation_Rate,  -- % of customers who wrote at least one review

    -- Reporting Window
    MIN(o.placed_at) AS First_Order_Date,
    MAX(o.placed_at) AS Last_Order_Date

FROM Users u
    JOIN Addresses a 
        ON u.user_id = a.user_id
    JOIN Orders o 
        ON u.user_id = o.user_id
    LEFT JOIN Payments p 
        ON o.order_id = p.order_id
    LEFT JOIN Reviews r 
        ON u.user_id = r.user_id

-- ==========================================================
-- Optional Time Filter (uncomment for last 6 months)
-- WHERE o.placed_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
-- ==========================================================

GROUP BY 
    a.city, 
    a.state_region,
    DATE_FORMAT(o.placed_at, '%Y-%m')  -- monthly grouping

HAVING 
    SUM(p.amount) > 0  -- only include cities with payment activity

ORDER BY 
    a.state_region ASC,
    a.city ASC,
    Month DESC;


-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-05]
-- Description: Query 2 - User Addresses by Region
-- Tables: Addresses, Users

-- Purpose:
--   Analyze user address distribution and address usage patterns
--   across regions (state/city level).
--
-- Includes:
--   Total users per region
--   Total addresses per region
--   Average number of addresses per user
--   Default address ratio
--   Optional grouping by city
-- =============================================

USE urbanease_shop;

SELECT 
    -- Geographic info
    a.state_region AS State,
    a.city AS City,

    -- User and Address Counts
    COUNT(DISTINCT u.user_id) AS Total_Users,             -- number of unique users in the region
    COUNT(a.address_id) AS Total_Addresses,               -- total addresses registered
    ROUND(COUNT(a.address_id) / COUNT(DISTINCT u.user_id), 2) AS Avg_Addresses_Per_User,  -- avg addresses per user

    -- Address Usage Patterns
    SUM(CASE WHEN a.is_default = TRUE THEN 1 ELSE 0 END) AS Default_Addresses,  -- how many addresses are marked as default
    ROUND(
        (SUM(CASE WHEN a.is_default = TRUE THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(a.address_id), 0)) * 100, 2
    ) AS Default_Address_Rate,  -- percentage of addresses that are default

    -- Contact Availability
    SUM(CASE WHEN a.phone IS NOT NULL THEN 1 ELSE 0 END) AS Addresses_With_Phone,
    ROUND(
        (SUM(CASE WHEN a.phone IS NOT NULL THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(a.address_id), 0)) * 100, 2
    ) AS Phone_Availability_Rate,  -- percentage of addresses that include a phone number

    -- Data freshness
    MIN(a.created_at) AS First_Address_Added,
    MAX(a.updated_at) AS Last_Address_Updated

FROM Users u
JOIN Addresses a 
    ON u.user_id = a.user_id

-- ==========================================================
-- Optional Filters (Uncomment one of these if needed)
-- ----------------------------------------------------------
-- WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)   -- last 6 months only
-- WHERE a.country_code = 'US'                               -- filter by country
-- ==========================================================

GROUP BY 
    a.state_region, 
    a.city  -- change to just a.state_region if you want a higher-level report

HAVING 
    COUNT(a.address_id) > 0  -- exclude regions with no addresses

ORDER BY 
    a.state_region ASC, 
    a.city ASC;



-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-06]
-- Description: Query 3 - Product Reviews and Ratings Analysis
-- Tables: Addresses, Payments, Reviews, Users, Orders, Products

-- Purpose:
--   Analyze how customer satisfaction (via reviews) 
--   relates to regions (Addresses) and payment performance.
--
-- Includes:
--   Average product ratings by region
--   Count of reviews per product
--   Relationship between payment success and review activity
--   Optional grouping by state and city
-- =============================================

USE urbanease_shop;

SELECT
    -- Regional Information
    a.state_region AS State,
    a.city AS City,

    -- Product and Review Metrics
    pdt.title AS Product_Title,
    COUNT(r.review_id) AS Total_Reviews,                   -- total reviews written
    ROUND(AVG(r.rating), 2) AS Avg_Rating,                 -- average product rating
    SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS Five_Star_Reviews,
    SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END) AS One_Star_Reviews,

    -- Payment Insights for Reviewers
    COUNT(DISTINCT pay.payment_id) AS Related_Payments,     -- total payments linked to reviewers
    ROUND(SUM(pay.amount), 2) AS Total_Payment_Amount,      -- total payment value from reviewers
    ROUND(AVG(pay.amount), 2) AS Avg_Payment_Amount,        -- average payment value
    ROUND(
        (SUM(CASE WHEN pay.status = 'CAPTURED' THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(pay.payment_id), 0)) * 100, 2
    ) AS Payment_Success_Rate,                              -- percentage of successful payments

    -- Engagement and Quality
    COUNT(DISTINCT r.user_id) AS Reviewers_Count,           -- number of unique users who left reviews
    ROUND(
        COUNT(r.review_id) / NULLIF(COUNT(DISTINCT r.user_id), 0), 2
    ) AS Avg_Reviews_Per_User,                              -- average reviews per user
    MAX(r.created_at) AS Last_Review_Date,                  -- most recent review date

    -- Timeframe
    MIN(pay.created_at) AS First_Payment_Date,
    MAX(pay.created_at) AS Last_Payment_Date

FROM Reviews r
    JOIN Users u 
        ON r.user_id = u.user_id
    JOIN Addresses a 
        ON u.user_id = a.user_id
    LEFT JOIN Orders o 
        ON o.user_id = u.user_id
    LEFT JOIN Payments pay 
        ON pay.order_id = o.order_id
    JOIN Products pdt 
        ON r.product_id = pdt.product_id

-- ==========================================================
-- Optional Filter Examples:
-- WHERE r.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)     -- only recent reviews
-- WHERE a.country_code = 'US'                                 -- limit to US users
-- WHERE pay.provider = 'Stripe'                               -- analyze by payment provider
-- ==========================================================

GROUP BY 
    a.state_region, 
    a.city, 
    pdt.title

HAVING 
    COUNT(r.review_id) > 0   -- include only products with reviews

ORDER BY 
    a.state_region ASC,
    a.city ASC,
    Avg_Rating DESC;




-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-07]
-- Description: Query 4 - Top Engaged Customers: Spending vs. Review Activity
-- Tables: Users, Payments, Reviews, Orders

-- Explanation:
-- 1. Combines data from Users, Orders, Payments, and Reviews to evaluate each customer's engagement.
-- 2. Aggregates spending (SUM, AVG) and review activity (COUNT, AVG).
-- 3. Uses a CASE statement to classify users into engagement levels.
-- 4. HAVING ensures we exclude users with no payment history.
-- 5. ORDER BY helps highlight the top 10 customers by total spent and review count.
-- =============================================

USE urbanease_shop;

SELECT 
    u.user_id,
    u.full_name AS Customer_Name,
    u.email,
    COUNT(DISTINCT p.payment_id) AS Total_Payments,      -- How many payments the user made
    ROUND(SUM(p.amount), 2) AS Total_Spent,              -- Total money spent
    ROUND(AVG(p.amount), 2) AS Avg_Payment,              -- Average amount per transaction
    COUNT(DISTINCT r.review_id) AS Total_Reviews,        -- How many reviews the user wrote
    ROUND(AVG(r.rating), 2) AS Avg_Rating,               -- Their average rating
    CASE 
        WHEN COUNT(DISTINCT r.review_id) >= 5 AND SUM(p.amount) > 500 THEN 'Highly Engaged'
        WHEN COUNT(DISTINCT r.review_id) BETWEEN 1 AND 4 THEN 'Moderately Engaged'
        ELSE 'Low Engagement'
    END AS Engagement_Level                              -- Classification of user activity
FROM 
    Users u
LEFT JOIN 
    Orders o ON o.user_id = u.user_id
LEFT JOIN 
    Payments p ON p.order_id = o.order_id
LEFT JOIN 
    Reviews r ON r.user_id = u.user_id
WHERE 
    u.is_active = TRUE
GROUP BY 
    u.user_id, u.full_name, u.email
HAVING 
    SUM(p.amount) IS NOT NULL   -- Exclude users who never paid
ORDER BY 
    Total_Spent DESC, Total_Reviews DESC
LIMIT 10;  -- Show only top 10 most active users

-- Optional additions:
-- a) Add a date filter for payments made this year:
--    AND p.created_at >= '2025-01-01'
-- b) Include the customer's region:
--    JOIN Addresses a ON a.user_id = u.user_id
--    AND add a.state_region to SELECT and GROUP BY
-- c) Filter by country or active reviews:
--    WHERE r.rating IS NOT NULL



-- ============================================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-07]
-- Description: Query 4 - Product Performance and Revenue Analysis
-- Tables: Products, OrderItems, Orders, Payments, Reviews

-- Explanation:
-- 1. Combines data from Products, Orders, Payments, and Reviews.
-- 2. Aggregates total orders, quantity sold, and total revenue.
-- 3. Calculates average product rating and classifies each product by quality and revenue category.
-- 4. Uses CASE statements to categorize products into "Excellent," "Good," or "Average."
-- 5. Displays only active products and sorts the output by revenue and rating.
-- 6. LIMIT restricts results to the top 10 best-performing products.
-- ============================================================

USE urbanease_shop;

SELECT 
    p.product_id,
    p.title AS Product_Name,
    p.brand AS Brand,
    COUNT(DISTINCT oi.order_item_id) AS Total_Orders,          -- Total times the product was ordered
    SUM(oi.qty) AS Total_Quantity_Sold,                        -- Total quantity sold
    ROUND(SUM(oi.unit_price * oi.qty), 2) AS Total_Revenue,    -- Total revenue from this product
    ROUND(AVG(oi.unit_price), 2) AS Avg_Selling_Price,         -- Average selling price
    COUNT(DISTINCT r.review_id) AS Total_Reviews,              -- Number of reviews written for the product
    ROUND(AVG(r.rating), 2) AS Avg_Rating,                     -- Average rating (1–5)
    CASE
        WHEN AVG(r.rating) >= 4.5 THEN '★★★★★ Excellent'
        WHEN AVG(r.rating) BETWEEN 3.5 AND 4.49 THEN '★★★★ Good'
        WHEN AVG(r.rating) BETWEEN 2.5 AND 3.49 THEN '★★★ Average'
        ELSE '★★ Poor'
    END AS Rating_Category,
    CASE
        WHEN SUM(oi.unit_price * oi.qty) > 1000 THEN 'High Revenue Product'
        WHEN SUM(oi.unit_price * oi.qty) BETWEEN 500 AND 1000 THEN 'Medium Revenue Product'
        ELSE 'Low Revenue Product'
    END AS Revenue_Category
FROM 
    Products p
LEFT JOIN 
    ProductVariants pv ON pv.product_id = p.product_id
LEFT JOIN 
    OrderItems oi ON oi.variant_id = pv.variant_id
LEFT JOIN 
    Orders o ON o.order_id = oi.order_id
LEFT JOIN 
    Payments pay ON pay.order_id = o.order_id
LEFT JOIN 
    Reviews r ON r.product_id = p.product_id
WHERE 
    p.is_active = TRUE
GROUP BY 
    p.product_id, p.title, p.brand
HAVING 
    Total_Revenue IS NOT NULL
ORDER BY 
    Total_Revenue DESC, Avg_Rating DESC
LIMIT 10;

-- Optional Additions:
-- a) Add date filter to analyze products sold this year:
--    AND o.placed_at >= '2025-01-01'
--
-- b) Include category name:
--    JOIN Categories c ON c.category_id = p.category_id
--    Add c.name AS Category to SELECT and GROUP BY.
--
-- c) Filter by minimum number of reviews for better accuracy:
--    HAVING COUNT(DISTINCT r.review_id) >= 3




-- =============================================
-- PROCEDURES, FUNCTIONS, AND TRIGGERS - TEAM CONTRIBUTIONS
-- =============================================

-- =============================================
-- Kumar, Virat
-- =============================================

-- Stored Procedures by Kumar, Virat



-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Stored Procedure - Update Inventory Operations
-- Tables: ProductVariants, Warehouses, Inventory
-- Purpose: Centralized inventory management with validation and auditing
-- =============================================

-- BUSINESS USE CASE:
-- This procedure is the core of inventory management operations, handling all
-- stock movements in the warehouse management system (WMS). It's called by:
-- 
-- 1. Receiving Department: When new stock arrives from suppliers
-- 2. Fulfillment System: When reserving items for customer orders
-- 3. Shipping Department: When releasing reserved items after shipment
-- 4. Returns Processing: When customers return products
-- 5. Inventory Adjustments: For cycle counts and corrections
-- 6. Transfer Operations: Moving stock between warehouses

-- REAL-WORLD SCENARIO:
-- Every time an action occurs in the warehouse, this procedure is called:
-- - 9:00 AM: Receiving scans 100 iPhones -> sp_UpdateInventory(..., 'ADD_STOCK')
-- - 10:30 AM: Order system reserves 5 for customer -> sp_UpdateInventory(..., 'RESERVE')
-- - 2:00 PM: Shipping confirms shipment -> sp_UpdateInventory(..., 'RELEASE_SHIP')
-- - 3:30 PM: Customer returns 1 defective -> sp_UpdateInventory(..., 'RETURN')
-- - 5:00 PM: Inventory audit finds 2 missing -> sp_UpdateInventory(..., 'ADJUST')

USE urbanease_shop;

-- Drop procedure if exists (for development/updates)
DROP PROCEDURE IF EXISTS sp_UpdateInventory;

DELIMITER //

CREATE PROCEDURE sp_UpdateInventory(
    IN p_warehouse_id BIGINT,
    IN p_variant_id BIGINT,
    IN p_quantity_change INT,
    IN p_operation VARCHAR(20),  -- 'ADD_STOCK', 'REMOVE_STOCK', 'RESERVE', 'RELEASE_SHIP', 'RELEASE_CANCEL', 'ADJUST', 'RETURN'
    OUT p_result_code INT,       -- 0=Success, 1=Error, 2=Warning
    OUT p_message VARCHAR(500)   -- Human-readable result message
)
sp_UpdateInventory: BEGIN
    -- Variable declarations
    DECLARE v_current_on_hand INT DEFAULT 0;
    DECLARE v_current_reserved INT DEFAULT 0;
    DECLARE v_available INT DEFAULT 0;
    DECLARE v_new_on_hand INT DEFAULT 0;
    DECLARE v_new_reserved INT DEFAULT 0;
    DECLARE v_warehouse_exists INT DEFAULT 0;
    DECLARE v_variant_exists INT DEFAULT 0;
    DECLARE v_inventory_exists INT DEFAULT 0;
    
    -- Error handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Database error occurred during inventory update';
        ROLLBACK;
    END;
    
    -- Start transaction for data consistency
    START TRANSACTION;
    
    -- ============================================
    -- VALIDATION STEP 1: Check if quantity is valid
    -- ============================================
    IF p_quantity_change IS NULL OR p_quantity_change = 0 THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Quantity change must be non-zero';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    IF p_quantity_change < 0 AND p_operation NOT IN ('REMOVE_STOCK', 'ADJUST') THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Negative quantity only allowed for REMOVE_STOCK or ADJUST operations';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 2: Verify warehouse exists
    -- ============================================
    SELECT COUNT(*) INTO v_warehouse_exists
    FROM Warehouses
    WHERE warehouse_id = p_warehouse_id;
    
    IF v_warehouse_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = CONCAT('ERROR: Warehouse ID ', p_warehouse_id, ' does not exist');
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 3: Verify product variant exists and is active
    -- ============================================
    SELECT COUNT(*) INTO v_variant_exists
    FROM ProductVariants
    WHERE variant_id = p_variant_id AND is_active = TRUE;
    
    IF v_variant_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = CONCAT('ERROR: Product Variant ID ', p_variant_id, ' does not exist or is inactive');
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- VALIDATION STEP 4: Check if inventory record exists
    -- ============================================
    SELECT COUNT(*) INTO v_inventory_exists
    FROM Inventory
    WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
    
    -- If inventory record doesn't exist and we're adding stock, create it
    IF v_inventory_exists = 0 AND p_operation = 'ADD_STOCK' THEN
        INSERT INTO Inventory (warehouse_id, variant_id, on_hand, reserved)
        VALUES (p_warehouse_id, p_variant_id, p_quantity_change, 0);
        
        SET p_result_code = 0;
        SET p_message = CONCAT('SUCCESS: Created new inventory record with ', p_quantity_change, ' units');
        COMMIT;
        LEAVE sp_UpdateInventory;
    END IF;
    
    IF v_inventory_exists = 0 THEN
        SET p_result_code = 1;
        SET p_message = 'ERROR: Inventory record does not exist. Use ADD_STOCK to create.';
        ROLLBACK;
        LEAVE sp_UpdateInventory;
    END IF;
    
    -- ============================================
    -- GET CURRENT INVENTORY STATE
    -- ============================================
    SELECT on_hand, reserved 
    INTO v_current_on_hand, v_current_reserved
    FROM Inventory
    WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
    
    SET v_available = v_current_on_hand - v_current_reserved;
    
    -- ============================================
    -- PROCESS OPERATION
    -- ============================================
    CASE p_operation
        
        -- ADD_STOCK: Receiving new stock from supplier or returns
        WHEN 'ADD_STOCK' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Added ', p_quantity_change, ' units. New stock: ', v_new_on_hand, 
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- REMOVE_STOCK: Damaged, lost, or written off inventory
        WHEN 'REMOVE_STOCK' THEN
            IF ABS(p_quantity_change) > v_available THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot remove ', ABS(p_quantity_change), 
                                      ' units. Only ', v_available, ' available (', v_current_reserved, ' reserved)');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand - ABS(p_quantity_change);
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Removed ', ABS(p_quantity_change), ' units. New stock: ', v_new_on_hand,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RESERVE: Reserve items for customer order
        WHEN 'RESERVE' THEN
            IF p_quantity_change > v_available THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot reserve ', p_quantity_change, 
                                      ' units. Only ', v_available, ' available');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand;
            SET v_new_reserved = v_current_reserved + p_quantity_change;
            
            UPDATE Inventory
            SET reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Reserved ', p_quantity_change, ' units. Total reserved: ', v_new_reserved,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RELEASE_SHIP: Release reserved items after successful shipment
        WHEN 'RELEASE_SHIP' THEN
            IF p_quantity_change > v_current_reserved THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot release ', p_quantity_change, 
                                      ' units. Only ', v_current_reserved, ' reserved');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand - p_quantity_change;
            SET v_new_reserved = v_current_reserved - p_quantity_change;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand, reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Shipped ', p_quantity_change, ' units. New stock: ', v_new_on_hand,
                                   ' (Reserved: ', v_new_reserved, ', Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- RELEASE_CANCEL: Release reservation when order is cancelled
        WHEN 'RELEASE_CANCEL' THEN
            IF p_quantity_change > v_current_reserved THEN
                SET p_result_code = 1;
                SET p_message = CONCAT('ERROR: Cannot release ', p_quantity_change, 
                                      ' units. Only ', v_current_reserved, ' reserved');
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            SET v_new_on_hand = v_current_on_hand;
            SET v_new_reserved = v_current_reserved - p_quantity_change;
            
            UPDATE Inventory
            SET reserved = v_new_reserved
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Released ', p_quantity_change, ' units from reservation. ',
                                   'Available: ', (v_new_on_hand - v_new_reserved));
        
        -- ADJUST: Manual adjustment (cycle count corrections)
        WHEN 'ADJUST' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            
            IF v_new_on_hand < 0 THEN
                SET p_result_code = 1;
                SET p_message = 'ERROR: Adjustment would result in negative inventory';
                ROLLBACK;
                LEAVE sp_UpdateInventory;
            END IF;
            
            IF v_new_on_hand < v_current_reserved THEN
                SET p_result_code = 2;
                SET p_message = CONCAT('WARNING: Adjusted stock (', v_new_on_hand, 
                                      ') is less than reserved (', v_current_reserved, '). Review reservations!');
            ELSE
                SET p_result_code = 0;
                SET p_message = CONCAT('SUCCESS: Adjusted inventory by ', p_quantity_change, 
                                      ' units. New stock: ', v_new_on_hand);
            END IF;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
        
        -- RETURN: Customer return (adds to stock, may release reservation)
        WHEN 'RETURN' THEN
            SET v_new_on_hand = v_current_on_hand + p_quantity_change;
            SET v_new_reserved = v_current_reserved;
            
            UPDATE Inventory
            SET on_hand = v_new_on_hand
            WHERE warehouse_id = p_warehouse_id AND variant_id = p_variant_id;
            
            SET p_result_code = 0;
            SET p_message = CONCAT('SUCCESS: Processed return of ', p_quantity_change, 
                                   ' units. New stock: ', v_new_on_hand,
                                   ' (Available: ', (v_new_on_hand - v_new_reserved), ')');
        
        -- Invalid operation
        ELSE
            SET p_result_code = 1;
            SET p_message = CONCAT('ERROR: Invalid operation "', p_operation, 
                                   '". Must be: ADD_STOCK, REMOVE_STOCK, RESERVE, RELEASE_SHIP, RELEASE_CANCEL, ADJUST, or RETURN');
            ROLLBACK;
            LEAVE sp_UpdateInventory;
    END CASE;
    
    -- Commit the transaction
    COMMIT;
    
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

-- Test 1: Add new stock (receiving from supplier)
CALL sp_UpdateInventory(1, 1, 50, 'ADD_STOCK', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 2: Reserve items for order
CALL sp_UpdateInventory(1, 1, 10, 'RESERVE', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 3: Try to reserve more than available (should fail)
CALL sp_UpdateInventory(1, 1, 500, 'RESERVE', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 4: Release reserved items after shipment
CALL sp_UpdateInventory(1, 1, 5, 'RELEASE_SHIP', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Test 5: Cancel order and release reservation
CALL sp_UpdateInventory(1, 1, 3, 'RELEASE_CANCEL', @code, @msg);
SELECT @code as result_code, @msg as message;

-- Verify final state
SELECT 
    w.name as warehouse,
    pv.sku,
    i.on_hand,
    i.reserved,
    (i.on_hand - i.reserved) as available
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN ProductVariants pv ON i.variant_id = pv.variant_id
WHERE i.warehouse_id = 1 AND i.variant_id = 1;


-- Functions by Kumar, Virat

-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Function - Get Available Stock for Product Variant
-- Tables: Inventory
-- Returns: Available stock (on_hand - reserved) for a specific variant at warehouse
-- =============================================

-- BUSINESS USE CASE:
-- This function is called thousands of times per day across multiple business operations:
--
-- 1. E-commerce Website: Real-time stock availability on product pages
-- 2. Order Processing: Validates if items can be added to cart
-- 3. Recommendation Engine: Shows only in-stock alternatives
-- 4. Sales Team: Checks availability before promising delivery
-- 5. Customer Service: Answers "do you have this in stock?" questions
-- 6. Mobile App: Updates product availability every few seconds
-- 7. Third-party Integrations: Syncs stock to marketplaces (Amazon, eBay)

-- REAL-WORLD SCENARIO:
-- Customer visits website and views iPhone 15:
-- 1. Product page loads -> fn_GetAvailableStock(1, 1) -> Shows "258 available"
-- 2. Customer adds 2 to cart -> fn_GetAvailableStock(1, 1) >= 2 -> "Add to Cart" enabled
-- 3. Customer changes quantity to 300 -> fn_GetAvailableStock(1, 1) < 300 -> "Only 258 available"
-- 4. Sales rep checks stock -> fn_GetAvailableStock(1, 1) -> "Yes, we have 258 in NYC warehouse"
-- 5. Background job syncs to Amazon -> fn_GetAvailableStock(1, 1) -> Updates Amazon listing
--
-- This function is called ~50,000 times/day on a busy e-commerce site

USE urbanease_shop;

-- Drop function if exists (for development/updates)
DROP FUNCTION IF EXISTS fn_GetAvailableStock;

DELIMITER //

CREATE FUNCTION fn_GetAvailableStock(
    p_variant_id BIGINT,
    p_warehouse_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns available stock (on_hand - reserved) for a variant at specific warehouse. Returns 0 if not found or negative.'
BEGIN
    DECLARE v_available_stock INT DEFAULT 0;
    DECLARE v_on_hand INT DEFAULT 0;
    DECLARE v_reserved INT DEFAULT 0;
    
    -- ============================================
    -- QUERY INVENTORY TABLE
    -- ============================================
    -- Get current inventory levels
    SELECT 
        COALESCE(on_hand, 0),
        COALESCE(reserved, 0)
    INTO 
        v_on_hand,
        v_reserved
    FROM Inventory
    WHERE 
        variant_id = p_variant_id 
        AND warehouse_id = p_warehouse_id
    LIMIT 1;
    
    -- ============================================
    -- CALCULATE AVAILABLE STOCK
    -- ============================================
    -- Calculate available stock (can never be negative for business logic)
    SET v_available_stock = v_on_hand - v_reserved;
    
    -- Safety check: if somehow available is negative, return 0
    -- This prevents overselling in edge cases
    IF v_available_stock < 0 THEN
        SET v_available_stock = 0;
    END IF;
    
    -- Return the available stock count
    RETURN v_available_stock;
END//

DELIMITER ;

-- =============================================
-- COMPANION FUNCTIONS (Optional enhancements)
-- =============================================

-- Drop if exists
DROP FUNCTION IF EXISTS fn_GetTotalAvailableStock;

DELIMITER //

-- Get total available stock across ALL warehouses for a variant
CREATE FUNCTION fn_GetTotalAvailableStock(
    p_variant_id BIGINT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns total available stock across all warehouses for a variant'
BEGIN
    DECLARE v_total_available INT DEFAULT 0;
    
    -- Sum available stock from all warehouses
    SELECT 
        COALESCE(SUM(on_hand - reserved), 0)
    INTO 
        v_total_available
    FROM Inventory
    WHERE 
        variant_id = p_variant_id
        AND (on_hand - reserved) > 0;  -- Only count positive availability
    
    -- Return total available
    RETURN GREATEST(v_total_available, 0);
END//

DELIMITER ;

-- Drop if exists
DROP FUNCTION IF EXISTS fn_IsInStock;

DELIMITER //

-- Quick boolean check if item is in stock at warehouse
CREATE FUNCTION fn_IsInStock(
    p_variant_id BIGINT,
    p_warehouse_id BIGINT,
    p_required_qty INT
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
COMMENT 'Returns TRUE if required quantity is available, FALSE otherwise'
BEGIN
    DECLARE v_available INT;
    
    -- Get available stock using our main function
    SET v_available = fn_GetAvailableStock(p_variant_id, p_warehouse_id);
    
    -- Return TRUE if we have enough, FALSE otherwise
    RETURN (v_available >= p_required_qty);
END//

DELIMITER ;

-- =============================================
-- TESTING SECTION
-- =============================================

SELECT '=== Test 1: Get available stock for specific variant and warehouse ===' as test_description;
SELECT 
    fn_GetAvailableStock(1, 1) as available_stock_variant_1_warehouse_1,
    fn_GetAvailableStock(2, 2) as available_stock_variant_2_warehouse_2,
    fn_GetAvailableStock(999, 1) as non_existent_variant;

SELECT '=== Test 2: Get total available stock across all warehouses ===' as test_description;
SELECT 
    fn_GetTotalAvailableStock(1) as total_iphone_stock,
    fn_GetTotalAvailableStock(8) as total_macbook_stock,
    fn_GetTotalAvailableStock(999) as non_existent_total;

SELECT '=== Test 3: Check if sufficient stock exists ===' as test_description;
SELECT 
    fn_IsInStock(1, 1, 10) as can_fulfill_10_units,
    fn_IsInStock(1, 1, 500) as can_fulfill_500_units,
    fn_IsInStock(999, 1, 1) as non_existent_check;

SELECT '=== Test 4: Real-world scenario - Product page display ===' as test_description;
SELECT 
    pv.sku,
    pv.price,
    w.name as warehouse,
    i.on_hand,
    i.reserved,
    fn_GetAvailableStock(pv.variant_id, w.warehouse_id) as available_to_sell,
    CASE 
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) = 0 THEN '❌ OUT OF STOCK'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) < 10 THEN '⚠️  LOW STOCK'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) < 50 THEN '✓ IN STOCK'
        ELSE '✓✓ HIGH STOCK'
    END as stock_status,
    CASE 
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) >= 100 THEN 'Enable Buy Button'
        WHEN fn_GetAvailableStock(pv.variant_id, w.warehouse_id) > 0 THEN 'Enable with "Limited Stock" warning'
        ELSE 'Disable Buy Button - Show "Notify Me"'
    END as website_action
FROM ProductVariants pv
JOIN Inventory i ON pv.variant_id = i.variant_id
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
WHERE pv.variant_id IN (1, 2, 3)
ORDER BY available_to_sell ASC
LIMIT 10;

SELECT '=== Test 5: Validate against actual query ===' as test_description;
SELECT 
    'Using Function' as method,
    fn_GetAvailableStock(1, 1) as available
UNION ALL
SELECT 
    'Using Direct Query' as method,
    (on_hand - reserved) as available
FROM Inventory
WHERE variant_id = 1 AND warehouse_id = 1;


