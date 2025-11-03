-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: [Date]
-- Description: Create UserRoles Table (Junction Table)
-- Module: User Management & Authentication
-- Note: Requires Users and Roles tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS UserRoles;

CREATE TABLE UserRoles (
  user_id BIGINT NOT NULL,
  role_id INT NOT NULL,
  assigned_at DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  PRIMARY KEY (user_id, role_id),
  CONSTRAINT FK_UserRoles_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
  CONSTRAINT FK_UserRoles_Role FOREIGN KEY (role_id) REFERENCES Roles(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE UserRoles COMMENT = 'Many-to-many relationship between Users and Roles';

-- Verify table creation
DESC UserRoles;

-- Example: Assign roles to users
/*
-- Assign Admin role to user_id 1
INSERT INTO UserRoles (user_id, role_id) VALUES (1, 1);

-- Assign Customer role to user_id 2
INSERT INTO UserRoles (user_id, role_id) VALUES (2, 2);
*/

-- Example: Query to verify data
-- SELECT u.email, r.role_name, ur.assigned_at
-- FROM UserRoles ur
-- JOIN Users u ON ur.user_id = u.user_id
-- JOIN Roles r ON ur.role_id = r.role_id;

