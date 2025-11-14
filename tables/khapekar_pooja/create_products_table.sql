-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Products Table (324 entries)
-- Module: Product Catalog
-- Note: Requires Categories table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 diverse products across different categories
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Laptops'),
    'Build Laptops',
    'This is a premium laptops product trusted by many around the world.',
    'Samsung',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Laptops'),
    'Entire Laptops',
    'This is a premium laptops product trusted by many around the world.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Laptops'),
    'Development Laptops',
    'This is a premium laptops product trusted by many around the world.',
    'Dell',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'Early Smartphones',
    'This is a premium smartphones product trusted by many around the world.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'We Smartphones',
    'This is a premium smartphones product trusted by many around the world.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'Experience Smartphones',
    'This is a premium smartphones product trusted by many around the world.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Clothing'),
    'Piece Men Clothing',
    'This is a premium men clothing product trusted by many around the world.',
    'Nike',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Clothing'),
    'That Men Clothing',
    'This is a premium men clothing product trusted by many around the world.',
    'Adidas',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Clothing'),
    'Well Men Clothing',
    'This is a premium men clothing product trusted by many around the world.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Clothing'),
    'Heart Women Clothing',
    'This is a premium women clothing product trusted by many around the world.',
    'Zara',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Clothing'),
    'Bring Women Clothing',
    'This is a premium women clothing product trusted by many around the world.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Clothing'),
    'Teacher Women Clothing',
    'This is a premium women clothing product trusted by many around the world.',
    'IKEA',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Well Furniture Sets',
    'This is a premium furniture sets product trusted by many around the world.',
    'LOréal',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Food Furniture Sets',
    'This is a premium furniture sets product trusted by many around the world.',
    'Dove',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Bill Furniture Sets',
    'This is a premium furniture sets product trusted by many around the world.',
    'Neutrogena',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Decor'),
    'Size Home Decor',
    'This is a premium home decor product trusted by many around the world.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Decor'),
    'Believe Home Decor',
    'This is a premium home decor product trusted by many around the world.',
    'Canon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Decor'),
    'Watch Home Decor',
    'This is a premium home decor product trusted by many around the world.',
    'Nikon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Skincare'),
    'Anyone Skincare',
    'This is a premium skincare product trusted by many around the world.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Skincare'),
    'Bill Skincare',
    'This is a premium skincare product trusted by many around the world.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Skincare'),
    'Middle Skincare',
    'This is a premium skincare product trusted by many around the world.',
    'Makita',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Community Hair Care',
    'This is a premium hair care product trusted by many around the world.',
    'DeWalt',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Whether Hair Care',
    'This is a premium hair care product trusted by many around the world.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Certain Hair Care',
    'This is a premium hair care product trusted by many around the world.',
    'Rolex',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'Seat Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many around the world.',
    'Fender',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'Most Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many around the world.',
    'Yamaha',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'Sound Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many around the world.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fitness Equipment'),
    'Case Fitness Equipment',
    'This is a premium fitness equipment product trusted by many around the world.',
    'Pepsi',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fitness Equipment'),
    'In Fitness Equipment',
    'This is a premium fitness equipment product trusted by many around the world.',
    'Coca-Cola',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fitness Equipment'),
    'Have Fitness Equipment',
    'This is a premium fitness equipment product trusted by many around the world.',
    'Huggies',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Sell Camping & Hiking',
    'This is a premium camping & hiking product trusted by many around the world.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Third Camping & Hiking',
    'This is a premium camping & hiking product trusted by many around the world.',
    'GoPro',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Almost Camping & Hiking',
    'This is a premium camping & hiking product trusted by many around the world.',
    'Microsoft',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sportswear'),
    'Officer Sportswear',
    'This is a premium sportswear product trusted by many around the world.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sportswear'),
    'Some Sportswear',
    'This is a premium sportswear product trusted by many around the world.',
    'Xbox',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sportswear'),
    'Structure Sportswear',
    'This is a premium sportswear product trusted by many around the world.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Board Games'),
    'Run Board Games',
    'This is a premium board games product trusted by many around the world.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Board Games'),
    'Season Board Games',
    'This is a premium board games product trusted by many around the world.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Board Games'),
    'Stuff Board Games',
    'This is a premium board games product trusted by many around the world.',
    'Apple',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Action Figures'),
    'Consider Action Figures',
    'This is a premium action figures product trusted by many around the world.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Action Figures'),
    'Tonight Action Figures',
    'This is a premium action figures product trusted by many around the world.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Action Figures'),
    'Item Action Figures',
    'This is a premium action figures product trusted by many around the world.',
    'Dell',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Dark Car Accessories',
    'This is a premium car accessories product trusted by many around the world.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Physical Car Accessories',
    'This is a premium car accessories product trusted by many around the world.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Suggest Car Accessories',
    'This is a premium car accessories product trusted by many around the world.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'Account Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many around the world.',
    'Nike',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'Certainly Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many around the world.',
    'Adidas',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'More Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many around the world.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'Agent Fiction Books',
    'This is a premium fiction books product trusted by many around the world.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'House Fiction Books',
    'This is a premium fiction books product trusted by many around the world.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'Sure Fiction Books',
    'This is a premium fiction books product trusted by many around the world.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Notebooks & Diaries'),
    'Food Notebooks & Diaries',
    'This is a premium notebooks & diaries product trusted by many around the world.',
    'LOréal',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Notebooks & Diaries'),
    'Read Notebooks & Diaries',
    'This is a premium notebooks & diaries product trusted by many around the world.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Notebooks & Diaries'),
    'Cell Notebooks & Diaries',
    'This is a premium notebooks & diaries product trusted by many around the world.',
    'Neutrogena',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Snacks & Beverages'),
    'First Snacks & Beverages',
    'This is a premium snacks & beverages product trusted by many around the world.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Snacks & Beverages'),
    'Player Snacks & Beverages',
    'This is a premium snacks & beverages product trusted by many around the world.',
    'Canon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Snacks & Beverages'),
    'Matter Snacks & Beverages',
    'This is a premium snacks & beverages product trusted by many around the world.',
    'Nikon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dairy Products'),
    'Wall Dairy Products',
    'This is a premium dairy products product trusted by many around the world.',
    'LG',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dairy Products'),
    'Order Dairy Products',
    'This is a premium dairy products product trusted by many around the world.',
    'Bosch',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dairy Products'),
    'Last Dairy Products',
    'This is a premium dairy products product trusted by many around the world.',
    'Makita',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Usually Baby Clothing',
    'This is a premium baby clothing product trusted by many around the world.',
    'DeWalt',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Accept Baby Clothing',
    'This is a premium baby clothing product trusted by many around the world.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Worry Baby Clothing',
    'This is a premium baby clothing product trusted by many around the world.',
    'Rolex',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Red Baby Care',
    'This is a premium baby care product trusted by many around the world.',
    'Fender',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Loss Baby Care',
    'This is a premium baby care product trusted by many around the world.',
    'Yamaha',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Key Baby Care',
    'This is a premium baby care product trusted by many around the world.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Necklaces'),
    'Shake Necklaces',
    'This is a premium necklaces product trusted by many around the world.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Necklaces'),
    'Practice Necklaces',
    'This is a premium necklaces product trusted by many around the world.',
    'Coca-Cola',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Necklaces'),
    'Pick Necklaces',
    'This is a premium necklaces product trusted by many around the world.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Natural Earrings',
    'This is a premium earrings product trusted by many around the world.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Decision Earrings',
    'This is a premium earrings product trusted by many around the world.',
    'GoPro',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Nice Earrings',
    'This is a premium earrings product trusted by many around the world.',
    'Microsoft',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Specific Men Footwear',
    'This is a premium men footwear product trusted by many around the world.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Miss Men Footwear',
    'This is a premium men footwear product trusted by many around the world.',
    'Xbox',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Field Men Footwear',
    'This is a premium men footwear product trusted by many around the world.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'Notice Women Footwear',
    'This is a premium women footwear product trusted by many around the world.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'See Women Footwear',
    'This is a premium women footwear product trusted by many around the world.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'Hit Women Footwear',
    'This is a premium women footwear product trusted by many around the world.',
    'Apple',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Research Dog Supplies',
    'This is a premium dog supplies product trusted by many around the world.',
    'Samsung',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Standard Dog Supplies',
    'This is a premium dog supplies product trusted by many around the world.',
    'Sony',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Challenge Dog Supplies',
    'This is a premium dog supplies product trusted by many around the world.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'Can Cat Supplies',
    'This is a premium cat supplies product trusted by many around the world.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'Single Cat Supplies',
    'This is a premium cat supplies product trusted by many around the world.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'End Cat Supplies',
    'This is a premium cat supplies product trusted by many around the world.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Describe Living Room Furniture',
    'This is a premium living room furniture product trusted by many around the world.',
    'Nike',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Television Living Room Furniture',
    'This is a premium living room furniture product trusted by many around the world.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Country Living Room Furniture',
    'This is a premium living room furniture product trusted by many around the world.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Employee Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many around the world.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Type Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many around the world.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Office Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many around the world.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Challenge Printers & Scanners',
    'This is a premium printers & scanners product trusted by many around the world.',
    'LOréal',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Enjoy Printers & Scanners',
    'This is a premium printers & scanners product trusted by many around the world.',
    'Dove',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Account Printers & Scanners',
    'This is a premium printers & scanners product trusted by many around the world.',
    'Neutrogena',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desk Accessories'),
    'These Desk Accessories',
    'This is a premium desk accessories product trusted by many around the world.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desk Accessories'),
    'Everything Desk Accessories',
    'This is a premium desk accessories product trusted by many around the world.',
    'Canon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desk Accessories'),
    'Culture Desk Accessories',
    'This is a premium desk accessories product trusted by many around the world.',
    'Nikon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Training Power Tools',
    'This is a premium power tools product trusted by many around the world.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Will Power Tools',
    'This is a premium power tools product trusted by many around the world.',
    'Bosch',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Bill Power Tools',
    'This is a premium power tools product trusted by many around the world.',
    'Makita',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Thing Hand Tools',
    'This is a premium hand tools product trusted by many around the world.',
    'DeWalt',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Likely Hand Tools',
    'This is a premium hand tools product trusted by many around the world.',
    'Casio',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Audience Hand Tools',
    'This is a premium hand tools product trusted by many around the world.',
    'Rolex',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'Own Guitars',
    'This is a premium guitars product trusted by many around the world.',
    'Fender',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'History Guitars',
    'This is a premium guitars product trusted by many around the world.',
    'Yamaha',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'Treat Guitars',
    'This is a premium guitars product trusted by many around the world.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Film Keyboards',
    'This is a premium keyboards product trusted by many around the world.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Enjoy Keyboards',
    'This is a premium keyboards product trusted by many around the world.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Suffer Keyboards',
    'This is a premium keyboards product trusted by many around the world.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Husband Painting Supplies',
    'This is a premium painting supplies product trusted by many around the world.',
    'Philips',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Human Painting Supplies',
    'This is a premium painting supplies product trusted by many around the world.',
    'GoPro',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Mention Painting Supplies',
    'This is a premium painting supplies product trusted by many around the world.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Free Craft Kits',
    'This is a premium craft kits product trusted by many around the world.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Tell Craft Kits',
    'This is a premium craft kits product trusted by many around the world.',
    'Xbox',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Successful Craft Kits',
    'This is a premium craft kits product trusted by many around the world.',
    'Logitech',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Wall DSLR Cameras',
    'This is a premium dslr cameras product trusted by many around the world.',
    'Reebok',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Material DSLR Cameras',
    'This is a premium dslr cameras product trusted by many around the world.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Across DSLR Cameras',
    'This is a premium dslr cameras product trusted by many around the world.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camera Lenses'),
    'Worker Camera Lenses',
    'This is a premium camera lenses product trusted by many around the world.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camera Lenses'),
    'Plan Camera Lenses',
    'This is a premium camera lenses product trusted by many around the world.',
    'Sony',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camera Lenses'),
    'Civil Camera Lenses',
    'This is a premium camera lenses product trusted by many around the world.',
    'Dell',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desktops'),
    'Still Desktops',
    'This is a premium desktops product trusted by many around the world.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desktops'),
    'Mind Desktops',
    'This is a premium desktops product trusted by many around the world.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desktops'),
    'Through Desktops',
    'This is a premium desktops product trusted by many around the world.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming Laptops'),
    'Guy Gaming Laptops',
    'This is a premium gaming laptops product trusted by many around the world.',
    'Nike',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming Laptops'),
    'General Gaming Laptops',
    'This is a premium gaming laptops product trusted by many around the world.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming Laptops'),
    'Doctor Gaming Laptops',
    'This is a premium gaming laptops product trusted by many around the world.',
    'Puma',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'Admit Android Phones',
    'This is a premium android phones product trusted by many around the world.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'Start Android Phones',
    'This is a premium android phones product trusted by many around the world.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'One Android Phones',
    'This is a premium android phones product trusted by many around the world.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'Former iPhones',
    'This is a premium iphones product trusted by many around the world.',
    'LOréal',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'A iPhones',
    'This is a premium iphones product trusted by many around the world.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'Training iPhones',
    'This is a premium iphones product trusted by many around the world.',
    'Neutrogena',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'Reach Refrigerators',
    'This is a premium refrigerators product trusted by many around the world.',
    'OnePlus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'Draw Refrigerators',
    'This is a premium refrigerators product trusted by many around the world.',
    'Canon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'Value Refrigerators',
    'This is a premium refrigerators product trusted by many around the world.',
    'Nikon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'Woman Washing Machines',
    'This is a premium washing machines product trusted by many around the world.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'Next Washing Machines',
    'This is a premium washing machines product trusted by many around the world.',
    'Bosch',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'Down Washing Machines',
    'This is a premium washing machines product trusted by many around the world.',
    'Makita',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'Practice Suitcases',
    'This is a premium suitcases product trusted by many around the world.',
    'DeWalt',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'Artist Suitcases',
    'This is a premium suitcases product trusted by many around the world.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'At Suitcases',
    'This is a premium suitcases product trusted by many around the world.',
    'Rolex',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'Nation Backpacks',
    'This is a premium backpacks product trusted by many around the world.',
    'Fender',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'State Backpacks',
    'This is a premium backpacks product trusted by many around the world.',
    'Yamaha',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'Four Backpacks',
    'This is a premium backpacks product trusted by many around the world.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Despite DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many around the world.',
    'Pepsi',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Answer DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many around the world.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Kitchen DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many around the world.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Too Music Albums',
    'This is a premium music albums product trusted by many around the world.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Bad Music Albums',
    'This is a premium music albums product trusted by many around the world.',
    'GoPro',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Size Music Albums',
    'This is a premium music albums product trusted by many around the world.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Consoles'),
    'Subject Consoles',
    'This is a premium consoles product trusted by many around the world.',
    'PlayStation',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Consoles'),
    'Always Consoles',
    'This is a premium consoles product trusted by many around the world.',
    'Xbox',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Consoles'),
    'Per Consoles',
    'This is a premium consoles product trusted by many around the world.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Stage Video Games',
    'This is a premium video games product trusted by many around the world.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Season Video Games',
    'This is a premium video games product trusted by many around the world.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Employee Video Games',
    'This is a premium video games product trusted by many around the world.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Watches'),
    'Answer Men Watches',
    'This is a premium men watches product trusted by many around the world.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Watches'),
    'But Men Watches',
    'This is a premium men watches product trusted by many around the world.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Watches'),
    'Trouble Men Watches',
    'This is a premium men watches product trusted by many around the world.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Ever Smart Watches',
    'This is a premium smart watches product trusted by many around the world.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Attention Smart Watches',
    'This is a premium smart watches product trusted by many around the world.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Thank Smart Watches',
    'This is a premium smart watches product trusted by many around the world.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Design Cookware',
    'This is a premium cookware product trusted by many around the world.',
    'Nike',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Enough Cookware',
    'This is a premium cookware product trusted by many around the world.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Plan Cookware',
    'This is a premium cookware product trusted by many around the world.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'We Tableware',
    'This is a premium tableware product trusted by many around the world.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'Than Tableware',
    'This is a premium tableware product trusted by many around the world.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'Day Tableware',
    'This is a premium tableware product trusted by many around the world.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Us Christmas Decor',
    'This is a premium christmas decor product trusted by many around the world.',
    'LOréal',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Finally Christmas Decor',
    'This is a premium christmas decor product trusted by many around the world.',
    'Dove',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Reveal Christmas Decor',
    'This is a premium christmas decor product trusted by many around the world.',
    'Neutrogena',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Red Halloween Supplies',
    'This is a premium halloween supplies product trusted by many around the world.',
    'OnePlus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Return Halloween Supplies',
    'This is a premium halloween supplies product trusted by many around the world.',
    'Canon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Conference Halloween Supplies',
    'This is a premium halloween supplies product trusted by many around the world.',
    'Nikon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Security Systems'),
    'Social Home Security Systems',
    'This is a premium home security systems product trusted by many around the world.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Security Systems'),
    'Whose Home Security Systems',
    'This is a premium home security systems product trusted by many around the world.',
    'Bosch',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Security Systems'),
    'Owner Home Security Systems',
    'This is a premium home security systems product trusted by many around the world.',
    'Makita',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Along Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many around the world.',
    'DeWalt',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Discuss Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many around the world.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Key Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many around the world.',
    'Rolex',
    0,
    NOW(),
    NOW()
);
DELETE FROM Products WHERE category_id is null;
SELECT * FROM Products;

-- Verify inserted data
SELECT COUNT(*) AS total_products FROM Products;
SELECT p.title, p.brand, c.name AS category 
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LIMIT 10;
