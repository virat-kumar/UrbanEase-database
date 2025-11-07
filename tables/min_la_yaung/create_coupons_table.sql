-- =============================================
-- Author: Min, La Yaung
-- Create date: November 2025
-- Description: Sample Data for Coupons Table (30 entries)
-- Module: Shopping Cart & Promotions
-- =============================================

USE urbanease_shop;

-- Insert 30 promotional coupons with various types and conditions
INSERT INTO Coupons (code, type, value, starts_at, expires_at, min_subtotal, is_active) VALUES
-- Active percentage-based coupons
('WELCOME10', 'PERCENT', 10.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 50.00, TRUE),
('SAVE15', 'PERCENT', 15.00, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),
('BIGSALE20', 'PERCENT', 20.00, '2024-11-01 00:00:00', '2024-11-30 23:59:59', 150.00, TRUE),
('VIP25', 'PERCENT', 25.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 200.00, TRUE),
('FLASH30', 'PERCENT', 30.00, '2024-11-07 00:00:00', '2024-11-10 23:59:59', 300.00, TRUE),

-- Active fixed amount coupons
('SAVE5', 'AMOUNT', 5.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 25.00, TRUE),
('GET10OFF', 'AMOUNT', 10.00, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 50.00, TRUE),
('DEAL25', 'AMOUNT', 25.00, '2024-09-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),
('MEGA50', 'AMOUNT', 50.00, '2024-11-01 00:00:00', '2024-11-30 23:59:59', 200.00, TRUE),
('SUPER100', 'AMOUNT', 100.00, '2024-11-01 00:00:00', '2024-11-15 23:59:59', 500.00, TRUE),

-- Seasonal/Holiday coupons
('SUMMER15', 'PERCENT', 15.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 75.00, TRUE),
('BACKTOSCHOOL', 'PERCENT', 12.00, '2024-08-01 00:00:00', '2024-09-15 23:59:59', 60.00, TRUE),
('HALLOWEEN10', 'PERCENT', 10.00, '2024-10-15 00:00:00', '2024-10-31 23:59:59', 40.00, TRUE),
('BLACKFRIDAY', 'PERCENT', 35.00, '2024-11-29 00:00:00', '2024-11-29 23:59:59', 100.00, TRUE),
('CYBERMONDAY', 'PERCENT', 30.00, '2024-12-02 00:00:00', '2024-12-02 23:59:59', 100.00, TRUE),

-- Category-specific coupons
('TECH20', 'PERCENT', 20.00, '2024-10-01 00:00:00', '2024-12-31 23:59:59', 200.00, TRUE),
('FASHION15', 'PERCENT', 15.00, '2024-09-01 00:00:00', '2024-12-31 23:59:59', 80.00, TRUE),
('HOME10', 'PERCENT', 10.00, '2024-08-01 00:00:00', '2024-12-31 23:59:59', 100.00, TRUE),

-- First-time customer coupons
('FIRSTORDER', 'PERCENT', 20.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 30.00, TRUE),
('NEWUSER15', 'PERCENT', 15.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 25.00, TRUE),

-- Expired coupons
('EXPIRED10', 'PERCENT', 10.00, '2024-01-01 00:00:00', '2024-06-30 23:59:59', 50.00, TRUE),
('OLDCODE20', 'PERCENT', 20.00, '2024-01-01 00:00:00', '2024-03-31 23:59:59', 100.00, TRUE),
('SUMMER2023', 'PERCENT', 15.00, '2023-06-01 00:00:00', '2023-08-31 23:59:59', 75.00, TRUE),

-- Inactive coupons (manually deactivated)
('INACTIVE25', 'PERCENT', 25.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 150.00, FALSE),
('DISABLED15', 'PERCENT', 15.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 100.00, FALSE),

-- High-value exclusive coupons
('PREMIUM50', 'AMOUNT', 50.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 250.00, TRUE),
('VIPEXCLUSIVE', 'PERCENT', 30.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 500.00, TRUE),
('LOYALTY100', 'AMOUNT', 100.00, '2024-01-01 00:00:00', '2025-12-31 23:59:59', 1000.00, TRUE),

-- Limited time offers
('FLASH24H', 'PERCENT', 25.00, '2024-11-07 00:00:00', '2024-11-08 23:59:59', 100.00, TRUE),
('HOURLY15', 'PERCENT', 15.00, '2024-11-07 10:00:00', '2024-11-07 20:00:00', 50.00, TRUE);

-- Verify inserted data
SELECT COUNT(*) AS total_coupons FROM Coupons;
SELECT 
    code,
    type,
    value,
    is_active,
    CASE 
        WHEN expires_at < NOW() THEN 'Expired'
        WHEN starts_at > NOW() THEN 'Not Started'
        ELSE 'Active'
    END AS status
FROM Coupons
LIMIT 15;
