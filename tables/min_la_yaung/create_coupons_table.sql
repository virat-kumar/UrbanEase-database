-- =============================================
-- Author: Min, La Yaung
-- Create date: 11/03/2025
-- Description: Create Coupons Table
-- Module: Shopping Cart & Promotions
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Coupons;

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

-- Add comments to document table purpose
ALTER TABLE Coupons COMMENT = 'Promotional discount coupons with rules and validity';

-- Create index for code lookups
CREATE INDEX IX_Coupon_Code ON Coupons(code);

-- Verify table creation
DESC Coupons;

-- Added sample values into Coupons table
INSERT INTO Coupons (code, type, value, starts_at, expires_at, min_subtotal, is_active) VALUES 
  ('SAVE10', 'PERCENT', 10.00, '2024-01-01', '2024-12-31', 50.00, TRUE),
  ('FREESHIP', 'AMOUNT', 15.00, '2024-01-01', '2024-06-30', 100.00, TRUE),
  ('WELCOME20', 'PERCENT', 20.00, '2024-01-01', '2024-12-31', NULL, TRUE),
  ('FLASH50', 'AMOUNT', 50.00, '2024-11-01', '2024-11-30', 200.00, TRUE);
  
-- Viewing sample values in Coupons table
select * from Carts;
