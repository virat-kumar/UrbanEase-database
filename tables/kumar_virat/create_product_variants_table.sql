-- =============================================
-- Author: Kumar, Virat
-- Create date: [Date]
-- Description: Create ProductVariants Table
-- Module: Product Variants & Inventory Management
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS ProductVariants;

CREATE TABLE ProductVariants (
  variant_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id      BIGINT       NOT NULL,
  sku             VARCHAR(64)  NOT NULL UNIQUE,
  attributes_json JSON NULL,  -- {"size":"M","color":"Black"}
  price           DECIMAL(12,2) NOT NULL CHECK (price >= 0),
  currency        CHAR(3)       NOT NULL DEFAULT 'USD',
  is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
  created_at      DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP(),
  updated_at      DATETIME      NOT NULL DEFAULT UTC_TIMESTAMP() ON UPDATE UTC_TIMESTAMP(),
  CONSTRAINT FK_Variant_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE ProductVariants COMMENT = 'Sellable product variants with SKU, price, and attributes';

-- Create index for product lookups
CREATE INDEX IX_Variant_Product ON ProductVariants(product_id);

-- Verify table creation
DESC ProductVariants;

-- =============================================
-- Sample Data: 50 Product Variant Entries
-- Note: Assumes Products with IDs 1-25 exist
-- =============================================

INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency, is_active) VALUES 
  -- Electronics - Smartphones (Product IDs 1-3)
  (1, 'IPHONE15-128GB-BLK', '{"storage":"128GB","color":"Black"}', 799.99, 'USD', TRUE),
  (1, 'IPHONE15-256GB-BLK', '{"storage":"256GB","color":"Black"}', 899.99, 'USD', TRUE),
  (1, 'IPHONE15-128GB-SLV', '{"storage":"128GB","color":"Silver"}', 799.99, 'USD', TRUE),
  (2, 'GALAXYS24-128GB-GRY', '{"storage":"128GB","color":"Gray"}', 749.99, 'USD', TRUE),
  (2, 'GALAXYS24-256GB-BLK', '{"storage":"256GB","color":"Black"}', 849.99, 'USD', TRUE),
  (3, 'PIXEL8-128GB-WHT', '{"storage":"128GB","color":"White"}', 599.99, 'USD', TRUE),
  (3, 'PIXEL8-256GB-BLK', '{"storage":"256GB","color":"Black"}', 699.99, 'USD', TRUE),
  
  -- Electronics - Laptops (Product IDs 4-6)
  (4, 'MACBOOK-AIR-M3-8GB-256GB', '{"processor":"M3","ram":"8GB","storage":"256GB"}', 1299.00, 'USD', TRUE),
  (4, 'MACBOOK-AIR-M3-16GB-512GB', '{"processor":"M3","ram":"16GB","storage":"512GB"}', 1599.00, 'USD', TRUE),
  (5, 'DELL-XPS13-I7-16GB-512GB', '{"processor":"Intel i7","ram":"16GB","storage":"512GB"}', 1399.00, 'USD', TRUE),
  (5, 'DELL-XPS13-I5-8GB-256GB', '{"processor":"Intel i5","ram":"8GB","storage":"256GB"}', 999.00, 'USD', TRUE),
  (6, 'LENOVO-T14-I7-32GB-1TB', '{"processor":"Intel i7","ram":"32GB","storage":"1TB"}', 1799.00, 'USD', TRUE),
  
  -- Electronics - Accessories (Product IDs 7-9)
  (7, 'AIRPODS-PRO2-WHT', '{"generation":"2nd","color":"White"}', 249.99, 'USD', TRUE),
  (7, 'AIRPODS-PRO2-BLK', '{"generation":"2nd","color":"Black"}', 249.99, 'USD', TRUE),
  (8, 'LOGITECH-MX3S-BLK', '{"type":"Wireless Mouse","color":"Black"}', 99.99, 'USD', TRUE),
  (8, 'LOGITECH-MX3S-WHT', '{"type":"Wireless Mouse","color":"White"}', 99.99, 'USD', TRUE),
  (9, 'SAMSUNG-T7-1TB-BLU', '{"type":"Portable SSD","capacity":"1TB","color":"Blue"}', 129.99, 'USD', TRUE),
  (9, 'SAMSUNG-T7-2TB-BLK', '{"type":"Portable SSD","capacity":"2TB","color":"Black"}', 199.99, 'USD', TRUE),
  
  -- Home Appliances (Product IDs 10-12)
  (10, 'DYSON-V15-STD', '{"model":"V15 Detect","kit":"Standard"}', 749.99, 'USD', TRUE),
  (10, 'DYSON-V15-PRO', '{"model":"V15 Detect","kit":"Professional"}', 849.99, 'USD', TRUE),
  (11, 'INSTANTPOT-DUO-6QT', '{"capacity":"6 Quart","type":"7-in-1"}', 129.99, 'USD', TRUE),
  (11, 'INSTANTPOT-DUO-8QT', '{"capacity":"8 Quart","type":"7-in-1"}', 159.99, 'USD', TRUE),
  (12, 'NINJA-BLENDER-1000W-BLK', '{"power":"1000W","color":"Black"}', 89.99, 'USD', TRUE),
  
  -- Clothing - Tops (Product IDs 13-15)
  (13, 'NIKE-TSHIRT-M-BLK', '{"brand":"Nike","size":"M","color":"Black"}', 29.99, 'USD', TRUE),
  (13, 'NIKE-TSHIRT-L-BLK', '{"brand":"Nike","size":"L","color":"Black"}', 29.99, 'USD', TRUE),
  (13, 'NIKE-TSHIRT-M-WHT', '{"brand":"Nike","size":"M","color":"White"}', 29.99, 'USD', TRUE),
  (14, 'ADIDAS-HOODIE-M-GRY', '{"brand":"Adidas","size":"M","color":"Gray"}', 59.99, 'USD', TRUE),
  (14, 'ADIDAS-HOODIE-L-BLK', '{"brand":"Adidas","size":"L","color":"Black"}', 59.99, 'USD', TRUE),
  (15, 'POLO-SHIRT-M-BLU', '{"type":"Polo","size":"M","color":"Blue"}', 45.00, 'USD', TRUE),
  (15, 'POLO-SHIRT-L-WHT', '{"type":"Polo","size":"L","color":"White"}', 45.00, 'USD', TRUE),
  
  -- Clothing - Bottoms (Product IDs 16-18)
  (16, 'LEVIS-JEANS-32-BLU', '{"brand":"Levis","size":"32","color":"Blue"}', 79.99, 'USD', TRUE),
  (16, 'LEVIS-JEANS-34-BLK', '{"brand":"Levis","size":"34","color":"Black"}', 79.99, 'USD', TRUE),
  (17, 'NIKE-SHORTS-M-BLK', '{"brand":"Nike","size":"M","color":"Black"}', 34.99, 'USD', TRUE),
  (17, 'NIKE-SHORTS-L-GRY', '{"brand":"Nike","size":"L","color":"Gray"}', 34.99, 'USD', TRUE),
  (18, 'CHINOS-32-KHK', '{"type":"Chinos","size":"32","color":"Khaki"}', 54.99, 'USD', TRUE),
  
  -- Footwear (Product IDs 19-21)
  (19, 'NIKE-AIRMAX-10-BLK', '{"brand":"Nike","model":"Air Max","size":"10","color":"Black"}', 139.99, 'USD', TRUE),
  (19, 'NIKE-AIRMAX-11-WHT', '{"brand":"Nike","model":"Air Max","size":"11","color":"White"}', 139.99, 'USD', TRUE),
  (20, 'ADIDAS-ULTRABOOST-10-GRY', '{"brand":"Adidas","model":"Ultraboost","size":"10","color":"Gray"}', 189.99, 'USD', TRUE),
  (20, 'ADIDAS-ULTRABOOST-11-BLK', '{"brand":"Adidas","model":"Ultraboost","size":"11","color":"Black"}', 189.99, 'USD', TRUE),
  (21, 'VANS-OLDSKOOL-9-BLK', '{"brand":"Vans","model":"Old Skool","size":"9","color":"Black"}', 69.99, 'USD', TRUE),
  
  -- Sports & Fitness (Product IDs 22-25)
  (22, 'YOGA-MAT-5MM-PUR', '{"thickness":"5mm","color":"Purple"}', 29.99, 'USD', TRUE),
  (22, 'YOGA-MAT-5MM-BLU', '{"thickness":"5mm","color":"Blue"}', 29.99, 'USD', TRUE),
  (23, 'DUMBELL-SET-20LB', '{"weight":"20 lbs","type":"Set of 2"}', 49.99, 'USD', TRUE),
  (23, 'DUMBELL-SET-30LB', '{"weight":"30 lbs","type":"Set of 2"}', 69.99, 'USD', TRUE),
  (24, 'RESISTANCE-BANDS-LIGHT', '{"resistance":"Light","color":"Yellow"}', 19.99, 'USD', TRUE),
  (24, 'RESISTANCE-BANDS-HEAVY', '{"resistance":"Heavy","color":"Black"}', 24.99, 'USD', TRUE),
  (25, 'WATER-BOTTLE-32OZ-BLU', '{"capacity":"32 oz","color":"Blue"}', 24.99, 'USD', TRUE),
  (25, 'WATER-BOTTLE-32OZ-BLK', '{"capacity":"32 oz","color":"Black"}', 24.99, 'USD', TRUE);

