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
  placed_at           DATETIME NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at          DATETIME NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
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

-- Example: Insert sample order
/*
INSERT INTO Orders (user_id, status, subtotal_amount, discount_amount, shipping_amount, tax_amount, coupon_id, shipping_address_id, billing_address_id) 
VALUES (2, 'PENDING', 1999.98, 199.99, 15.00, 145.00, 1, 1, 1);
*/

-- Example: Query to see orders with user info
-- SELECT 
--   o.order_id,
--   u.email,
--   o.status,
--   o.grand_total_amount,
--   o.placed_at
-- FROM Orders o
-- JOIN Users u ON o.user_id = u.user_id
-- ORDER BY o.placed_at DESC;

