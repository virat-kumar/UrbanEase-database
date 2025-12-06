-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Sample Data for ProductImages Table (85 entries)
-- Module: Product Catalog
-- Note: Requires Products table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 85 product images (1-2 images per product)
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Also Electronics'),
    'https://cdn.example.com/images/also_electronics_1.jpg',
    'Also Electronics - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Also Electronics'),
    'https://cdn.example.com/images/also_electronics_2.jpg',
    'Also Electronics - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Also Electronics'),
    'https://cdn.example.com/images/also_electronics_3.jpg',
    'Also Electronics - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Push Electronics'),
    'https://cdn.example.com/images/push_electronics_1.jpg',
    'Push Electronics - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Push Electronics'),
    'https://cdn.example.com/images/push_electronics_2.jpg',
    'Push Electronics - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Push Electronics'),
    'https://cdn.example.com/images/push_electronics_3.jpg',
    'Push Electronics - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Life Electronics'),
    'https://cdn.example.com/images/life_electronics_1.jpg',
    'Life Electronics - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Life Electronics'),
    'https://cdn.example.com/images/life_electronics_2.jpg',
    'Life Electronics - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Life Electronics'),
    'https://cdn.example.com/images/life_electronics_3.jpg',
    'Life Electronics - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Theory Clothing'),
    'https://cdn.example.com/images/theory_clothing_1.jpg',
    'Theory Clothing - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Theory Clothing'),
    'https://cdn.example.com/images/theory_clothing_2.jpg',
    'Theory Clothing - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Theory Clothing'),
    'https://cdn.example.com/images/theory_clothing_3.jpg',
    'Theory Clothing - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Believe Clothing'),
    'https://cdn.example.com/images/believe_clothing_1.jpg',
    'Believe Clothing - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Believe Clothing'),
    'https://cdn.example.com/images/believe_clothing_2.jpg',
    'Believe Clothing - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Believe Clothing'),
    'https://cdn.example.com/images/believe_clothing_3.jpg',
    'Believe Clothing - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Say Clothing'),
    'https://cdn.example.com/images/say_clothing_1.jpg',
    'Say Clothing - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Say Clothing'),
    'https://cdn.example.com/images/say_clothing_2.jpg',
    'Say Clothing - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Say Clothing'),
    'https://cdn.example.com/images/say_clothing_3.jpg',
    'Say Clothing - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Might Home & Garden'),
    'https://cdn.example.com/images/might_home_&_garden_1.jpg',
    'Might Home & Garden - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Might Home & Garden'),
    'https://cdn.example.com/images/might_home_&_garden_2.jpg',
    'Might Home & Garden - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Might Home & Garden'),
    'https://cdn.example.com/images/might_home_&_garden_3.jpg',
    'Might Home & Garden - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Scene Home & Garden'),
    'https://cdn.example.com/images/scene_home_&_garden_1.jpg',
    'Scene Home & Garden - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Scene Home & Garden'),
    'https://cdn.example.com/images/scene_home_&_garden_2.jpg',
    'Scene Home & Garden - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Scene Home & Garden'),
    'https://cdn.example.com/images/scene_home_&_garden_3.jpg',
    'Scene Home & Garden - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Red Home & Garden'),
    'https://cdn.example.com/images/red_home_&_garden_1.jpg',
    'Red Home & Garden - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Red Home & Garden'),
    'https://cdn.example.com/images/red_home_&_garden_2.jpg',
    'Red Home & Garden - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Red Home & Garden'),
    'https://cdn.example.com/images/red_home_&_garden_3.jpg',
    'Red Home & Garden - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Collection Beauty & Personal Care'),
    'https://cdn.example.com/images/collection_beauty_&_personal_care_1.jpg',
    'Collection Beauty & Personal Care - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Collection Beauty & Personal Care'),
    'https://cdn.example.com/images/collection_beauty_&_personal_care_2.jpg',
    'Collection Beauty & Personal Care - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Collection Beauty & Personal Care'),
    'https://cdn.example.com/images/collection_beauty_&_personal_care_3.jpg',
    'Collection Beauty & Personal Care - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Amount Beauty & Personal Care'),
    'https://cdn.example.com/images/amount_beauty_&_personal_care_1.jpg',
    'Amount Beauty & Personal Care - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Amount Beauty & Personal Care'),
    'https://cdn.example.com/images/amount_beauty_&_personal_care_2.jpg',
    'Amount Beauty & Personal Care - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Amount Beauty & Personal Care'),
    'https://cdn.example.com/images/amount_beauty_&_personal_care_3.jpg',
    'Amount Beauty & Personal Care - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Huge Beauty & Personal Care'),
    'https://cdn.example.com/images/huge_beauty_&_personal_care_1.jpg',
    'Huge Beauty & Personal Care - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Huge Beauty & Personal Care'),
    'https://cdn.example.com/images/huge_beauty_&_personal_care_2.jpg',
    'Huge Beauty & Personal Care - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Huge Beauty & Personal Care'),
    'https://cdn.example.com/images/huge_beauty_&_personal_care_3.jpg',
    'Huge Beauty & Personal Care - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Center Health & Wellness'),
    'https://cdn.example.com/images/center_health_&_wellness_1.jpg',
    'Center Health & Wellness - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Center Health & Wellness'),
    'https://cdn.example.com/images/center_health_&_wellness_2.jpg',
    'Center Health & Wellness - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Center Health & Wellness'),
    'https://cdn.example.com/images/center_health_&_wellness_3.jpg',
    'Center Health & Wellness - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Garden Health & Wellness'),
    'https://cdn.example.com/images/garden_health_&_wellness_1.jpg',
    'Garden Health & Wellness - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Garden Health & Wellness'),
    'https://cdn.example.com/images/garden_health_&_wellness_2.jpg',
    'Garden Health & Wellness - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Garden Health & Wellness'),
    'https://cdn.example.com/images/garden_health_&_wellness_3.jpg',
    'Garden Health & Wellness - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Ten Health & Wellness'),
    'https://cdn.example.com/images/ten_health_&_wellness_1.jpg',
    'Ten Health & Wellness - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Ten Health & Wellness'),
    'https://cdn.example.com/images/ten_health_&_wellness_2.jpg',
    'Ten Health & Wellness - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Ten Health & Wellness'),
    'https://cdn.example.com/images/ten_health_&_wellness_3.jpg',
    'Ten Health & Wellness - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Hair Sports & Outdoors'),
    'https://cdn.example.com/images/hair_sports_&_outdoors_1.jpg',
    'Hair Sports & Outdoors - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Hair Sports & Outdoors'),
    'https://cdn.example.com/images/hair_sports_&_outdoors_2.jpg',
    'Hair Sports & Outdoors - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Hair Sports & Outdoors'),
    'https://cdn.example.com/images/hair_sports_&_outdoors_3.jpg',
    'Hair Sports & Outdoors - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Page Sports & Outdoors'),
    'https://cdn.example.com/images/page_sports_&_outdoors_1.jpg',
    'Page Sports & Outdoors - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Page Sports & Outdoors'),
    'https://cdn.example.com/images/page_sports_&_outdoors_2.jpg',
    'Page Sports & Outdoors - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Page Sports & Outdoors'),
    'https://cdn.example.com/images/page_sports_&_outdoors_3.jpg',
    'Page Sports & Outdoors - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Peace Sports & Outdoors'),
    'https://cdn.example.com/images/peace_sports_&_outdoors_1.jpg',
    'Peace Sports & Outdoors - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Peace Sports & Outdoors'),
    'https://cdn.example.com/images/peace_sports_&_outdoors_2.jpg',
    'Peace Sports & Outdoors - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Peace Sports & Outdoors'),
    'https://cdn.example.com/images/peace_sports_&_outdoors_3.jpg',
    'Peace Sports & Outdoors - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Toward Toys & Games'),
    'https://cdn.example.com/images/toward_toys_&_games_1.jpg',
    'Toward Toys & Games - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Toward Toys & Games'),
    'https://cdn.example.com/images/toward_toys_&_games_2.jpg',
    'Toward Toys & Games - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Toward Toys & Games'),
    'https://cdn.example.com/images/toward_toys_&_games_3.jpg',
    'Toward Toys & Games - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'President Toys & Games'),
    'https://cdn.example.com/images/president_toys_&_games_1.jpg',
    'President Toys & Games - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'President Toys & Games'),
    'https://cdn.example.com/images/president_toys_&_games_2.jpg',
    'President Toys & Games - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'President Toys & Games'),
    'https://cdn.example.com/images/president_toys_&_games_3.jpg',
    'President Toys & Games - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Rock Automotive'),
    'https://cdn.example.com/images/rock_automotive_1.jpg',
    'Rock Automotive - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Rock Automotive'),
    'https://cdn.example.com/images/rock_automotive_2.jpg',
    'Rock Automotive - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Rock Automotive'),
    'https://cdn.example.com/images/rock_automotive_3.jpg',
    'Rock Automotive - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Guy Automotive'),
    'https://cdn.example.com/images/guy_automotive_1.jpg',
    'Guy Automotive - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Guy Automotive'),
    'https://cdn.example.com/images/guy_automotive_2.jpg',
    'Guy Automotive - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Guy Automotive'),
    'https://cdn.example.com/images/guy_automotive_3.jpg',
    'Guy Automotive - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Professor Automotive'),
    'https://cdn.example.com/images/professor_automotive_1.jpg',
    'Professor Automotive - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Professor Automotive'),
    'https://cdn.example.com/images/professor_automotive_2.jpg',
    'Professor Automotive - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Professor Automotive'),
    'https://cdn.example.com/images/professor_automotive_3.jpg',
    'Professor Automotive - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Service Books & Stationery'),
    'https://cdn.example.com/images/service_books_&_stationery_1.jpg',
    'Service Books & Stationery - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Service Books & Stationery'),
    'https://cdn.example.com/images/service_books_&_stationery_2.jpg',
    'Service Books & Stationery - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Service Books & Stationery'),
    'https://cdn.example.com/images/service_books_&_stationery_3.jpg',
    'Service Books & Stationery - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Event Books & Stationery'),
    'https://cdn.example.com/images/event_books_&_stationery_1.jpg',
    'Event Books & Stationery - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Event Books & Stationery'),
    'https://cdn.example.com/images/event_books_&_stationery_2.jpg',
    'Event Books & Stationery - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Event Books & Stationery'),
    'https://cdn.example.com/images/event_books_&_stationery_3.jpg',
    'Event Books & Stationery - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Exist Books & Stationery'),
    'https://cdn.example.com/images/exist_books_&_stationery_1.jpg',
    'Exist Books & Stationery - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Exist Books & Stationery'),
    'https://cdn.example.com/images/exist_books_&_stationery_2.jpg',
    'Exist Books & Stationery - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Exist Books & Stationery'),
    'https://cdn.example.com/images/exist_books_&_stationery_3.jpg',
    'Exist Books & Stationery - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Democratic Groceries'),
    'https://cdn.example.com/images/democratic_groceries_1.jpg',
    'Democratic Groceries - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Democratic Groceries'),
    'https://cdn.example.com/images/democratic_groceries_2.jpg',
    'Democratic Groceries - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Democratic Groceries'),
    'https://cdn.example.com/images/democratic_groceries_3.jpg',
    'Democratic Groceries - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Whether Groceries'),
    'https://cdn.example.com/images/whether_groceries_1.jpg',
    'Whether Groceries - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Whether Groceries'),
    'https://cdn.example.com/images/whether_groceries_2.jpg',
    'Whether Groceries - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Whether Groceries'),
    'https://cdn.example.com/images/whether_groceries_3.jpg',
    'Whether Groceries - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Talk Baby & Kids'),
    'https://cdn.example.com/images/talk_baby_&_kids_1.jpg',
    'Talk Baby & Kids - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Talk Baby & Kids'),
    'https://cdn.example.com/images/talk_baby_&_kids_2.jpg',
    'Talk Baby & Kids - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Talk Baby & Kids'),
    'https://cdn.example.com/images/talk_baby_&_kids_3.jpg',
    'Talk Baby & Kids - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Opportunity Baby & Kids'),
    'https://cdn.example.com/images/opportunity_baby_&_kids_1.jpg',
    'Opportunity Baby & Kids - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Opportunity Baby & Kids'),
    'https://cdn.example.com/images/opportunity_baby_&_kids_2.jpg',
    'Opportunity Baby & Kids - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Opportunity Baby & Kids'),
    'https://cdn.example.com/images/opportunity_baby_&_kids_3.jpg',
    'Opportunity Baby & Kids - Image 3',
    3
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Couple Baby & Kids'),
    'https://cdn.example.com/images/couple_baby_&_kids_1.jpg',
    'Couple Baby & Kids - Image 1',
    1
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Couple Baby & Kids'),
    'https://cdn.example.com/images/couple_baby_&_kids_2.jpg',
    'Couple Baby & Kids - Image 2',
    2
);
INSERT INTO ProductImages (product_id, url, alt_text, sort_order)
VALUES (
    (SELECT product_id FROM Products WHERE title = 'Couple Baby & Kids'),
    'https://cdn.example.com/images/couple_baby_&_kids_3.jpg',
    'Couple Baby & Kids - Image 3',
    3
);
-- Verify inserted data
SELECT COUNT(*) AS total_images FROM ProductImages;
SELECT pi.image_id, p.title, pi.alt_text, pi.sort_order
FROM ProductImages pi
JOIN Products p ON pi.product_id = p.product_id
LIMIT 10;
