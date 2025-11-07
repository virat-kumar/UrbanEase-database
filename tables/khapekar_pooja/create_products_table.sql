-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Products Table (35 entries)
-- Module: Product Catalog
-- Note: Requires Categories table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 diverse products across different categories
INSERT INTO Products (category_id, title, description, brand, is_active, created_at) VALUES
(31, 'MacBook Pro 16" M3', 'Powerful laptop for professionals with M3 chip, 16GB RAM, 512GB SSD', 'Apple', TRUE, '2024-01-10 10:00:00'),
(32, 'iPhone 15 Pro Max', 'Latest flagship smartphone with A17 Pro chip and titanium design', 'Apple', TRUE, '2024-01-15 11:30:00'),
(33, 'Premium Cotton T-Shirt', 'Comfortable 100% organic cotton t-shirt for men', 'Nike', TRUE, '2024-02-01 09:15:00'),
(34, 'Summer Floral Dress', 'Elegant floral print dress perfect for summer occasions', 'Zara', TRUE, '2024-02-10 14:20:00'),
(35, 'Modern Sofa Set', 'Contemporary 3-seater sofa with premium fabric upholstery', 'IKEA', TRUE, '2024-02-20 10:45:00'),
(36, 'Decorative Wall Art', 'Hand-painted canvas art for living room decoration', 'HomeStyle', TRUE, '2024-03-01 13:30:00'),
(37, 'Vitamin C Face Serum', 'Brightening serum with 20% vitamin C for radiant skin', 'The Ordinary', TRUE, '2024-03-10 08:50:00'),
(38, 'Argan Oil Shampoo', 'Nourishing shampoo for damaged and dry hair', 'OGX', TRUE, '2024-03-15 15:10:00'),
(39, 'Multivitamin Complex', 'Daily multivitamin supplement with essential nutrients', 'Nature Made', TRUE, '2024-04-01 10:20:00'),
(40, 'Adjustable Dumbbell Set', 'Space-saving adjustable dumbbells 5-52.5 lbs', 'Bowflex', TRUE, '2024-04-10 12:35:00'),
(41, 'Camping Tent 4-Person', 'Waterproof family camping tent with easy setup', 'Coleman', TRUE, '2024-04-20 09:40:00'),
(42, 'Running Shorts Men', 'Lightweight moisture-wicking running shorts', 'Under Armour', TRUE, '2024-05-01 14:15:00'),
(43, 'Strategy Board Game', 'Award-winning strategy game for 2-4 players', 'Catan', TRUE, '2024-05-10 11:25:00'),
(44, 'Superhero Action Figure', 'Collectible 12-inch articulated action figure', 'Marvel', TRUE, '2024-05-20 16:30:00'),
(45, 'Car Phone Mount', 'Universal magnetic phone holder for car dashboard', 'iOttie', TRUE, '2024-06-01 10:05:00'),
(46, 'Motorcycle Gloves', 'Protective leather gloves for riders', 'Alpinestars', TRUE, '2024-06-10 13:45:00'),
(47, 'Mystery Novel Collection', 'Bestselling mystery thriller paperback book', 'Penguin Books', TRUE, '2024-06-20 09:30:00'),
(48, 'Leather Journal', 'Handcrafted leather-bound journal with 200 pages', 'Moleskine', TRUE, '2024-07-01 15:20:00'),
(49, 'Organic Trail Mix', 'Healthy snack mix with nuts, seeds and dried fruits', 'Nature Valley', TRUE, '2024-07-10 08:55:00'),
(50, 'Greek Yogurt Pack', 'High-protein probiotic yogurt 6-pack', 'Chobani', TRUE, '2024-07-20 12:10:00'),
(51, 'Baby Onesie 3-Pack', 'Soft cotton baby bodysuits in assorted colors', 'Gerber', TRUE, '2024-08-01 10:35:00'),
(52, 'Baby Wipes Sensitive', 'Hypoallergenic fragrance-free baby wipes 500 count', 'Pampers', TRUE, '2024-08-10 14:50:00'),
(53, 'Gold Pendant Necklace', 'Elegant 18K gold plated pendant with chain', 'Swarovski', TRUE, '2024-08-20 11:15:00'),
(54, 'Diamond Stud Earrings', 'Classic sterling silver earrings with cubic zirconia', 'Pandora', TRUE, '2024-09-01 16:25:00'),
(55, 'Leather Oxford Shoes', 'Handcrafted genuine leather formal shoes for men', 'Clarks', TRUE, '2024-09-10 09:40:00'),
(56, 'High Heel Pumps', 'Elegant pointed-toe pumps for women', 'Steve Madden', TRUE, '2024-09-20 13:55:00'),
(57, 'Premium Dog Food 15kg', 'Grain-free natural dog food for all breeds', 'Blue Buffalo', TRUE, '2024-10-01 10:30:00'),
(58, 'Cat Scratching Post', 'Multi-level cat tree with sisal scratching posts', 'Frisco', TRUE, '2024-10-10 15:45:00'),
(59, 'Recliner Armchair', 'Comfortable leather recliner for living room', 'La-Z-Boy', TRUE, '2024-10-20 08:20:00'),
(60, 'Queen Size Bed Frame', 'Solid wood platform bed with headboard', 'Zinus', TRUE, '2024-11-01 12:40:00'),
(61, 'Wireless All-in-One Printer', 'Color printer with scanner and copier', 'HP', TRUE, '2024-11-05 09:50:00'),
(62, 'Desk Organizer Set', 'Bamboo desktop organizer with multiple compartments', 'SimpleHouseware', TRUE, '2024-11-07 14:05:00'),
(63, 'Cordless Drill Kit', '20V drill driver with battery and charger', 'DeWalt', TRUE, '2024-11-08 11:30:00'),
(64, 'Acoustic Guitar Bundle', 'Full-size guitar with case, tuner and picks', 'Fender', TRUE, '2024-11-09 16:15:00'),
(65, 'Watercolor Paint Set', 'Professional watercolor set with 36 colors', 'Winsor & Newton', TRUE, '2024-11-10 10:25:00');

-- Verify inserted data
SELECT COUNT(*) AS total_products FROM Products;
SELECT p.title, p.brand, c.name AS category 
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LIMIT 10;
