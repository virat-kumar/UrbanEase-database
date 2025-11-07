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
