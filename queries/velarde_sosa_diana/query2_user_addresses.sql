-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: [2025-11-05]
-- Description: Query 2 - User Addresses by Region
-- Tables: Addresses, Users

-- Purpose:
--   Analyze user address distribution and address usage patterns
--   across regions (state/city level).
--
-- Includes:
--   Total users per region
--   Total addresses per region
--   Average number of addresses per user
--   Default address ratio
--   Optional grouping by city
-- =============================================

USE urbanease_shop;

SELECT 
    -- Geographic info
    a.state_region AS State,
    a.city AS City,

    -- User and Address Counts
    COUNT(DISTINCT u.user_id) AS Total_Users,             -- number of unique users in the region
    COUNT(a.address_id) AS Total_Addresses,               -- total addresses registered
    ROUND(COUNT(a.address_id) / COUNT(DISTINCT u.user_id), 2) AS Avg_Addresses_Per_User,  -- avg addresses per user

    -- Address Usage Patterns
    SUM(CASE WHEN a.is_default = TRUE THEN 1 ELSE 0 END) AS Default_Addresses,  -- how many addresses are marked as default
    ROUND(
        (SUM(CASE WHEN a.is_default = TRUE THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(a.address_id), 0)) * 100, 2
    ) AS Default_Address_Rate,  -- percentage of addresses that are default

    -- Contact Availability
    SUM(CASE WHEN a.phone IS NOT NULL THEN 1 ELSE 0 END) AS Addresses_With_Phone,
    ROUND(
        (SUM(CASE WHEN a.phone IS NOT NULL THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(a.address_id), 0)) * 100, 2
    ) AS Phone_Availability_Rate,  -- percentage of addresses that include a phone number

    -- Data freshness
    MIN(a.created_at) AS First_Address_Added,
    MAX(a.updated_at) AS Last_Address_Updated

FROM Users u
JOIN Addresses a 
    ON u.user_id = a.user_id

-- ==========================================================
-- Optional Filters (Uncomment one of these if needed)
-- ----------------------------------------------------------
-- WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)   -- last 6 months only
-- WHERE a.country_code = 'US'                               -- filter by country
-- ==========================================================

GROUP BY 
    a.state_region, 
    a.city  -- change to just a.state_region if you want a higher-level report

HAVING 
    COUNT(a.address_id) > 0  -- exclude regions with no addresses

ORDER BY 
    a.state_region ASC, 
    a.city ASC;

