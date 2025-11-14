-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for Products Table 
-- Module: Product Catalog
-- Note: Requires Categories table to exist first
-- =============================================

USE urbanease_shop;

-- Insert diverse products across different categories
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Electronics'),
    'Also Electronics',
    'This is a premium electronics product trusted by many customers.',
    'DeWalt',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Electronics'),
    'Push Electronics',
    'This is a premium electronics product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Electronics'),
    'Life Electronics',
    'This is a premium electronics product trusted by many customers.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Clothing'),
    'Theory Clothing',
    'This is a premium clothing product trusted by many customers.',
    'IKEA',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Clothing'),
    'Believe Clothing',
    'This is a premium clothing product trusted by many customers.',
    'LOréal',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Clothing'),
    'Say Clothing',
    'This is a premium clothing product trusted by many customers.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home & Garden'),
    'Might Home & Garden',
    'This is a premium home & garden product trusted by many customers.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home & Garden'),
    'Scene Home & Garden',
    'This is a premium home & garden product trusted by many customers.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home & Garden'),
    'Red Home & Garden',
    'This is a premium home & garden product trusted by many customers.',
    'Philips',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Beauty & Personal Care'),
    'Collection Beauty & Personal Care',
    'This is a premium beauty & personal care product trusted by many customers.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Beauty & Personal Care'),
    'Amount Beauty & Personal Care',
    'This is a premium beauty & personal care product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Beauty & Personal Care'),
    'Huge Beauty & Personal Care',
    'This is a premium beauty & personal care product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Health & Wellness'),
    'Center Health & Wellness',
    'This is a premium health & wellness product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Health & Wellness'),
    'Garden Health & Wellness',
    'This is a premium health & wellness product trusted by many customers.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Health & Wellness'),
    'Ten Health & Wellness',
    'This is a premium health & wellness product trusted by many customers.',
    'OnePlus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sports & Outdoors'),
    'Hair Sports & Outdoors',
    'This is a premium sports & outdoors product trusted by many customers.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sports & Outdoors'),
    'Page Sports & Outdoors',
    'This is a premium sports & outdoors product trusted by many customers.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sports & Outdoors'),
    'Peace Sports & Outdoors',
    'This is a premium sports & outdoors product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Toys & Games'),
    'Toward Toys & Games',
    'This is a premium toys & games product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Toys & Games'),
    'President Toys & Games',
    'This is a premium toys & games product trusted by many customers.',
    'Nikon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Automotive'),
    'Rock Automotive',
    'This is a premium automotive product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Automotive'),
    'Guy Automotive',
    'This is a premium automotive product trusted by many customers.',
    'Amazon Basics',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Automotive'),
    'Professor Automotive',
    'This is a premium automotive product trusted by many customers.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Books & Stationery'),
    'Service Books & Stationery',
    'This is a premium books & stationery product trusted by many customers.',
    'Xbox',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Books & Stationery'),
    'Event Books & Stationery',
    'This is a premium books & stationery product trusted by many customers.',
    'Zara',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Books & Stationery'),
    'Exist Books & Stationery',
    'This is a premium books & stationery product trusted by many customers.',
    'Huggies',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Groceries'),
    'Democratic Groceries',
    'This is a premium groceries product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Groceries'),
    'Whether Groceries',
    'This is a premium groceries product trusted by many customers.',
    'Canon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby & Kids'),
    'Talk Baby & Kids',
    'This is a premium baby & kids product trusted by many customers.',
    'Rolex',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby & Kids'),
    'Opportunity Baby & Kids',
    'This is a premium baby & kids product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby & Kids'),
    'Couple Baby & Kids',
    'This is a premium baby & kids product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Jewelry & Accessories'),
    'Across Jewelry & Accessories',
    'This is a premium jewelry & accessories product trusted by many customers.',
    'Nike',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Jewelry & Accessories'),
    'Deal Jewelry & Accessories',
    'This is a premium jewelry & accessories product trusted by many customers.',
    'Casio',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Jewelry & Accessories'),
    'Training Jewelry & Accessories',
    'This is a premium jewelry & accessories product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Shoes & Footwear'),
    'Born Shoes & Footwear',
    'This is a premium shoes & footwear product trusted by many customers.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Shoes & Footwear'),
    'Response Shoes & Footwear',
    'This is a premium shoes & footwear product trusted by many customers.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Shoes & Footwear'),
    'Cultural Shoes & Footwear',
    'This is a premium shoes & footwear product trusted by many customers.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Pet Supplies'),
    'Clearly Pet Supplies',
    'This is a premium pet supplies product trusted by many customers.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Pet Supplies'),
    'Top Pet Supplies',
    'This is a premium pet supplies product trusted by many customers.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Pet Supplies'),
    'One Pet Supplies',
    'This is a premium pet supplies product trusted by many customers.',
    'Xbox',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture'),
    'Debate Furniture',
    'This is a premium furniture product trusted by many customers.',
    'Yamaha',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture'),
    'Can Furniture',
    'This is a premium furniture product trusted by many customers.',
    'Apple',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Office Supplies'),
    'Experience Office Supplies',
    'This is a premium office supplies product trusted by many customers.',
    'DeWalt',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Office Supplies'),
    'Throughout Office Supplies',
    'This is a premium office supplies product trusted by many customers.',
    'Pepsi',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Office Supplies'),
    'Itself Office Supplies',
    'This is a premium office supplies product trusted by many customers.',
    'Casio',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tools & Hardware'),
    'Entire Tools & Hardware',
    'This is a premium tools & hardware product trusted by many customers.',
    'Canon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tools & Hardware'),
    'Live Tools & Hardware',
    'This is a premium tools & hardware product trusted by many customers.',
    'IKEA',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tools & Hardware'),
    'Structure Tools & Hardware',
    'This is a premium tools & hardware product trusted by many customers.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Musical Instruments'),
    'Stock Musical Instruments',
    'This is a premium musical instruments product trusted by many customers.',
    'Microsoft',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Musical Instruments'),
    'Father Musical Instruments',
    'This is a premium musical instruments product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Arts & Crafts'),
    'Join Arts & Crafts',
    'This is a premium arts & crafts product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Arts & Crafts'),
    'Check Arts & Crafts',
    'This is a premium arts & crafts product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cameras & Photography'),
    'Treat Cameras & Photography',
    'This is a premium cameras & photography product trusted by many customers.',
    'Neutrogena',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cameras & Photography'),
    'Way Cameras & Photography',
    'This is a premium cameras & photography product trusted by many customers.',
    'Yamaha',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cameras & Photography'),
    'Themselves Cameras & Photography',
    'This is a premium cameras & photography product trusted by many customers.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Computers & Laptops'),
    'Player Computers & Laptops',
    'This is a premium computers & laptops product trusted by many customers.',
    'OnePlus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Computers & Laptops'),
    'Down Computers & Laptops',
    'This is a premium computers & laptops product trusted by many customers.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Computers & Laptops'),
    'Least Computers & Laptops',
    'This is a premium computers & laptops product trusted by many customers.',
    'Apple',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Mobile Phones & Tablets'),
    'Pm Mobile Phones & Tablets',
    'This is a premium mobile phones & tablets product trusted by many customers.',
    'Nikon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Mobile Phones & Tablets'),
    'Program Mobile Phones & Tablets',
    'This is a premium mobile phones & tablets product trusted by many customers.',
    'Coca-Cola',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Mobile Phones & Tablets'),
    'Yet Mobile Phones & Tablets',
    'This is a premium mobile phones & tablets product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Appliances'),
    'Understand Appliances',
    'This is a premium appliances product trusted by many customers.',
    'Reebok',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Appliances'),
    'Fall Appliances',
    'This is a premium appliances product trusted by many customers.',
    'Pepsi',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Appliances'),
    'Report Appliances',
    'This is a premium appliances product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Travel & Luggage'),
    'Artist Travel & Luggage',
    'This is a premium travel & luggage product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Travel & Luggage'),
    'Player Travel & Luggage',
    'This is a premium travel & luggage product trusted by many customers.',
    'Nike',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Movies & Entertainment'),
    'Between Movies & Entertainment',
    'This is a premium movies & entertainment product trusted by many customers.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Movies & Entertainment'),
    'Seat Movies & Entertainment',
    'This is a premium movies & entertainment product trusted by many customers.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming'),
    'Life Gaming',
    'This is a premium gaming product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming'),
    'Leader Gaming',
    'This is a premium gaming product trusted by many customers.',
    'Bosch',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming'),
    'Television Gaming',
    'This is a premium gaming product trusted by many customers.',
    'OnePlus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Watches'),
    'Fine Watches',
    'This is a premium watches product trusted by many customers.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Watches'),
    'Enter Watches',
    'This is a premium watches product trusted by many customers.',
    'Dell',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Watches'),
    'Both Watches',
    'This is a premium watches product trusted by many customers.',
    'PlayStation',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Kitchen & Dining'),
    'Feel Kitchen & Dining',
    'This is a premium kitchen & dining product trusted by many customers.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Kitchen & Dining'),
    'Sea Kitchen & Dining',
    'This is a premium kitchen & dining product trusted by many customers.',
    'Yamaha',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Kitchen & Dining'),
    'Situation Kitchen & Dining',
    'This is a premium kitchen & dining product trusted by many customers.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Seasonal & Holiday'),
    'Animal Seasonal & Holiday',
    'This is a premium seasonal & holiday product trusted by many customers.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Seasonal & Holiday'),
    'Cost Seasonal & Holiday',
    'This is a premium seasonal & holiday product trusted by many customers.',
    'Microsoft',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Safety & Security'),
    'Conference Safety & Security',
    'This is a premium safety & security product trusted by many customers.',
    'LG',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Safety & Security'),
    'Tonight Safety & Security',
    'This is a premium safety & security product trusted by many customers.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Safety & Security'),
    'Down Safety & Security',
    'This is a premium safety & security product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Laptops'),
    'Want Laptops',
    'This is a premium laptops product trusted by many customers.',
    'Nestle',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Laptops'),
    'Teacher Laptops',
    'This is a premium laptops product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'Job Smartphones',
    'This is a premium smartphones product trusted by many customers.',
    'Samsung',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'Purpose Smartphones',
    'This is a premium smartphones product trusted by many customers.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smartphones'),
    'State Smartphones',
    'This is a premium smartphones product trusted by many customers.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Clothing'),
    'Contain Men Clothing',
    'This is a premium men clothing product trusted by many customers.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Clothing'),
    'Will Men Clothing',
    'This is a premium men clothing product trusted by many customers.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Clothing'),
    'Concern Women Clothing',
    'This is a premium women clothing product trusted by many customers.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Clothing'),
    'Deep Women Clothing',
    'This is a premium women clothing product trusted by many customers.',
    'Logitech',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Situation Furniture Sets',
    'This is a premium furniture sets product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Office Furniture Sets',
    'This is a premium furniture sets product trusted by many customers.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Furniture Sets'),
    'Bed Furniture Sets',
    'This is a premium furniture sets product trusted by many customers.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Decor'),
    'Similar Home Decor',
    'This is a premium home decor product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Decor'),
    'Unit Home Decor',
    'This is a premium home decor product trusted by many customers.',
    'Philips',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Skincare'),
    'Its Skincare',
    'This is a premium skincare product trusted by many customers.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Skincare'),
    'Newspaper Skincare',
    'This is a premium skincare product trusted by many customers.',
    'Nike',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Audience Hair Care',
    'This is a premium hair care product trusted by many customers.',
    'Xbox',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Material Hair Care',
    'This is a premium hair care product trusted by many customers.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hair Care'),
    'Issue Hair Care',
    'This is a premium hair care product trusted by many customers.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'This Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many customers.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'Pretty Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many customers.',
    'Nikon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Vitamins & Supplements'),
    'Price Vitamins & Supplements',
    'This is a premium vitamins & supplements product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fitness Equipment'),
    'Sometimes Fitness Equipment',
    'This is a premium fitness equipment product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fitness Equipment'),
    'No Fitness Equipment',
    'This is a premium fitness equipment product trusted by many customers.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Budget Camping & Hiking',
    'This is a premium camping & hiking product trusted by many customers.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Role Camping & Hiking',
    'This is a premium camping & hiking product trusted by many customers.',
    'Nestle',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camping & Hiking'),
    'Maintain Camping & Hiking',
    'This is a premium camping & hiking product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sportswear'),
    'Main Sportswear',
    'This is a premium sportswear product trusted by many customers.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Sportswear'),
    'Hot Sportswear',
    'This is a premium sportswear product trusted by many customers.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Board Games'),
    'Yes Board Games',
    'This is a premium board games product trusted by many customers.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Board Games'),
    'Offer Board Games',
    'This is a premium board games product trusted by many customers.',
    'Neutrogena',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Action Figures'),
    'Share Action Figures',
    'This is a premium action figures product trusted by many customers.',
    'Amazon Basics',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Action Figures'),
    'Wish Action Figures',
    'This is a premium action figures product trusted by many customers.',
    'PlayStation',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Rest Car Accessories',
    'This is a premium car accessories product trusted by many customers.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Baby Car Accessories',
    'This is a premium car accessories product trusted by many customers.',
    'Coca-Cola',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Car Accessories'),
    'Can Car Accessories',
    'This is a premium car accessories product trusted by many customers.',
    'Samsung',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'This Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many customers.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'Quickly Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many customers.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Motorbike Accessories'),
    'Seem Motorbike Accessories',
    'This is a premium motorbike accessories product trusted by many customers.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'Military Fiction Books',
    'This is a premium fiction books product trusted by many customers.',
    'Adidas',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'Truth Fiction Books',
    'This is a premium fiction books product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Fiction Books'),
    'Skill Fiction Books',
    'This is a premium fiction books product trusted by many customers.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Notebooks & Diaries'),
    'Direction Notebooks & Diaries',
    'This is a premium notebooks & diaries product trusted by many customers.',
    'Nestle',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Notebooks & Diaries'),
    'Off Notebooks & Diaries',
    'This is a premium notebooks & diaries product trusted by many customers.',
    'Samsung',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Snacks & Beverages'),
    'She Snacks & Beverages',
    'This is a premium snacks & beverages product trusted by many customers.',
    'Microsoft',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Snacks & Beverages'),
    'Final Snacks & Beverages',
    'This is a premium snacks & beverages product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dairy Products'),
    'From Dairy Products',
    'This is a premium dairy products product trusted by many customers.',
    'Adidas',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dairy Products'),
    'Force Dairy Products',
    'This is a premium dairy products product trusted by many customers.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Share Baby Clothing',
    'This is a premium baby clothing product trusted by many customers.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Size Baby Clothing',
    'This is a premium baby clothing product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Clothing'),
    'Onto Baby Clothing',
    'This is a premium baby clothing product trusted by many customers.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Whose Baby Care',
    'This is a premium baby care product trusted by many customers.',
    'DeWalt',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Beyond Baby Care',
    'This is a premium baby care product trusted by many customers.',
    'Nikon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Baby Care'),
    'Soldier Baby Care',
    'This is a premium baby care product trusted by many customers.',
    'Xbox',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Necklaces'),
    'Glass Necklaces',
    'This is a premium necklaces product trusted by many customers.',
    'Asus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Necklaces'),
    'Most Necklaces',
    'This is a premium necklaces product trusted by many customers.',
    'Nikon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Low Earrings',
    'This is a premium earrings product trusted by many customers.',
    'Nike',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Either Earrings',
    'This is a premium earrings product trusted by many customers.',
    'PlayStation',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Earrings'),
    'Current Earrings',
    'This is a premium earrings product trusted by many customers.',
    'IKEA',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Likely Men Footwear',
    'This is a premium men footwear product trusted by many customers.',
    'LOréal',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Share Men Footwear',
    'This is a premium men footwear product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Footwear'),
    'Wear Men Footwear',
    'This is a premium men footwear product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'Take Women Footwear',
    'This is a premium women footwear product trusted by many customers.',
    'Huggies',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'Success Women Footwear',
    'This is a premium women footwear product trusted by many customers.',
    'LOréal',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Women Footwear'),
    'Remain Women Footwear',
    'This is a premium women footwear product trusted by many customers.',
    'LG',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Western Dog Supplies',
    'This is a premium dog supplies product trusted by many customers.',
    'Samsung',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Watch Dog Supplies',
    'This is a premium dog supplies product trusted by many customers.',
    'Sony',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Dog Supplies'),
    'Score Dog Supplies',
    'This is a premium dog supplies product trusted by many customers.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'Material Cat Supplies',
    'This is a premium cat supplies product trusted by many customers.',
    'Xbox',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'Than Cat Supplies',
    'This is a premium cat supplies product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cat Supplies'),
    'Professor Cat Supplies',
    'This is a premium cat supplies product trusted by many customers.',
    'Reebok',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Difficult Living Room Furniture',
    'This is a premium living room furniture product trusted by many customers.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Unit Living Room Furniture',
    'This is a premium living room furniture product trusted by many customers.',
    'Logitech',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Living Room Furniture'),
    'Oil Living Room Furniture',
    'This is a premium living room furniture product trusted by many customers.',
    'Adidas',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Guy Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many customers.',
    'Makita',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Discuss Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many customers.',
    'Xbox',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Bedroom Furniture'),
    'Husband Bedroom Furniture',
    'This is a premium bedroom furniture product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Wall Printers & Scanners',
    'This is a premium printers & scanners product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Television Printers & Scanners',
    'This is a premium printers & scanners product trusted by many customers.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Printers & Scanners'),
    'Land Printers & Scanners',
    'This is a premium printers & scanners product trusted by many customers.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desk Accessories'),
    'Pay Desk Accessories',
    'This is a premium desk accessories product trusted by many customers.',
    'OnePlus',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desk Accessories'),
    'Within Desk Accessories',
    'This is a premium desk accessories product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Everyone Power Tools',
    'This is a premium power tools product trusted by many customers.',
    'Fender',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Program Power Tools',
    'This is a premium power tools product trusted by many customers.',
    'Huggies',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Power Tools'),
    'Boy Power Tools',
    'This is a premium power tools product trusted by many customers.',
    'Huggies',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Affect Hand Tools',
    'This is a premium hand tools product trusted by many customers.',
    'Dove',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Central Hand Tools',
    'This is a premium hand tools product trusted by many customers.',
    'LG',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Hand Tools'),
    'Mrs Hand Tools',
    'This is a premium hand tools product trusted by many customers.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'Stock Guitars',
    'This is a premium guitars product trusted by many customers.',
    'Nestle',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'Anything Guitars',
    'This is a premium guitars product trusted by many customers.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Guitars'),
    'Ability Guitars',
    'This is a premium guitars product trusted by many customers.',
    'LG',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Specific Keyboards',
    'This is a premium keyboards product trusted by many customers.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Son Keyboards',
    'This is a premium keyboards product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Keyboards'),
    'Next Keyboards',
    'This is a premium keyboards product trusted by many customers.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Surface Painting Supplies',
    'This is a premium painting supplies product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Particularly Painting Supplies',
    'This is a premium painting supplies product trusted by many customers.',
    'Sony',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Painting Supplies'),
    'Ever Painting Supplies',
    'This is a premium painting supplies product trusted by many customers.',
    'GoPro',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Treat Craft Kits',
    'This is a premium craft kits product trusted by many customers.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Gun Craft Kits',
    'This is a premium craft kits product trusted by many customers.',
    'Zara',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Craft Kits'),
    'Else Craft Kits',
    'This is a premium craft kits product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Forward DSLR Cameras',
    'This is a premium dslr cameras product trusted by many customers.',
    'Casio',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Professional DSLR Cameras',
    'This is a premium dslr cameras product trusted by many customers.',
    'Puma',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DSLR Cameras'),
    'Technology DSLR Cameras',
    'This is a premium dslr cameras product trusted by many customers.',
    'Yamaha',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camera Lenses'),
    'Authority Camera Lenses',
    'This is a premium camera lenses product trusted by many customers.',
    'Asus',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Camera Lenses'),
    'New Camera Lenses',
    'This is a premium camera lenses product trusted by many customers.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desktops'),
    'Prove Desktops',
    'This is a premium desktops product trusted by many customers.',
    'Makita',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Desktops'),
    'Usually Desktops',
    'This is a premium desktops product trusted by many customers.',
    'Fender',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming Laptops'),
    'Strong Gaming Laptops',
    'This is a premium gaming laptops product trusted by many customers.',
    'PlayStation',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Gaming Laptops'),
    'Air Gaming Laptops',
    'This is a premium gaming laptops product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'Be Android Phones',
    'This is a premium android phones product trusted by many customers.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'Smile Android Phones',
    'This is a premium android phones product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Android Phones'),
    'Single Android Phones',
    'This is a premium android phones product trusted by many customers.',
    'DeWalt',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'Although iPhones',
    'This is a premium iphones product trusted by many customers.',
    'Microsoft',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'Water iPhones',
    'This is a premium iphones product trusted by many customers.',
    'H&M',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'iPhones'),
    'Back iPhones',
    'This is a premium iphones product trusted by many customers.',
    'GoPro',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'Born Refrigerators',
    'This is a premium refrigerators product trusted by many customers.',
    'Coca-Cola',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'These Refrigerators',
    'This is a premium refrigerators product trusted by many customers.',
    'Dell',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Refrigerators'),
    'Car Refrigerators',
    'This is a premium refrigerators product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'Produce Washing Machines',
    'This is a premium washing machines product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'System Washing Machines',
    'This is a premium washing machines product trusted by many customers.',
    'Lenovo',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Washing Machines'),
    'Color Washing Machines',
    'This is a premium washing machines product trusted by many customers.',
    'Sony',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'Class Suitcases',
    'This is a premium suitcases product trusted by many customers.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'Difficult Suitcases',
    'This is a premium suitcases product trusted by many customers.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Suitcases'),
    'Identify Suitcases',
    'This is a premium suitcases product trusted by many customers.',
    'Sony',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'Try Backpacks',
    'This is a premium backpacks product trusted by many customers.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'Picture Backpacks',
    'This is a premium backpacks product trusted by many customers.',
    'Dove',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Backpacks'),
    'Evidence Backpacks',
    'This is a premium backpacks product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Son DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many customers.',
    'LG',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Everything DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many customers.',
    'GoPro',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'DVDs & Blu-rays'),
    'Establish DVDs & Blu-rays',
    'This is a premium dvds & blu-rays product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Opportunity Music Albums',
    'This is a premium music albums product trusted by many customers.',
    'Bosch',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Huge Music Albums',
    'This is a premium music albums product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Music Albums'),
    'Road Music Albums',
    'This is a premium music albums product trusted by many customers.',
    'Casio',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Consoles'),
    'These Consoles',
    'This is a premium consoles product trusted by many customers.',
    'HP',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Consoles'),
    'Follow Consoles',
    'This is a premium consoles product trusted by many customers.',
    'HP',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Week Video Games',
    'This is a premium video games product trusted by many customers.',
    'Coca-Cola',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Manage Video Games',
    'This is a premium video games product trusted by many customers.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Video Games'),
    'Like Video Games',
    'This is a premium video games product trusted by many customers.',
    'Amazon Basics',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Watches'),
    'Question Men Watches',
    'This is a premium men watches product trusted by many customers.',
    'Amazon Basics',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Men Watches'),
    'Among Men Watches',
    'This is a premium men watches product trusted by many customers.',
    'H&M',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Inside Smart Watches',
    'This is a premium smart watches product trusted by many customers.',
    'Canon',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Mrs Smart Watches',
    'This is a premium smart watches product trusted by many customers.',
    'Yamaha',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Smart Watches'),
    'Read Smart Watches',
    'This is a premium smart watches product trusted by many customers.',
    'Canon',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Vote Cookware',
    'This is a premium cookware product trusted by many customers.',
    'Philips',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Perhaps Cookware',
    'This is a premium cookware product trusted by many customers.',
    'Rolex',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Cookware'),
    'Situation Cookware',
    'This is a premium cookware product trusted by many customers.',
    'Neutrogena',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'Blood Tableware',
    'This is a premium tableware product trusted by many customers.',
    'Makita',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'Person Tableware',
    'This is a premium tableware product trusted by many customers.',
    'Zara',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Tableware'),
    'Ground Tableware',
    'This is a premium tableware product trusted by many customers.',
    'Zara',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Low Christmas Decor',
    'This is a premium christmas decor product trusted by many customers.',
    'Philips',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Kind Christmas Decor',
    'This is a premium christmas decor product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Christmas Decor'),
    'Whom Christmas Decor',
    'This is a premium christmas decor product trusted by many customers.',
    'Logitech',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Plant Halloween Supplies',
    'This is a premium halloween supplies product trusted by many customers.',
    'Lenovo',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Professor Halloween Supplies',
    'This is a premium halloween supplies product trusted by many customers.',
    'Puma',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Halloween Supplies'),
    'Industry Halloween Supplies',
    'This is a premium halloween supplies product trusted by many customers.',
    'Apple',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Security Systems'),
    'Bill Home Security Systems',
    'This is a premium home security systems product trusted by many customers.',
    'Rolex',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Home Security Systems'),
    'End Home Security Systems',
    'This is a premium home security systems product trusted by many customers.',
    'Pepsi',
    0,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Place Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many customers.',
    'Reebok',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Player Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many customers.',
    'Casio',
    1,
    NOW(),
    NOW()
);
INSERT INTO Products (category_id, title, description, brand, is_active, created_at, updated_at)
VALUES (
    (SELECT category_id FROM Categories WHERE name = 'Surveillance Cameras'),
    'Dream Surveillance Cameras',
    'This is a premium surveillance cameras product trusted by many customers.',
    'Huggies',
    0,
    NOW(),
    NOW()
);
SELECT * FROM Products;

-- Verify inserted data
SELECT COUNT(*) AS total_products FROM Products;
SELECT p.title, p.brand, c.name AS category 
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LIMIT 10;
