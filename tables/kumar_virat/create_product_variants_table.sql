-- =============================================
-- Author: Kumar, Virat
-- Create date: November 2025
-- Description: Sample Data for ProductVariants Table (35 entries)
-- Module: Inventory Management
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 product variants with different SKUs, attributes, and pricing
INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency, is_active, created_at) VALUES
-- Product 1: MacBook Pro variants
(1, 'MBP16-M3-16-512-SG', '{"color":"Space Gray","memory":"16GB","storage":"512GB"}', 2499.00, 'USD', TRUE, '2024-01-10 10:00:00'),
(1, 'MBP16-M3-32-1TB-SIL', '{"color":"Silver","memory":"32GB","storage":"1TB"}', 3299.00, 'USD', TRUE, '2024-01-10 10:00:00'),

-- Product 2: iPhone variants
(2, 'IPH15PM-256-BLU', '{"color":"Blue Titanium","storage":"256GB"}', 1199.00, 'USD', TRUE, '2024-01-15 11:30:00'),
(2, 'IPH15PM-512-NAT', '{"color":"Natural Titanium","storage":"512GB"}', 1399.00, 'USD', TRUE, '2024-01-15 11:30:00'),

-- Product 3: T-Shirt variants
(3, 'TSHIRT-M-BLK', '{"size":"M","color":"Black"}', 29.99, 'USD', TRUE, '2024-02-01 09:15:00'),
(3, 'TSHIRT-L-BLU', '{"size":"L","color":"Blue"}', 29.99, 'USD', TRUE, '2024-02-01 09:15:00'),

-- Product 4: Dress variants
(4, 'DRESS-S-FLO', '{"size":"S","pattern":"Floral"}', 79.99, 'USD', TRUE, '2024-02-10 14:20:00'),
(4, 'DRESS-M-FLO', '{"size":"M","pattern":"Floral"}', 79.99, 'USD', TRUE, '2024-02-10 14:20:00'),

-- Product 5: Sofa
(5, 'SOFA-3SEAT-GRY', '{"seats":"3","color":"Grey"}', 899.00, 'USD', TRUE, '2024-02-20 10:45:00'),

-- Product 6: Wall Art
(6, 'WALLART-24X36-ABS', '{"size":"24x36","style":"Abstract"}', 149.99, 'USD', TRUE, '2024-03-01 13:30:00'),

-- Product 7: Face Serum
(7, 'SERUM-VITC-30ML', '{"volume":"30ml","type":"Vitamin C"}', 24.99, 'USD', TRUE, '2024-03-10 08:50:00'),

-- Product 8: Shampoo
(8, 'SHAMP-ARGAN-385ML', '{"volume":"385ml","ingredient":"Argan Oil"}', 12.99, 'USD', TRUE, '2024-03-15 15:10:00'),

-- Product 9: Multivitamin
(9, 'MULTIVIT-100CT', '{"count":"100 tablets","type":"Adult"}', 19.99, 'USD', TRUE, '2024-04-01 10:20:00'),

-- Product 10: Dumbbells
(10, 'DUMBBELL-ADJ-52LB', '{"weight":"5-52.5 lbs","type":"Adjustable"}', 349.99, 'USD', TRUE, '2024-04-10 12:35:00'),

-- Product 11: Tent
(11, 'TENT-4P-BLU', '{"capacity":"4 person","color":"Blue"}', 189.99, 'USD', TRUE, '2024-04-20 09:40:00'),

-- Product 12: Shorts
(12, 'SHORT-M-BLK', '{"size":"M","color":"Black"}', 39.99, 'USD', TRUE, '2024-05-01 14:15:00'),
(12, 'SHORT-L-NAV', '{"size":"L","color":"Navy"}', 39.99, 'USD', TRUE, '2024-05-01 14:15:00'),

-- Product 13: Board Game
(13, 'CATAN-BASE-EN', '{"edition":"Base Game","language":"English"}', 44.99, 'USD', TRUE, '2024-05-10 11:25:00'),

-- Product 14: Action Figure
(14, 'ACTION-SPDR-12IN', '{"character":"Spider-Man","size":"12 inch"}', 34.99, 'USD', TRUE, '2024-05-20 16:30:00'),

-- Product 15: Phone Mount
(15, 'CARMNT-MAG-BLK', '{"type":"Magnetic","color":"Black"}', 24.99, 'USD', TRUE, '2024-06-01 10:05:00'),

