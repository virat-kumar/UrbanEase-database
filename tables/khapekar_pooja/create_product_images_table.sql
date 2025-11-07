-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for ProductImages Table (35 entries)
-- Module: Product Catalog
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 product images (1-2 images per product)
INSERT INTO ProductImages (product_id, url, alt_text, sort_order) VALUES
-- Product 1: MacBook Pro
(1, 'https://cdn.urbanease.com/products/macbook-pro-16-front.jpg', 'MacBook Pro 16 inch front view', 0),
(1, 'https://cdn.urbanease.com/products/macbook-pro-16-side.jpg', 'MacBook Pro 16 inch side view', 1),

-- Product 2: iPhone 15 Pro Max
(2, 'https://cdn.urbanease.com/products/iphone-15-pro-max-blue.jpg', 'iPhone 15 Pro Max in blue titanium', 0),

-- Product 3: T-Shirt
(3, 'https://cdn.urbanease.com/products/cotton-tshirt-men-black.jpg', 'Black cotton t-shirt for men', 0),

-- Product 4: Summer Dress
(4, 'https://cdn.urbanease.com/products/floral-dress-women-summer.jpg', 'Women summer floral dress', 0),
(4, 'https://cdn.urbanease.com/products/floral-dress-detail.jpg', 'Floral dress detail view', 1),

-- Product 5: Sofa Set
(5, 'https://cdn.urbanease.com/products/modern-sofa-grey.jpg', 'Modern grey sofa set', 0),

-- Product 6: Wall Art
(6, 'https://cdn.urbanease.com/products/wall-art-abstract.jpg', 'Abstract wall art painting', 0),

-- Product 7: Face Serum
(7, 'https://cdn.urbanease.com/products/vitamin-c-serum.jpg', 'Vitamin C face serum bottle', 0),

-- Product 8: Shampoo
(8, 'https://cdn.urbanease.com/products/argan-oil-shampoo.jpg', 'Argan oil shampoo bottle', 0),
(8, 'https://cdn.urbanease.com/products/argan-oil-ingredients.jpg', 'Shampoo ingredients label', 1),

-- Product 9: Multivitamin
(9, 'https://cdn.urbanease.com/products/multivitamin-complex.jpg', 'Multivitamin supplement bottle', 0),

-- Product 10: Dumbbells
(10, 'https://cdn.urbanease.com/products/adjustable-dumbbells.jpg', 'Adjustable dumbbell set', 0),

-- Product 11: Camping Tent
(11, 'https://cdn.urbanease.com/products/camping-tent-4person.jpg', '4-person camping tent', 0),
(11, 'https://cdn.urbanease.com/products/tent-interior.jpg', 'Tent interior view', 1),

-- Product 12: Running Shorts
(12, 'https://cdn.urbanease.com/products/running-shorts-men-blue.jpg', 'Men blue running shorts', 0),

-- Product 13: Board Game
(13, 'https://cdn.urbanease.com/products/catan-board-game.jpg', 'Catan strategy board game', 0),

-- Product 14: Action Figure
(14, 'https://cdn.urbanease.com/products/superhero-action-figure.jpg', 'Marvel superhero action figure', 0),

-- Product 15: Phone Mount
(15, 'https://cdn.urbanease.com/products/car-phone-mount.jpg', 'Magnetic car phone mount', 0),

-- Product 16: Motorcycle Gloves
(16, 'https://cdn.urbanease.com/products/motorcycle-gloves-leather.jpg', 'Leather motorcycle gloves', 0),
(16, 'https://cdn.urbanease.com/products/gloves-detail.jpg', 'Gloves protection detail', 1),

-- Product 17: Mystery Novel
(17, 'https://cdn.urbanease.com/products/mystery-novel-cover.jpg', 'Mystery novel book cover', 0),

-- Product 18: Leather Journal
(18, 'https://cdn.urbanease.com/products/leather-journal-brown.jpg', 'Brown leather journal', 0),

-- Product 19: Trail Mix
(19, 'https://cdn.urbanease.com/products/organic-trail-mix.jpg', 'Organic trail mix pack', 0),

-- Product 20: Greek Yogurt
(20, 'https://cdn.urbanease.com/products/greek-yogurt-6pack.jpg', 'Greek yogurt 6-pack', 0),

-- Product 21: Baby Onesie
(21, 'https://cdn.urbanease.com/products/baby-onesie-3pack.jpg', 'Baby onesie 3-pack assorted', 0),

-- Product 22: Baby Wipes
(22, 'https://cdn.urbanease.com/products/baby-wipes-sensitive.jpg', 'Sensitive baby wipes pack', 0),

-- Product 23: Pendant Necklace
(23, 'https://cdn.urbanease.com/products/gold-pendant-necklace.jpg', 'Gold pendant necklace', 0),

-- Product 24: Earrings
(24, 'https://cdn.urbanease.com/products/diamond-stud-earrings.jpg', 'Diamond stud earrings', 0),

-- Product 25: Oxford Shoes
(25, 'https://cdn.urbanease.com/products/leather-oxford-shoes-brown.jpg', 'Brown leather oxford shoes', 0),

-- Product 26: High Heels
(26, 'https://cdn.urbanease.com/products/high-heel-pumps-black.jpg', 'Black high heel pumps', 0),
(26, 'https://cdn.urbanease.com/products/pumps-side-view.jpg', 'Pumps side view', 1),

-- Product 27: Dog Food
(27, 'https://cdn.urbanease.com/products/premium-dog-food-15kg.jpg', 'Premium dog food 15kg bag', 0),

-- Product 28: Cat Tree
(28, 'https://cdn.urbanease.com/products/cat-scratching-post.jpg', 'Multi-level cat scratching post', 0),

-- Product 29: Recliner
(29, 'https://cdn.urbanease.com/products/leather-recliner-armchair.jpg', 'Leather recliner armchair', 0),

-- Product 30: Bed Frame
(30, 'https://cdn.urbanease.com/products/queen-bed-frame-wood.jpg', 'Queen size wooden bed frame', 0),

-- Product 31: Printer
(31, 'https://cdn.urbanease.com/products/wireless-printer-hp.jpg', 'HP wireless all-in-one printer', 0),

-- Product 32: Desk Organizer
(32, 'https://cdn.urbanease.com/products/bamboo-desk-organizer.jpg', 'Bamboo desk organizer set', 0),

-- Product 33: Drill Kit
(33, 'https://cdn.urbanease.com/products/cordless-drill-kit.jpg', 'Cordless drill kit with battery', 0),

-- Product 34: Acoustic Guitar
(34, 'https://cdn.urbanease.com/products/acoustic-guitar-bundle.jpg', 'Acoustic guitar bundle with accessories', 0),

-- Product 35: Watercolor Set
(35, 'https://cdn.urbanease.com/products/watercolor-paint-set.jpg', 'Professional watercolor paint set', 0);

-- Verify inserted data
SELECT COUNT(*) AS total_images FROM ProductImages;
SELECT pi.image_id, p.title, pi.alt_text, pi.sort_order
FROM ProductImages pi
JOIN Products p ON pi.product_id = p.product_id
LIMIT 10;
