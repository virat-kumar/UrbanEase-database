-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Reviews Table (30 entries)
-- Module: Product Reviews
-- Note: Requires Products and Users tables to exist first
-- =============================================

USE urbanease_shop;

-- Insert 30 product reviews with ratings 1-5
INSERT INTO Reviews (product_id, user_id, rating, title, body, created_at) VALUES
-- 5-star reviews (excellent)
(1, 2, 5, 'Best laptop I have ever owned!', 'The MacBook Pro M3 is absolutely amazing. The performance is unmatched and the battery life is incredible. Highly recommend for professionals.', '2024-10-20 10:00:00'),
(2, 3, 5, 'Fantastic phone', 'iPhone 15 Pro Max exceeded my expectations. The camera quality is stunning and the titanium design feels premium.', '2024-10-23 14:30:00'),
(5, 5, 5, 'Perfect sofa for my living room', 'Beautiful design and very comfortable. The grey color matches perfectly with my decor. Great quality for the price.', '2024-11-02 09:15:00'),
(10, 6, 5, 'Game changer for home workouts', 'These adjustable dumbbells saved so much space. Easy to use and feels solid. Best purchase this year.', '2024-11-05 16:20:00'),
(16, 8, 5, 'Excellent protection and comfort', 'These motorcycle gloves are top quality. Perfect fit, great grip, and excellent protection. Worth every penny.', '2024-06-15 11:45:00'),

-- 4-star reviews (very good)
(3, 4, 4, 'Great quality t-shirt', 'Very comfortable and fits well. The fabric quality is excellent. Only wish there were more color options.', '2024-02-10 12:30:00'),
(4, 7, 4, 'Beautiful dress', 'Love the floral pattern and the fit is perfect. Lost one star because it wrinkles easily, but still a great buy.', '2024-02-15 15:45:00'),
(7, 9, 4, 'Visible results after 2 weeks', 'My skin looks brighter and more even. Great serum but wish the bottle was bigger for the price.', '2024-03-20 10:20:00'),
(11, 10, 4, 'Good tent for the price', 'Easy to set up and kept us dry during rain. Spacious for 4 people. Could use better zippers though.', '2024-05-05 14:10:00'),
(13, 12, 4, 'Fun game for family nights', 'Catan is a great strategy game. Takes a bit to learn but very engaging once you get it. Recommend!', '2024-05-15 16:35:00'),
(20, 15, 4, 'Tasty and healthy', 'Love the taste and texture. High protein content is perfect for my diet. Just wish it was a bit cheaper.', '2024-07-25 09:50:00'),
(27, 21, 4, 'My dog loves it!', 'Great quality dog food. My dog\'s coat looks shinier and he has more energy. A bit pricey but worth it.', '2024-10-05 13:25:00'),

-- 3-star reviews (average/mixed)
(6, 11, 3, 'Decent wall art', 'The artwork is nice but the colors are not as vibrant as shown in the picture. It\'s okay for the price.', '2024-03-10 11:15:00'),
(8, 13, 3, 'Average shampoo', 'Does the job but nothing special. My hair feels clean but I did not notice any significant improvement.', '2024-03-25 14:40:00'),
(12, 14, 3, 'Okay running shorts', 'Comfortable but the fabric is a bit thin. Good for light workouts but might not last very long.', '2024-05-10 10:30:00'),
(17, 16, 3, 'Interesting plot but slow pacing', 'The mystery was intriguing but the story dragged in the middle. Decent read but not my favorite.', '2024-06-25 16:50:00'),
(23, 18, 3, 'Nice necklace but chain is delicate', 'The pendant is beautiful but the chain feels fragile. Worried it might break easily. Handle with care.', '2024-08-25 12:15:00'),

-- 2-star reviews (below average)
(9, 17, 2, 'Not worth the price', 'Expected better quality for a multivitamin. The pills are huge and hard to swallow. Not buying again.', '2024-04-10 09:20:00'),
(14, 19, 2, 'Disappointed with quality', 'The action figure looks cheap and the articulation is limited. My son expected better from Marvel.', '2024-05-25 15:10:00'),
(18, 20, 2, 'Journal pages bleed through', 'The leather cover is nice but the paper quality is poor. Ink bleeds through when using fountain pens.', '2024-07-10 11:35:00'),
(24, 22, 2, 'Earrings tarnished quickly', 'Looked great initially but the silver coating started coming off after a few wears. Not real quality.', '2024-09-05 14:25:00'),

-- 1-star reviews (poor)
(15, 23, 1, 'Fell off after one day', 'The magnetic mount is weak. My phone fell off multiple times while driving. Dangerous and useless.', '2024-06-05 10:45:00'),
(19, 24, 1, 'Stale and tasteless', 'The trail mix was stale and had no flavor. Seemed old. Very disappointed. Returning it.', '2024-07-15 16:20:00'),
(22, 25, 1, 'Caused rash on baby\'s skin', 'These wipes gave my baby a terrible rash. Not sensitive at all despite the label. Do not recommend.', '2024-08-15 09:30:00'),

-- More recent reviews
(25, 26, 4, 'Classy and comfortable shoes', 'These oxford shoes look great and are surprisingly comfortable. Good value for genuine leather.', '2024-09-15 13:45:00'),
(29, 27, 5, 'Ultimate comfort!', 'This recliner is incredibly comfortable. Perfect for watching movies. The leather quality is excellent.', '2024-10-25 15:30:00'),
(31, 28, 4, 'Reliable printer', 'Prints well and WiFi setup was easy. Scanner works great too. A bit slow but overall satisfied.', '2024-11-08 10:20:00'),
(33, 29, 5, 'Powerful drill', 'This DeWalt drill has excellent power and battery life. Great for DIY projects. Highly recommend!', '2024-11-10 14:50:00'),
(34, 30, 4, 'Great beginner guitar', 'Good quality for the price. Sounds nice and comes with everything you need to start learning.', '2024-11-11 11:15:00'),
(35, 2, 5, 'Professional quality paints', 'These watercolors are vibrant and blend beautifully. Perfect for serious artists. Worth the investment.', '2024-11-12 16:40:00');

-- Verify inserted data
SELECT COUNT(*) AS total_reviews FROM Reviews;
SELECT 
    r.review_id,
    p.title AS product_name,
    u.full_name AS reviewer,
    r.rating,
    r.title AS review_title,
    r.created_at
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Users u ON r.user_id = u.user_id
ORDER BY r.created_at DESC
LIMIT 10;