-- Product 16: Gloves
(16, 'GLOVE-L-BLK', '{"size":"L","material":"Leather","color":"Black"}', 79.99, 'USD', TRUE, '2024-06-10 13:45:00'),

-- Product 17: Novel
(17, 'BOOK-MYST-PB', '{"format":"Paperback","genre":"Mystery"}', 14.99, 'USD', TRUE, '2024-06-20 09:30:00'),

-- Product 18: Journal
(18, 'JRNL-LTH-BRN-200', '{"material":"Leather","color":"Brown","pages":"200"}', 29.99, 'USD', TRUE, '2024-07-01 15:20:00'),

-- Product 19: Trail Mix
(19, 'SNACK-TRLMX-12OZ', '{"weight":"12 oz","type":"Organic"}', 8.99, 'USD', TRUE, '2024-07-10 08:55:00'),

-- Product 20: Yogurt
(20, 'YOGURT-GRK-6PK', '{"count":"6 pack","protein":"High"}', 6.99, 'USD', TRUE, '2024-07-20 12:10:00'),

-- Product 21: Onesie
(21, 'BABY-ONES-3M-3PK', '{"size":"3 months","count":"3 pack"}', 19.99, 'USD', TRUE, '2024-08-01 10:35:00'),

-- Product 22: Wipes
(22, 'WIPES-BABY-500CT', '{"count":"500","type":"Sensitive"}', 12.99, 'USD', TRUE, '2024-08-10 14:50:00'),

-- Product 23: Necklace
(23, 'NECKL-GLD-PEND', '{"material":"18K Gold Plated","style":"Pendant"}', 89.99, 'USD', TRUE, '2024-08-20 11:15:00'),

-- Product 24: Earrings
(24, 'EARR-SIL-CZ', '{"material":"Sterling Silver","stone":"Cubic Zirconia"}', 49.99, 'USD', TRUE, '2024-09-01 16:25:00'),

-- Product 25: Oxford Shoes
(25, 'SHOE-OXF-10-BRN', '{"size":"10","color":"Brown","material":"Leather"}', 129.99, 'USD', TRUE, '2024-09-10 09:40:00'),

-- Product 26: High Heels
(26, 'HEEL-8-BLK', '{"size":"8","color":"Black","heel":"3 inch"}', 89.99, 'USD', TRUE, '2024-09-20 13:55:00'),

-- Product 27: Dog Food
(27, 'DOGFD-15KG-GF', '{"weight":"15kg","type":"Grain Free"}', 59.99, 'USD', TRUE, '2024-10-01 10:30:00'),

-- Product 28: Cat Tree
(28, 'CATTREE-3LVL-BEI', '{"levels":"3","color":"Beige"}', 79.99, 'USD', TRUE, '2024-10-10 15:45:00'),

-- Product 29: Recliner
(29, 'RECL-LTH-BRN', '{"material":"Leather","color":"Brown"}', 699.00, 'USD', TRUE, '2024-10-20 08:20:00'),

-- Product 30: Bed Frame
(30, 'BED-QUEEN-WOOD', '{"size":"Queen","material":"Wood"}', 399.00, 'USD', TRUE, '2024-11-01 12:40:00'),

-- Product 31: Printer
(31, 'PRNT-HP-WIFI-COL', '{"brand":"HP","connectivity":"WiFi","color":"Yes"}', 199.99, 'USD', TRUE, '2024-11-05 09:50:00'),

-- Product 32: Desk Organizer
(32, 'DESK-ORG-BAMB', '{"material":"Bamboo","compartments":"5"}', 34.99, 'USD', TRUE, '2024-11-07 14:05:00'),

-- Product 33: Drill Kit
(33, 'DRILL-20V-KIT', '{"voltage":"20V","battery":"2Ah","type":"Cordless"}', 149.99, 'USD', TRUE, '2024-11-08 11:30:00'),

-- Product 34: Guitar
(34, 'GUITAR-AC-NAT', '{"type":"Acoustic","color":"Natural","size":"Full"}', 299.99, 'USD', TRUE, '2024-11-09 16:15:00'),

-- Product 35: Watercolor
(35, 'PAINT-WC-36COL', '{"type":"Watercolor","colors":"36","quality":"Professional"}', 54.99, 'USD', TRUE, '2024-11-10 10:25:00');

-- Verify inserted data
SELECT COUNT(*) AS total_variants FROM ProductVariants;
SELECT pv.sku, p.title, pv.price, pv.attributes_json
FROM ProductVariants pv
JOIN Products p ON pv.product_id = p.product_id
LIMIT 10;
