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

-- Add comments to document table purpose
ALTER TABLE OrderItems COMMENT = 'Individual line items in orders with pricing details';

-- Create indexes for lookups
CREATE INDEX IX_OrderItems_Order ON OrderItems(order_id);
CREATE INDEX IX_OrderItems_Variant ON OrderItems(variant_id);

-- Verify table creation
DESC OrderItems;

-- Example: Insert sample order items
/*
-- Assuming order_id = 1
INSERT INTO OrderItems (order_id, variant_id, qty, unit_price, tax_amount, discount_amount) VALUES 
  (1, 1, 2, 999.99, 70.00, 100.00),  -- 2 iPhones
  (1, 3, 1, 29.99, 2.10, 0.00);      -- 1 Wireless Mouse
*/

-- Example: Query to see order details
-- SELECT 
--   o.order_id,
--   p.title,
--   pv.sku,
--   oi.qty,
--   oi.unit_price,
--   (oi.qty * oi.unit_price) as line_subtotal,
--   oi.tax_amount,
--   oi.discount_amount
-- FROM OrderItems oi
-- JOIN Orders o ON oi.order_id = o.order_id
-- JOIN ProductVariants pv ON oi.variant_id = pv.variant_id
-- JOIN Products p ON pv.product_id = p.product_id;

