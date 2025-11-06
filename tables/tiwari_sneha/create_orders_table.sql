-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Create Orders Table
-- Module: Order Management & Fulfillment
-- Note: Requires Users, Coupons, and Addresses tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Orders;

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
  placed_at           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  CONSTRAINT FK_Order_User     FOREIGN KEY (user_id)             REFERENCES Users(user_id),
  CONSTRAINT FK_Order_Coupon   FOREIGN KEY (coupon_id)           REFERENCES Coupons(coupon_id),
  CONSTRAINT FK_Order_ShipAdr  FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
  CONSTRAINT FK_Order_BillAdr  FOREIGN KEY (billing_address_id)  REFERENCES Addresses(address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Orders COMMENT = 'Order header with totals, status, and addresses';

-- Create indexes for lookups
CREATE INDEX IX_Order_User ON Orders(user_id);
CREATE INDEX IX_Order_Status ON Orders(status);

-- Verify table creation
DESC Orders;

INSERT INTO Addresses (
  user_id, label, name, line1, city, state_region,
  postal_code, country_code, phone, is_default, created_at, updated_at
)
VALUES
  (1, 'Home', 'Sneha Tiwari', '123 Main St', 'Dallas', 'TX', '75001', 'US', '1234567890', 1, NOW(), NOW()),
  (2, 'Office', 'Ritik Jaiswal', '456 Park Ave', 'Richardson', 'TX', '75080', 'US', '9876543210', 0, NOW(), NOW()),
  (3, 'Home', 'Demo User', '789 Elm St', 'Plano', 'TX', '75074', 'US', '5555555555', 1, NOW(), NOW());


-- Example: Insert sample order
INSERT INTO Orders (
  user_id, status,
  subtotal_amount, discount_amount, shipping_amount, tax_amount,
  coupon_id, shipping_address_id, billing_address_id
) VALUES
  (2, 'PENDING',   1999.98, 199.99, 15.00, 145.00, 1, 1, 1),
  (1, 'PAID',       899.50,  50.00, 10.00,  72.00, 1, 1, 2),
  (3, 'FULFILLED',  450.00,  25.00,  5.00,  35.00, NULL, 1, 1),
  (2, 'PAID',      1200.00, 100.00, 15.00,  90.00, 2, 3, 3),
  (1, 'CANCELLED',  650.00,  75.00,  0.00,  55.00, NULL, 1, 2),
  (2, 'PAID',       780.00,  80.00,  0.00,  60.00, 1, 3, 3),
  (3, 'PENDING',    499.99,   0.00, 10.00,  35.00, NULL, 1, 1),
  (1, 'REFUNDED',   250.00,  25.00,  0.00,  20.00, NULL, 1, 2),
  (2, 'FULFILLED',  455.00,  10.00,  5.00,  30.00, NULL, 3, 3),
  (3, 'PAID',       999.99,   0.00, 12.00,  80.00, NULL, 1, 1),
  (1, 'PENDING',   1589.96,  50.00,  0.00, 110.00, NULL, 2, 2),
  (2, 'CANCELLED',  300.00,   0.00,  0.00,  22.00, NULL, 3, 3),
  (3, 'PAID',       875.00,  75.00,  0.00,  65.00, 1, 1, 1),
  (1, 'FULFILLED',  220.00,   0.00,  5.00,  18.00, NULL, 2, 2),
  (2, 'PAID',       640.00,  20.00,  8.00,  45.00, NULL, 3, 3);
