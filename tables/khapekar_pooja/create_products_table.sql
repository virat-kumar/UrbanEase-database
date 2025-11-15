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
SELECT * FROM Products;

-- Verify inserted data
SELECT COUNT(*) AS total_products FROM Products;
SELECT p.title, p.brand, c.name AS category 
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LIMIT 10;
