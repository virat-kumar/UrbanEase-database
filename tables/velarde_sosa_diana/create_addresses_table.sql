-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Addresses Table (35 entries)
-- Module: User Addresses
-- Note: Requires Users table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 user addresses (shipping and billing)
INSERT INTO Addresses (user_id, label, name, line1, line2, city, state_region, postal_code, country_code, phone, is_default, created_at) VALUES
-- User 2 addresses
(2, 'Home', 'John Doe', '123 Main Street', 'Apt 4B', 'New York', 'New York', '10001', 'US', '+1-555-0102', TRUE, '2024-02-20 15:00:00'),
(2, 'Office', 'John Doe', '456 Business Ave', 'Suite 200', 'New York', 'New York', '10002', 'US', '+1-555-0102', FALSE, '2024-03-10 10:30:00'),

-- User 3 addresses
(3, 'Home', 'Jane Smith', '789 Oak Drive', NULL, 'Los Angeles', 'California', '90001', 'US', '+1-555-0103', TRUE, '2024-02-21 11:00:00'),

-- User 4 addresses
(4, 'Home', 'Michael Brown', '321 Elm Street', 'Unit 12', 'Chicago', 'Illinois', '60601', 'US', '+1-555-0104', TRUE, '2024-03-05 17:15:00'),

-- User 5 addresses
(5, 'Home', 'Emily Davis', '654 Pine Road', NULL, 'Houston', 'Texas', '77001', 'US', '+1-555-0105', TRUE, '2024-03-10 12:00:00'),
(5, 'Work', 'Emily Davis', '987 Corporate Blvd', 'Floor 15', 'Houston', 'Texas', '77002', 'US', '+1-555-0105', FALSE, '2024-04-05 14:20:00'),

-- User 6 addresses
(6, 'Home', 'David Wilson', '147 Maple Lane', NULL, 'Phoenix', 'Arizona', '85001', 'US', '+1-555-0106', TRUE, '2024-03-15 14:00:00'),

-- User 7 addresses
(7, 'Home', 'Sarah Martinez', '258 Cedar Avenue', 'Apt 8C', 'Philadelphia', 'Pennsylvania', '19101', 'US', '+1-555-0107', TRUE, '2024-04-01 09:30:00'),

-- User 8 addresses
(8, 'Home', 'James Anderson', '369 Birch Street', NULL, 'San Antonio', 'Texas', '78201', 'US', '+1-555-0108', TRUE, '2024-04-05 16:00:00'),

-- User 9 addresses
(9, 'Home', 'Lisa Taylor', '741 Willow Court', 'Unit 5A', 'San Diego', 'California', '92101', 'US', '+1-555-0109', TRUE, '2024-04-12 11:15:00'),

-- User 10 addresses
(10, 'Home', 'Robert Thomas', '852 Spruce Way', NULL, 'Dallas', 'Texas', '75201', 'US', '+1-555-0110', TRUE, '2024-04-20 13:30:00'),

-- User 11 addresses
(11, 'Home', 'Jennifer Jackson', '963 Ash Boulevard', 'Apt 3D', 'San Jose', 'California', '95101', 'US', '+1-555-0111', TRUE, '2024-05-01 10:45:00'),

-- User 12 addresses
(12, 'Home', 'William White', '159 Poplar Street', NULL, 'Austin', 'Texas', '73301', 'US', '+1-555-0112', TRUE, '2024-05-08 15:00:00'),

-- User 13 addresses
(13, 'Home', 'Mary Harris', '357 Cypress Drive', 'Suite 10', 'Jacksonville', 'Florida', '32099', 'US', '+1-555-0113', TRUE, '2024-05-15 12:20:00'),

-- User 14 addresses
(14, 'Home', 'Charles Martin', '486 Redwood Lane', NULL, 'Fort Worth', 'Texas', '76101', 'US', '+1-555-0114', TRUE, '2024-05-22 17:10:00'),

-- User 15 addresses
(15, 'Home', 'Patricia Thompson', '597 Hickory Road', 'Apt 7B', 'Columbus', 'Ohio', '43004', 'US', '+1-555-0115', TRUE, '2024-06-01 09:40:00'),

-- User 16 addresses
(16, 'Home', 'Daniel Garcia', '618 Magnolia Street', NULL, 'Charlotte', 'North Carolina', '28202', 'US', '+1-555-0116', TRUE, '2024-06-10 14:00:00'),

-- User 17 addresses
(17, 'Home', 'Linda Martinez', '729 Sycamore Avenue', 'Unit 2C', 'Seattle', 'Washington', '98101', 'US', '+1-555-0117', TRUE, '2024-06-18 11:30:00'),

