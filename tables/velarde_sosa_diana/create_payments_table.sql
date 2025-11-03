-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [Date]
-- Description: Create Payments Table
-- Module: User Addresses, Payments & Reviews
-- Note: Requires Orders table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS Payments;

CREATE TABLE Payments (
  payment_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT       NOT NULL,
  provider     VARCHAR(40)  NOT NULL,  -- Stripe/PayPal/etc.
  provider_ref VARCHAR(120) NULL,
  amount       DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
  status       VARCHAR(20)   NOT NULL CHECK (status IN ('INITIATED','AUTHORIZED','CAPTURED','FAILED','REFUNDED')),
  paid_at      DATETIME      NULL,
  created_at   DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP(),
  CONSTRAINT FK_Payment_Order FOREIGN KEY (order_id) REFERENCES Orders(order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE Payments COMMENT = 'Payment transaction records for orders';

-- Create indexes for lookups
CREATE INDEX IX_Payments_Order ON Payments(order_id);
CREATE INDEX IX_Payments_Status ON Payments(status);

-- Verify table creation
DESC Payments;

-- Example: Insert sample payments
/*
INSERT INTO Payments (order_id, provider, provider_ref, amount, status, paid_at) VALUES 
  (1, 'Stripe', 'ch_1234567890abcdef', 1959.99, 'CAPTURED', '2024-11-01 09:30:00'),
  (2, 'PayPal', 'PAYID-MABCDEF123456', 299.99, 'CAPTURED', '2024-10-28 14:15:00');
*/

-- Example: Query to see payment history
-- SELECT 
--   p.payment_id,
--   o.order_id,
--   u.email as customer,
--   p.provider,
--   p.amount,
--   p.status,
--   p.paid_at
-- FROM Payments p
-- JOIN Orders o ON p.order_id = o.order_id
-- JOIN Users u ON o.user_id = u.user_id
-- ORDER BY p.created_at DESC;

