-- =============================================
-- Author: Min, La Yaung
-- Create date: [Date]
-- Description: Create CartItems Table
-- Module: Shopping Cart & Promotions
-- Note: Requires Carts and ProductVariants tables to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS CartItems;

CREATE TABLE CartItems (
  cart_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  cart_id      BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  qty          INT    NOT NULL CHECK (qty > 0),
  unit_price   DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  added_at     DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP(),
  CONSTRAINT FK_CI_Cart    FOREIGN KEY (cart_id)    REFERENCES Carts(cart_id),
  CONSTRAINT FK_CI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE CartItems COMMENT = 'Items in shopping carts with quantity and price';

-- Create indexes for lookups
CREATE INDEX IX_CartItems_Cart ON CartItems(cart_id);
CREATE INDEX IX_CartItems_Variant ON CartItems(variant_id);

-- Verify table creation
DESC CartItems;

-- Example: Insert sample cart items
/*
-- Assuming cart_id = 1 and variant_id = 1 (iPhone 128GB Black at $999.99)
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) VALUES 
  (1, 1, 2, 999.99),   -- 2 iPhones
  (1, 2, 1, 1099.99);  -- 1 iPhone 256GB
*/

-- Example: Query to see cart contents with totals
-- SELECT 
--   c.cart_id,
--   pv.sku,
--   p.title,
--   ci.qty,
--   ci.unit_price,
--   (ci.qty * ci.unit_price) as line_total
-- FROM CartItems ci
-- JOIN Carts c ON ci.cart_id = c.cart_id
-- JOIN ProductVariants pv ON ci.variant_id = pv.variant_id
-- JOIN Products p ON pv.product_id = p.product_id;

