-- =============================================
-- Author: Khapekar, Pooja
-- Create date: [Date]
-- Description: Create ProductImages Table
-- Module: Product Catalog
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Drop table if exists (for development only)
-- DROP TABLE IF EXISTS ProductImages;

CREATE TABLE ProductImages (
  image_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  url        VARCHAR(512) NOT NULL,
  alt_text   VARCHAR(160) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Image_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE ProductImages COMMENT = 'Multiple images per product with sort order';

-- Create index for product lookups
CREATE INDEX IX_Image_Product ON ProductImages(product_id);

-- Verify table creation
DESC ProductImages;

-- Example: Insert sample product images
/*
-- Assuming MacBook Pro has product_id = 1
INSERT INTO ProductImages (product_id, url, alt_text, sort_order) VALUES 
  (1, 'https://images.urbanease.com/macbook-pro-front.jpg', 'MacBook Pro front view', 1),
  (1, 'https://images.urbanease.com/macbook-pro-side.jpg', 'MacBook Pro side view', 2),
  (1, 'https://images.urbanease.com/macbook-pro-open.jpg', 'MacBook Pro open view', 3);
*/

-- Example: Query to see products with image count
-- SELECT p.title, COUNT(pi.image_id) as image_count
-- FROM Products p
-- LEFT JOIN ProductImages pi ON p.product_id = pi.product_id
-- GROUP BY p.product_id, p.title;

/* Actaul query added with the values by Pooja */

CREATE TABLE ProductImages (
  image_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  url        VARCHAR(512) NOT NULL,
  alt_text   VARCHAR(160) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Image_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to document table purpose
ALTER TABLE ProductImages COMMENT = 'Multiple images per product with sort order';

-- Create index for product lookups
CREATE INDEX IX_Image_Product ON ProductImages(product_id);

-- Verify table creation
DESC ProductImages;
INSERT INTO ProductImages (product_id, url, alt_text, sort_order) VALUES
-- 1. MacBook Pro 16"
(1, 'https://images.urbanease.com/macbook-pro-front.jpg', 'MacBook Pro front view', 1),
(1, 'https://images.urbanease.com/macbook-pro-side.jpg', 'MacBook Pro side view', 2),
(1, 'https://images.urbanease.com/macbook-pro-open.jpg', 'MacBook Pro open view', 3),

-- 2. Classic Denim Jacket
(2, 'https://images.urbanease.com/denim-jacket-front.jpg', 'Classic denim jacket front view', 1),
(2, 'https://images.urbanease.com/denim-jacket-back.jpg', 'Denim jacket back view', 2),
(2, 'https://images.urbanease.com/denim-jacket-detail.jpg', 'Denim jacket button detail', 3),

-- 3. Indoor Plant Set
(3, 'https://images.urbanease.com/indoor-plant-set.jpg', 'Indoor plant set collection', 1),
(3, 'https://images.urbanease.com/indoor-plant-pot.jpg', 'Close-up of plant pot', 2),
(3, 'https://images.urbanease.com/indoor-plant-room.jpg', 'Indoor plants in living room', 3),

-- 4. Hydrating Face Serum
(4, 'https://images.urbanease.com/face-serum-bottle.jpg', 'Hydrating face serum bottle', 1),
(4, 'https://images.urbanease.com/face-serum-dropper.jpg', 'Serum dropper close-up', 2),
(4, 'https://images.urbanease.com/face-serum-texture.jpg', 'Serum texture on skin', 3),

-- 5. Yoga Mat Pro
(5, 'https://images.urbanease.com/yoga-mat-rolled.jpg', 'Rolled yoga mat', 1),
(5, 'https://images.urbanease.com/yoga-mat-flat.jpg', 'Full yoga mat laid out', 2),
(5, 'https://images.urbanease.com/yoga-mat-detail.jpg', 'Yoga mat grip texture', 3),

-- 6. Hiking Backpack 50L
(6, 'https://images.urbanease.com/hiking-backpack-front.jpg', 'Hiking backpack front view', 1),
(6, 'https://images.urbanease.com/hiking-backpack-side.jpg', 'Side pocket view', 2),
(6, 'https://images.urbanease.com/hiking-backpack-straps.jpg', 'Backpack straps and padding', 3),

-- 7. LEGO City Set
(7, 'https://images.urbanease.com/lego-city-box.jpg', 'LEGO City box front', 1),
(7, 'https://images.urbanease.com/lego-city-build.jpg', 'Built LEGO city set', 2),
(7, 'https://images.urbanease.com/lego-city-pieces.jpg', 'LEGO set pieces close-up', 3),

-- 8. Car Vacuum Cleaner
(8, 'https://images.urbanease.com/car-vacuum-main.jpg', 'Car vacuum cleaner device', 1),
(8, 'https://images.urbanease.com/car-vacuum-attachments.jpg', 'Attachments included', 2),
(8, 'https://images.urbanease.com/car-vacuum-inuse.jpg', 'Vacuum in use inside car', 3),

-- 9. Hardcover Journal
(9, 'https://images.urbanease.com/journal-cover.jpg', 'Hardcover journal front cover', 1),
(9, 'https://images.urbanease.com/journal-open.jpg', 'Open journal pages', 2),
(9, 'https://images.urbanease.com/journal-writing.jpg', 'Writing in the journal', 3),

-- 10. Organic Green Tea Pack
(10, 'https://images.urbanease.com/green-tea-pack.jpg', 'Organic green tea box', 1),
(10, 'https://images.urbanease.com/green-tea-bags.jpg', 'Green tea bags close-up', 2),
(10, 'https://images.urbanease.com/green-tea-cup.jpg', 'Brewed green tea cup', 3),

-- 11. Baby Diaper Pack
(11, 'https://images.urbanease.com/baby-diaper-pack.jpg', 'Baby diaper pack front', 1),
(11, 'https://images.urbanease.com/baby-diaper-open.jpg', 'Open diaper pack', 2),
(11, 'https://images.urbanease.com/baby-diaper-baby.jpg', 'Baby wearing diaper', 3),

-- 12. Gold-Plated Necklace
(12, 'https://images.urbanease.com/gold-necklace-display.jpg', 'Gold-plated necklace display', 1),
(12, 'https://images.urbanease.com/gold-necklace-close.jpg', 'Close-up of pendant', 2),
(12, 'https://images.urbanease.com/gold-necklace-box.jpg', 'Necklace in gift box', 3),

-- 13. Running Shoes
(13, 'https://images.urbanease.com/running-shoes-pair.jpg', 'Pair of running shoes', 1),
(13, 'https://images.urbanease.com/running-shoes-sole.jpg', 'Shoe sole grip design', 2),
(13, 'https://images.urbanease.com/running-shoes-side.jpg', 'Side profile of shoe', 3),

-- 14. Dog Food 10kg
(14, 'https://images.urbanease.com/dog-food-bag.jpg', 'Dog food bag front', 1),
(14, 'https://images.urbanease.com/dog-food-bowl.jpg', 'Dog food in bowl', 2),
(14, 'https://images.urbanease.com/dog-eating.jpg', 'Dog eating food happily', 3),

-- 15. Wooden Coffee Table
(15, 'https://images.urbanease.com/coffee-table-main.jpg', 'Wooden coffee table view', 1),
(15, 'https://images.urbanease.com/coffee-table-close.jpg', 'Table surface finish close-up', 2),
(15, 'https://images.urbanease.com/coffee-table-living.jpg', 'Table in living room setup', 3),

-- 16. Wireless Printer
(16, 'https://images.urbanease.com/printer-front.jpg', 'Wireless printer front', 1),
(16, 'https://images.urbanease.com/printer-paper.jpg', 'Printer with paper tray open', 2),
(16, 'https://images.urbanease.com/printer-scanner.jpg', 'Scanner lid view', 3),

-- 17. Cordless Drill Set
(17, 'https://images.urbanease.com/cordless-drill-kit.jpg', 'Cordless drill kit with case', 1),
(17, 'https://images.urbanease.com/cordless-drill-inuse.jpg', 'Using cordless drill', 2),
(17, 'https://images.urbanease.com/cordless-drill-parts.jpg', 'Accessories and bits', 3),

-- 18. Acoustic Guitar
(18, 'https://images.urbanease.com/acoustic-guitar-front.jpg', 'Acoustic guitar front view', 1),
(18, 'https://images.urbanease.com/acoustic-guitar-side.jpg', 'Guitar body and neck', 2),
(18, 'https://images.urbanease.com/acoustic-guitar-playing.jpg', 'Person playing guitar', 3),

-- 19. Acrylic Paint Kit
(19, 'https://images.urbanease.com/acrylic-paint-set.jpg', 'Acrylic paint color set', 1),
(19, 'https://images.urbanease.com/acrylic-paint-tubes.jpg', 'Paint tubes close-up', 2),
(19, 'https://images.urbanease.com/acrylic-paint-art.jpg', 'Painting with acrylics', 3),

-- 20. DSLR Camera
(20, 'https://images.urbanease.com/dslr-camera-front.jpg', 'DSLR camera front', 1),
(20, 'https://images.urbanease.com/dslr-camera-lens.jpg', 'Camera with lens attached', 2),
(20, 'https://images.urbanease.com/dslr-camera-accessories.jpg', 'Camera accessories kit', 3),

-- 21. Gaming Laptop
(21, 'https://images.urbanease.com/gaming-laptop-open.jpg', 'Gaming laptop open view', 1),
(21, 'https://images.urbanease.com/gaming-laptop-keyboard.jpg', 'RGB keyboard close-up', 2),
(21, 'https://images.urbanease.com/gaming-laptop-side.jpg', 'Side ports view', 3),

-- 22. Samsung Galaxy S24
(22, 'https://images.urbanease.com/galaxy-s24-front.jpg', 'Samsung Galaxy S24 front', 1),
(22, 'https://images.urbanease.com/galaxy-s24-back.jpg', 'Samsung Galaxy S24 back', 2),
(22, 'https://images.urbanease.com/galaxy-s24-box.jpg', 'Galaxy S24 box packaging', 3),

-- 23. Smart Refrigerator
(23, 'https://images.urbanease.com/smart-fridge-front.jpg', 'Smart refrigerator front view', 1),
(23, 'https://images.urbanease.com/smart-fridge-open.jpg', 'Fridge interior view', 2),
(23, 'https://images.urbanease.com/smart-fridge-panel.jpg', 'Smart control panel', 3),

-- 24. Hard Shell Suitcase
(24, 'https://images.urbanease.com/suitcase-front.jpg', 'Hard shell suitcase front', 1),
(24, 'https://images.urbanease.com/suitcase-open.jpg', 'Open suitcase compartments', 2),
(24, 'https://images.urbanease.com/suitcase-wheels.jpg', 'Wheels and handle detail', 3),

-- 25. Blu-ray Movie Set
(25, 'https://images.urbanease.com/bluray-set-front.jpg', 'Blu-ray movie set front', 1),
(25, 'https://images.urbanease.com/bluray-discs.jpg', 'Blu-ray discs display', 2),
(25, 'https://images.urbanease.com/bluray-collection.jpg', 'Movie collection layout', 3),

-- 26. PlayStation 5
(26, 'https://images.urbanease.com/ps5-console.jpg', 'PlayStation 5 console', 1),
(26, 'https://images.urbanease.com/ps5-controller.jpg', 'DualSense controller', 2),
(26, 'https://images.urbanease.com/ps5-setup.jpg', 'PlayStation 5 setup on desk', 3),

-- 27. Smartwatch Series 9
(27, 'https://images.urbanease.com/smartwatch-front.jpg', 'Smartwatch front view', 1),
(27, 'https://images.urbanease.com/smartwatch-side.jpg', 'Smartwatch side profile', 2),
(27, 'https://images.urbanease.com/smartwatch-wrist.jpg', 'Smartwatch on wrist', 3),

-- 28. Non-Stick Cookware Set
(28, 'https://images.urbanease.com/cookware-set-main.jpg', 'Non-stick cookware set', 1),
(28, 'https://images.urbanease.com/cookware-pans.jpg', 'Different pan sizes', 2),
(28, 'https://images.urbanease.com/cookware-lids.jpg', 'Cookware lids and handles', 3),

-- 29. Christmas LED Lights
(29, 'https://images.urbanease.com/christmas-lights.jpg', 'Colorful LED string lights', 1),
(29, 'https://images.urbanease.com/christmas-decor-tree.jpg', 'Lights on Christmas tree', 2),
(29, 'https://images.urbanease.com/christmas-room-decor.jpg', 'Festive home decoration', 3),

-- 30. Smart Doorbell Camera
(30, 'https://images.urbanease.com/smart-doorbell-front.jpg', 'Smart doorbell front view', 1),
(30, 'https://images.urbanease.com/smart-doorbell-app.jpg', 'Mobile app interface', 2),
(30, 'https://images.urbanease.com/smart-doorbell-install.jpg', 'Doorbell installed on wall', 3);

SELECT * from ProductImages;
