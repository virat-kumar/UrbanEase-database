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

INSERT INTO Payments (order_id, provider, provider_ref, amount, status, paid_at)
VALUES
(1, 'Stripe', 'STR12345', 120.50, 'CAPTURED', '2025-11-01 10:15:00'),
(2, 'PayPal', 'PP98765', 75.00, 'AUTHORIZED', '2025-11-02 14:20:00'),
(3, 'Stripe', 'STR67890', 45.25, 'FAILED', NULL),
(4, 'Square', 'SQ54321', 200.00, 'CAPTURED', '2025-11-03 09:30:00'),
(5, 'Stripe', 'STR11122', 150.75, 'REFUNDED', '2025-11-04 11:45:00'),
(6, 'PayPal', 'PP22233', 90.00, 'CAPTURED', '2025-11-01 16:10:00'),
(7, 'Stripe', 'STR33344', 60.50, 'INITIATED', NULL),
(8, 'Square', 'SQ44455', 110.00, 'AUTHORIZED', '2025-11-02 12:00:00'),
(9, 'PayPal', 'PP55566', 35.00, 'CAPTURED', '2025-11-03 15:25:00'),
(10, 'Stripe', 'STR66677', 80.00, 'CAPTURED', '2025-11-04 13:40:00'),
(1, 'PayPal', 'PP77788', 50.00, 'CAPTURED', '2025-11-01 10:50:00'),
(2, 'Stripe', 'STR88899', 25.75, 'FAILED', NULL),
(3, 'Square', 'SQ99900', 60.00, 'AUTHORIZED', '2025-11-02 09:15:00'),
(4, 'Stripe', 'STR00011', 75.25, 'CAPTURED', '2025-11-03 10:30:00'),
(5, 'PayPal', 'PP11122', 100.00, 'CAPTURED', '2025-11-04 14:50:00'),
(6, 'Stripe', 'STR22233', 120.00, 'REFUNDED', '2025-11-01 17:00:00'),
(7, 'PayPal', 'PP33344', 55.00, 'CAPTURED', '2025-11-02 11:45:00'),
(8, 'Stripe', 'STR44455', 90.50, 'INITIATED', NULL),
(9, 'Square', 'SQ55566', 40.00, 'CAPTURED', '2025-11-03 16:10:00'),
(10, 'PayPal', 'PP66677', 85.75, 'AUTHORIZED', '2025-11-04 12:30:00');

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

