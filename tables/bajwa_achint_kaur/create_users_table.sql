-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: November 2025
-- Description: Sample Data for Users Table (35 entries)
-- Module: User Management & Authentication
-- =============================================

USE urbanease_shop;

-- Insert 35 diverse users representing customers and staff
INSERT INTO Users (email, password_hash, full_name, phone, is_active, created_at) VALUES
('admin@urbanease.com', UNHEX(SHA2('SecurePass123!', 256)), 'Sarah Johnson', '+1-555-0001', TRUE, '2024-01-15 10:00:00'),
('john.doe@email.com', UNHEX(SHA2('password123', 256)), 'John Doe', '+1-555-0002', TRUE, '2024-02-20 14:30:00'),
('jane.smith@email.com', UNHEX(SHA2('password123', 256)), 'Jane Smith', '+1-555-0003', TRUE, '2024-02-21 09:15:00'),
('michael.brown@email.com', UNHEX(SHA2('password123', 256)), 'Michael Brown', '+1-555-0004', TRUE, '2024-03-05 16:45:00'),
('emily.davis@email.com', UNHEX(SHA2('password123', 256)), 'Emily Davis', '+1-555-0005', TRUE, '2024-03-10 11:20:00'),
('david.wilson@email.com', UNHEX(SHA2('password123', 256)), 'David Wilson', '+1-555-0006', TRUE, '2024-03-15 13:30:00'),
('sarah.martinez@email.com', UNHEX(SHA2('password123', 256)), 'Sarah Martinez', '+1-555-0007', TRUE, '2024-04-01 08:45:00'),
('james.anderson@email.com', UNHEX(SHA2('password123', 256)), 'James Anderson', '+1-555-0008', TRUE, '2024-04-05 15:10:00'),
('lisa.taylor@email.com', UNHEX(SHA2('password123', 256)), 'Lisa Taylor', '+1-555-0009', TRUE, '2024-04-12 10:25:00'),
('robert.thomas@email.com', UNHEX(SHA2('password123', 256)), 'Robert Thomas', '+1-555-0010', TRUE, '2024-04-20 12:40:00'),
('jennifer.jackson@email.com', UNHEX(SHA2('password123', 256)), 'Jennifer Jackson', '+1-555-0011', TRUE, '2024-05-01 09:55:00'),
('william.white@email.com', UNHEX(SHA2('password123', 256)), 'William White', '+1-555-0012', TRUE, '2024-05-08 14:15:00'),
('mary.harris@email.com', UNHEX(SHA2('password123', 256)), 'Mary Harris', '+1-555-0013', TRUE, '2024-05-15 11:30:00'),
('charles.martin@email.com', UNHEX(SHA2('password123', 256)), 'Charles Martin', '+1-555-0014', TRUE, '2024-05-22 16:20:00'),
('patricia.thompson@email.com', UNHEX(SHA2('password123', 256)), 'Patricia Thompson', '+1-555-0015', TRUE, '2024-06-01 08:50:00'),
('daniel.garcia@email.com', UNHEX(SHA2('password123', 256)), 'Daniel Garcia', '+1-555-0016', TRUE, '2024-06-10 13:05:00'),
('linda.martinez@email.com', UNHEX(SHA2('password123', 256)), 'Linda Martinez', '+1-555-0017', TRUE, '2024-06-18 10:40:00'),
('joseph.robinson@email.com', UNHEX(SHA2('password123', 256)), 'Joseph Robinson', '+1-555-0018', TRUE, '2024-06-25 15:25:00'),
('barbara.clark@email.com', UNHEX(SHA2('password123', 256)), 'Barbara Clark', '+1-555-0019', TRUE, '2024-07-02 09:10:00'),
('thomas.rodriguez@email.com', UNHEX(SHA2('password123', 256)), 'Thomas Rodriguez', '+1-555-0020', TRUE, '2024-07-10 14:35:00'),
('susan.lewis@email.com', UNHEX(SHA2('password123', 256)), 'Susan Lewis', '+1-555-0021', TRUE, '2024-07-18 11:50:00'),
('christopher.lee@email.com', UNHEX(SHA2('password123', 256)), 'Christopher Lee', '+1-555-0022', TRUE, '2024-07-25 16:15:00'),
('jessica.walker@email.com', UNHEX(SHA2('password123', 256)), 'Jessica Walker', '+1-555-0023', TRUE, '2024-08-01 08:30:00'),
('matthew.hall@email.com', UNHEX(SHA2('password123', 256)), 'Matthew Hall', '+1-555-0024', TRUE, '2024-08-08 13:45:00'),
('karen.allen@email.com', UNHEX(SHA2('password123', 256)), 'Karen Allen', '+1-555-0025', TRUE, '2024-08-15 10:20:00'),
('mark.young@email.com', UNHEX(SHA2('password123', 256)), 'Mark Young', '+1-555-0026', TRUE, '2024-08-22 15:55:00'),
('nancy.hernandez@email.com', UNHEX(SHA2('password123', 256)), 'Nancy Hernandez', '+1-555-0027', TRUE, '2024-09-01 09:25:00'),
('paul.king@email.com', UNHEX(SHA2('password123', 256)), 'Paul King', '+1-555-0028', TRUE, '2024-09-10 14:10:00'),
('betty.wright@email.com', UNHEX(SHA2('password123', 256)), 'Betty Wright', '+1-555-0029', TRUE, '2024-09-18 11:35:00'),
('steven.lopez@email.com', UNHEX(SHA2('password123', 256)), 'Steven Lopez', '+1-555-0030', TRUE, '2024-09-25 16:50:00'),
('margaret.hill@email.com', UNHEX(SHA2('password123', 256)), 'Margaret Hill', '+1-555-0031', TRUE, '2024-10-01 08:15:00'),
('andrew.scott@email.com', UNHEX(SHA2('password123', 256)), 'Andrew Scott', '+1-555-0032', TRUE, '2024-10-10 13:40:00'),
('dorothy.green@email.com', UNHEX(SHA2('password123', 256)), 'Dorothy Green', '+1-555-0033', TRUE, '2024-10-18 10:55:00'),
('joshua.adams@email.com', UNHEX(SHA2('password123', 256)), 'Joshua Adams', '+1-555-0034', TRUE, '2024-10-25 15:20:00'),
('inactive.user@email.com', UNHEX(SHA2('password123', 256)), 'Inactive User', '+1-555-0035', FALSE, '2024-11-01 09:45:00');

-- Verify inserted data
SELECT COUNT(*) AS total_users FROM Users;
SELECT * FROM Users LIMIT 10;