-- User 18 addresses
(18, 'Home', 'Joseph Robinson', '840 Walnut Court', NULL, 'Denver', 'Colorado', '80014', 'US', '+1-555-0118', TRUE, '2024-06-25 16:20:00'),

-- User 19 addresses
(19, 'Home', 'Barbara Clark', '951 Chestnut Way', 'Apt 9A', 'Boston', 'Massachusetts', '02101', 'US', '+1-555-0119', TRUE, '2024-07-02 10:00:00'),

-- User 20 addresses
(20, 'Home', 'Thomas Rodriguez', '162 Beech Boulevard', NULL, 'Detroit', 'Michigan', '48201', 'US', '+1-555-0120', TRUE, '2024-07-10 15:30:00'),

-- User 21 addresses
(21, 'Home', 'Susan Lewis', '273 Palm Drive', 'Suite 5', 'Portland', 'Oregon', '97201', 'US', '+1-555-0121', TRUE, '2024-07-18 12:45:00'),

-- User 22 addresses
(22, 'Home', 'Christopher Lee', '384 Fir Street', NULL, 'Las Vegas', 'Nevada', '89101', 'US', '+1-555-0122', TRUE, '2024-07-25 17:00:00'),

-- User 23 addresses
(23, 'Home', 'Jessica Walker', '495 Juniper Lane', 'Apt 6D', 'Miami', 'Florida', '33101', 'US', '+1-555-0123', TRUE, '2024-08-01 09:20:00'),

-- User 24 addresses
(24, 'Home', 'Matthew Hall', '516 Hemlock Road', NULL, 'Atlanta', 'Georgia', '30303', 'US', '+1-555-0124', TRUE, '2024-08-08 14:40:00'),

-- User 25 addresses
(25, 'Home', 'Karen Allen', '627 Laurel Avenue', 'Unit 11B', 'Minneapolis', 'Minnesota', '55401', 'US', '+1-555-0125', TRUE, '2024-08-15 11:10:00'),

-- User 26 addresses
(26, 'Home', 'Mark Young', '738 Dogwood Court', NULL, 'Orlando', 'Florida', '32801', 'US', '+1-555-0126', TRUE, '2024-08-22 16:50:00'),

-- User 27 addresses
(27, 'Home', 'Nancy Hernandez', '849 Cottonwood Way', 'Apt 4A', 'San Francisco', 'California', '94102', 'US', '+1-555-0127', TRUE, '2024-09-01 10:30:00'),

-- User 28 addresses
(28, 'Home', 'Paul King', '950 Alder Boulevard', NULL, 'Tampa', 'Florida', '33601', 'US', '+1-555-0128', TRUE, '2024-09-10 15:15:00'),

-- User 29 addresses
(29, 'Home', 'Betty Wright', '161 Sequoia Street', 'Suite 8', 'Sacramento', 'California', '94203', 'US', '+1-555-0129', TRUE, '2024-09-18 12:35:00'),

-- User 30 addresses
(30, 'Home', 'Steven Lopez', '272 Eucalyptus Drive', NULL, 'Kansas City', 'Missouri', '64101', 'US', '+1-555-0130', TRUE, '2024-09-25 17:50:00'),

-- Additional addresses for users with multiple
(10, 'Parents House', 'Robert Thomas', '555 Family Lane', NULL, 'Dallas', 'Texas', '75202', 'US', '+1-555-0110', FALSE, '2024-06-15 10:00:00'),
(15, 'Vacation Home', 'Patricia Thompson', '777 Beach Road', NULL, 'Miami', 'Florida', '33139', 'US', '+1-555-0115', FALSE, '2024-07-20 14:30:00'),
(20, 'Office', 'Thomas Rodriguez', '888 Work Plaza', 'Floor 22', 'Detroit', 'Michigan', '48202', 'US', '+1-555-0120', FALSE, '2024-08-10 11:45:00'),
(25, 'Shipping Address', 'Karen Allen', '999 Delivery Lane', 'Warehouse B', 'Minneapolis', 'Minnesota', '55402', 'US', '+1-555-0125', FALSE, '2024-09-05 16:20:00'),
(30, 'Billing Address', 'Steven Lopez', '111 Payment Street', NULL, 'Kansas City', 'Missouri', '64102', 'US', '+1-555-0130', FALSE, '2024-10-01 09:30:00');

-- Verify inserted data
SELECT COUNT(*) AS total_addresses FROM Addresses;
SELECT 
    a.address_id,
    u.full_name,
    a.label,
    CONCAT(a.line1, ', ', a.city, ', ', a.state_region, ' ', a.postal_code) AS full_address,
    a.is_default
FROM Addresses a
JOIN Users u ON a.user_id = u.user_id
LIMIT 10;
