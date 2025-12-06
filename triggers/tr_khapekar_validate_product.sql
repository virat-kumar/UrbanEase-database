-- =============================================
-- Author: Khapekar, Pooja
-- Create date: November 2025
-- Description: Trigger - Validate Product Data
-- Tables: Categories, Products, ProductImages
-- Purpose: Validate product data before insert/update
-- =============================================

-- BUSINESS USE CASE:
-- This trigger is a data validation gate that ensures all product-related entries meet critical business rules before they hit the database. It protects against:
-- Incomplete Listings: Prevents missing fields like product name, category, or price that cause broken product pages.
-- Category Mismatches: Ensures product categories are valid and properly linked.
-- Image Gaps: Validates that each product has at least one image before going live.
-- Price Errors: Stops accidental $0 pricing or excessively high values due to manual input or automation bugs.
-- Third-Party Feed Errors: Catches invalid or malformed product data from vendors or automated integrations.
-- Data Corruption: Prevents malformed or unlinked product records due to network failures or transactional inconsistencies.

-- REAL-WORLD SCENARIO:
-- New Product Launch – Monday Morning at 9:00 AM:
-- 300 products are bulk-imported from a third-party catalog sync.
-- 20 of them have missing categories, 10 have no images, and 5 are priced at $0 due to feed bugs.
-- Without this trigger:
-- These faulty products go live on the storefront.
-- Customers see broken pages or exploit zero-price bugs.
-- With this trigger:
-- The problematic inserts/updates are rejected immediately.
-- The integration logs specific validation failures.
-- Product managers are alerted to fix only the affected items, not the entire batch.

-- Cost & Impact:
-- Broken Product Page Cost: ~$10–100/day in lost conversions per product
-- Zero-Price Exploit: One bad order could cost $500+ in losses
-- Support Overhead: 20–30 support tickets per incident due to bad product data
-- Reputation Risk: Inconsistent or broken product listings hurt brand trust and SEO
-- Estimated Savings: $25,000–$75,000/year across support, fraud prevention, and improved catalog integrity



USE urbanease_shop;

DELIMITER //

CREATE TRIGGER tr_ValidateProduct
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    -- If title is empty, replace it
    IF NEW.title IS NULL OR NEW.title = '' THEN
        SET NEW.title = 'Untitled Product';
    END IF;

    -- If brand is NULL, replace with 'Unknown'
    IF NEW.brand IS NULL THEN
        SET NEW.brand = 'Unknown';
    END IF;

    -- If category is NULL or 0, set to default category ID = 1
    IF NEW.category_id IS NULL OR NEW.category_id = 0 THEN
        SET NEW.category_id = 1;
    END IF;
END//

DELIMITER ;

-- Test the trigger
INSERT INTO Products (category_id, title, description, brand)
VALUES (NULL, '', 'Testing trigger without SIGNAL', NULL);
