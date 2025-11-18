-- ============================================================
-- Author:       Bajwa, Achint Kaur
-- Create date:  2025-11
-- Trigger:      tr_AuditUserChanges
-- Schema:       urbanease_shop
-- Description:  Audit Trigger - Tracks all updates to Users table
-- Tables:       Users, UsersAudit
-- Purpose:      Log key user attribute changes and maintain
--               update timestamp consistency.
-- ============================================================

-- ============================================================
-- Business Objectives:
-- 1) Provide complete traceability for changes made to user accounts
--    by storing historical data (old and new values).
--
-- 2) Support accountability and compliance requirements for security
--    by recording who made the change (`changed_by`) and when.
--
-- 3) Allow administrators and auditors to review all profile changes,
--    including updates to email, full name, and activation status.
--
-- 4) Ensure the `updated_at` field always reflects the most recent
--    modification, regardless of how or where the update occurs.
--
-- 5) Improve debugging and forensic analysis by maintaining an
--    independent audit trail that cannot be overwritten.
-- ============================================================

USE urbanease_shop;

DROP TRIGGER IF EXISTS tr_AuditUserChanges;
DELIMITER //

CREATE TRIGGER tr_AuditUserChanges
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    -- Always update last modified timestamp
    SET NEW.updated_at = CURRENT_TIMESTAMP;

    -- Insert audit row only when relevant fields change
    IF 
        OLD.email      <> NEW.email OR
        OLD.full_name  <> NEW.full_name OR
        OLD.is_active  <> NEW.is_active
    THEN
        INSERT INTO UsersAudit (
            user_id,
            old_email,     new_email,
            old_full_name, new_full_name,
            old_is_active, new_is_active,
            changed_at,
            changed_by
        )
        VALUES (
            OLD.user_id,
            OLD.email,       NEW.email,
            OLD.full_name,   NEW.full_name,
            OLD.is_active,   NEW.is_active,
            CURRENT_TIMESTAMP,
            CURRENT_USER()   -- logs the MySQL user who performed the update
        );
    END IF;

END //
DELIMITER ;
