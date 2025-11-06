-- =============================================
-- Author: Tiwari, Sneha
-- Create date: [Date]
-- Description: Create OrderItems Table
-- Module: Order Management & Fulfillment
-- Note: Requires Orders and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS OrderItems;

CREATE TABLE OrderItems (
  order_item_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id           BIGINT        NOT NULL,
  variant_id         BIGINT        NOT NULL,
  qty                INT           NOT NULL CHECK (qty > 0),
  unit_price         DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  discount_amount    DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
  tax_amount         DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
  
  -- Derived subtotal per line
  line_subtotal      DECIMAL(12,2) GENERATED ALWAYS AS (qty * unit_price) STORED,

  -- Derived total after discount and tax
  line_total         DECIMAL(12,2) GENERATED ALWAYS AS ((qty * unit_price) - discount_amount + tax_amount) STORED,

  created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),

  CONSTRAINT FK_OI_Order   FOREIGN KEY (order_id)   REFERENCES Orders(order_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_OI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE OrderItems COMMENT = 'Individual line items in orders with quantity, pricing, and tax/discount breakdown';

-- Create indexes for performance optimization
CREATE INDEX IX_OrderItems_Order   ON OrderItems(order_id);
CREATE INDEX IX_OrderItems_Variant ON OrderItems(variant_id);

-- Verify table creation
DESC OrderItems;

-- =============================================
-- Sample Data (assuming matching Orders & ProductVariants exist)
-- =============================================

-- Example ProductVariants:
-- variant_id 1: iPhone 15 Pro (SKU: IP15PRO-128)
-- variant_id 2: AirPods Pro (SKU: APPRO-2ND)
-- variant_id 3: Wireless Mouse (SKU: WMOUSE-BLK)
-- variant_id 4: Mechanical Keyboard (SKU: MECHKEY-01)

-- Example: Insert sample order items
INSERT INTO OrderItems (order_id, variant_id, qty, unit_price, discount_amount, tax_amount)
VALUES
  (16, 1, 2, 999.99, 100.00, 70.00),   -- 2 iPhones
  (17, 3, 1, 29.99,  0.00,  2.10),     -- 1 Wireless Mouse
  (18, 2, 1, 249.99, 20.00, 18.00),    -- AirPods Pro
  (19, 4, 1, 120.00, 10.00, 9.00),     -- Mechanical Keyboard
  (20, 3, 2, 25.00,  0.00,  3.00),     -- Wireless Mouse x2
  (21, 1, 1, 999.99, 80.00, 75.00),    -- iPhone
  (22, 2, 2, 249.99, 0.00,  20.00),    -- AirPods
  (23, 4, 1, 120.00, 10.00,  9.00),    -- Keyboard
  (23, 3, 1, 29.99,  0.00,  2.00),     -- Mouse
  (25, 1, 1, 999.99, 50.00, 70.00);    -- iPhone
  
  -- =============================================
-- Additional Sample OrderItems Data
-- =============================================

INSERT INTO OrderItems (order_id, variant_id, qty, unit_price, discount_amount, tax_amount)
VALUES
  -- Order 26
  (26, 1, 1, 999.99, 50.00, 75.00),   -- iPhone
  (26, 3, 2, 25.00,  0.00,  3.00),    -- Wireless Mouse

  -- Order 27
  (27, 2, 1, 249.99, 15.00, 18.00),   -- AirPods Pro
  (27, 4, 1, 120.00,  0.00,  9.00),   -- Keyboard

  -- Order 28
  (28, 1, 2, 999.99, 100.00, 140.00), -- 2 iPhones
  (28, 2, 1, 249.99,  0.00,  18.00),  -- AirPods

  -- Order 29
  (29, 3, 3, 25.00,  0.00,  3.00),    -- 3 × Wireless Mouse
  (29, 4, 1, 120.00,  5.00,  9.00),   -- Keyboard

  -- Order 30
  (30, 1, 1, 999.99, 25.00, 80.00),   -- iPhone
  (30, 2, 1, 249.99,  0.00,  18.00);  -- AirPods



-- =============================================
-- Example: Query to view detailed order breakdown
-- =============================================

SELECT 
  o.order_id,
  u.email,
  p.title AS product_name,
  pv.sku,
  oi.qty,
  oi.unit_price,
  oi.line_subtotal,
  oi.discount_amount,
  oi.tax_amount,
  oi.line_total,
  o.status,
  o.placed_at
FROM OrderItems oi
JOIN Orders o          ON oi.order_id = o.order_id
JOIN Users u           ON o.user_id = u.user_id
JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
JOIN Products p        ON pv.product_id = p.product_id
ORDER BY o.order_id, oi.order_item_id;



