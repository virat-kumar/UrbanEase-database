# UrbanEase Database

## Overview
UrbanEase is a comprehensive e-commerce database system built on **MySQL 8.0+**. This database manages all aspects of an online retail platform including user management, product catalog, inventory, shopping cart, orders, payments, and customer reviews.

## Database Schema
The database `urbanease_shop` consists of **18 interconnected tables** organized into logical modules.

---

## Table Structure

### 1. Accounts & User Management

#### **Users**
Stores customer and user account information.
- **Primary Key**: `user_id` (BIGINT, AUTO_INCREMENT)
- **Unique Constraint**: `email`
- **Key Fields**:
  - `email` - User's email address (max 320 chars)
  - `password_hash` - Encrypted password (VARBINARY)
  - `full_name` - User's full name
  - `phone` - Contact number
  - `is_active` - Account status flag (BOOLEAN)
  - `created_at`, `updated_at` - Auto-updating timestamps

#### **Roles**
Defines user roles (Admin, Customer, Manager, etc.).
- **Primary Key**: `role_id` (INT, AUTO_INCREMENT)
- **Unique Constraint**: `role_name`

#### **UserRoles**
Many-to-many relationship between Users and Roles.
- **Composite Primary Key**: (`user_id`, `role_id`)
- **Foreign Keys**: References `Users` and `Roles`

#### **Addresses**
Stores shipping and billing addresses for users.
- **Primary Key**: `address_id` (BIGINT, IDENTITY)
- **Foreign Key**: `user_id` → `Users`
- **Key Fields**:
  - `label` - Address type (Home/Office)
  - `line1`, `line2` - Street address
  - `city`, `state_region`, `postal_code`, `country_code`
  - `is_default` - Default address flag

---

### 2. Product Catalog

#### **Categories**
Hierarchical product categories with parent-child relationships.
- **Primary Key**: `category_id` (BIGINT, IDENTITY)
- **Foreign Key**: `parent_id` → `Categories` (self-reference)
- **Unique Constraint**: `slug`

#### **Products**
Main product information.
- **Primary Key**: `product_id` (BIGINT, IDENTITY)
- **Foreign Key**: `category_id` → `Categories`
- **Key Fields**:
  - `title` - Product name
  - `description` - Detailed description
  - `brand` - Brand name
  - `is_active` - Product availability status

#### **ProductImages**
Multiple images per product.
- **Primary Key**: `image_id` (BIGINT, IDENTITY)
- **Foreign Key**: `product_id` → `Products`
- **Key Fields**:
  - `url` - Image URL (max 512 chars)
  - `alt_text` - Accessibility text
  - `sort_order` - Display order

---

### 3. Variants & Inventory

#### **ProductVariants**
Different variations of products (size, color, etc.).
- **Primary Key**: `variant_id` (BIGINT, AUTO_INCREMENT)
- **Foreign Key**: `product_id` → `Products`
- **Unique Constraint**: `sku`
- **Key Fields**:
  - `sku` - Stock Keeping Unit
  - `attributes_json` - Variant attributes in native JSON format (e.g., `{"size":"M","color":"Black"}`)
  - `price` - Variant price (DECIMAL 12,2)
  - `currency` - Currency code (default: 'USD')
  - `is_active` - Availability flag (BOOLEAN)

#### **Warehouses**
Physical warehouse locations.
- **Primary Key**: `warehouse_id` (BIGINT, AUTO_INCREMENT)
- **Unique Constraint**: `code`
- **Key Fields**:
  - `name` - Warehouse name
  - `code` - Warehouse code
  - `city`, `state_region`, `country_code`

#### **Inventory**
Stock levels per warehouse and variant.
- **Composite Primary Key**: (`warehouse_id`, `variant_id`)
- **Foreign Keys**: References `Warehouses` and `ProductVariants`
- **Key Fields**:
  - `on_hand` - Available quantity (CHECK >= 0)
  - `reserved` - Reserved quantity (CHECK >= 0)

---

### 4. Shopping Cart & Discounts

#### **Carts**
User shopping carts (supports guest carts with NULL user_id).
- **Primary Key**: `cart_id` (BIGINT, IDENTITY)
- **Foreign Key**: `user_id` → `Users` (nullable for guest users)

#### **CartItems**
Items in shopping carts.
- **Primary Key**: `cart_item_id` (BIGINT, IDENTITY)
- **Foreign Keys**: References `Carts` and `ProductVariants`
- **Key Fields**:
  - `qty` - Quantity (CHECK > 0)
  - `unit_price` - Price at time of adding to cart

#### **Coupons**
Discount coupon management.
- **Primary Key**: `coupon_id` (BIGINT, IDENTITY)
- **Unique Constraint**: `code`
- **Key Fields**:
  - `code` - Coupon code
  - `type` - Discount type ('PERCENT' or 'AMOUNT')
  - `value` - Discount value
  - `starts_at`, `expires_at` - Validity period
  - `min_subtotal` - Minimum order amount
  - `is_active` - Active status

---

### 5. Orders & Fulfillment

#### **Orders**
Customer orders with comprehensive pricing.
- **Primary Key**: `order_id` (BIGINT, IDENTITY)
- **Foreign Keys**:
  - `user_id` → `Users`
  - `coupon_id` → `Coupons`
  - `shipping_address_id` → `Addresses`
  - `billing_address_id` → `Addresses`
- **Key Fields**:
  - `status` - Order status ('PENDING', 'PAID', 'CANCELLED', 'FULFILLED', 'REFUNDED')
  - `subtotal_amount` - Items total
  - `discount_amount` - Applied discount
  - `shipping_amount` - Shipping cost
  - `tax_amount` - Tax amount
  - `grand_total_amount` - **Computed column** (persisted)

#### **OrderItems**
Individual line items in orders.
- **Primary Key**: `order_item_id` (BIGINT, IDENTITY)
- **Foreign Keys**: References `Orders` and `ProductVariants`
- **Key Fields**:
  - `qty` - Quantity ordered
  - `unit_price` - Price at time of order
  - `tax_amount` - Item tax
  - `discount_amount` - Item-level discount

#### **Shipments**
Shipping and delivery tracking.
- **Primary Key**: `shipment_id` (BIGINT, IDENTITY)
- **Foreign Keys**: References `Orders` and `Warehouses`
- **Key Fields**:
  - `carrier` - Shipping carrier
  - `tracking_no` - Tracking number
  - `status` - Shipment status ('CREATED', 'PICKED', 'IN_TRANSIT', 'DELIVERED', 'CANCELLED')
  - `shipped_at`, `delivered_at` - Timestamps

---

### 6. Payments & Reviews

#### **Payments**
Payment transaction records.
- **Primary Key**: `payment_id` (BIGINT, IDENTITY)
- **Foreign Key**: `order_id` → `Orders`
- **Key Fields**:
  - `provider` - Payment gateway (Stripe, PayPal, etc.)
  - `provider_ref` - External transaction reference
  - `amount` - Payment amount
  - `status` - Payment status ('INITIATED', 'AUTHORIZED', 'CAPTURED', 'FAILED', 'REFUNDED')
  - `paid_at` - Payment timestamp

#### **Reviews**
Product reviews and ratings.
- **Primary Key**: `review_id` (BIGINT, IDENTITY)
- **Foreign Keys**: References `Products` and `Users`
- **Unique Constraint**: (`product_id`, `user_id`) - One review per user per product
- **Key Fields**:
  - `rating` - Star rating (1-5)
  - `title` - Review title
  - `body` - Review text

---

## Indexes

Performance optimization indexes have been created on frequently queried columns:

```sql
IX_Variant_Product   -- ProductVariants.product_id
IX_Product_Category  -- Products.category_id
IX_Inventory_Variant -- Inventory.variant_id
IX_Order_User        -- Orders.user_id
IX_OrderItems_Order  -- OrderItems.order_id
IX_CartItems_Cart    -- CartItems.cart_id
IX_Payments_Order    -- Payments.order_id
```

---

## Entity Relationships

### Key Relationships:
- **Users** → Multiple **Addresses** (1:N)
- **Users** ↔ **Roles** (M:N through UserRoles)
- **Categories** → Self-referencing for hierarchy
- **Products** → Multiple **ProductVariants** (1:N)
- **Products** → Multiple **ProductImages** (1:N)
- **ProductVariants** → **Inventory** at multiple Warehouses (1:N)
- **Users** → **Carts** → **CartItems** (1:1:N)
- **Users** → Multiple **Orders** (1:N)
- **Orders** → **OrderItems** (1:N)
- **Orders** → **Shipments** (1:N)
- **Orders** → **Payments** (1:N)
- **Products** ↔ **Users** through **Reviews** (M:N)

---

## Data Integrity Features

### Check Constraints:
- Price fields: `>= 0`
- Quantities: `> 0` for ordered items, `>= 0` for inventory
- Ratings: `BETWEEN 1 AND 5`
- Status fields: Restricted to predefined values

### Computed Columns:
- `Orders.grand_total_amount` - Automatically calculated using `GENERATED ALWAYS AS` and stored

### Default Values:
- Timestamps: `UTC_TIMESTAMP()` with auto-update on modification
- Boolean flags: `DEFAULT TRUE` or `DEFAULT FALSE`
- Currency: `DEFAULT 'USD'`
- Status indicators: `DEFAULT TRUE` for active states

---

## Files Structure

```
UrbanEase-database/
├── table_schema.sql       # Complete table structure with indexes
├── queries/               # [To be added] Complex SQL queries
├── procedures/            # [To be added] Stored procedures
├── functions/             # [To be added] User-defined functions
├── triggers/              # [To be added] Database triggers
└── README.md             # This file
```

---

## Complex Queries
*This section will contain complex queries for common business operations*

### Planned Queries:
- [ ] Product search with filtering and sorting
- [ ] Sales reports by period, category, or product
- [ ] Inventory status and low-stock alerts
- [ ] User order history with detailed breakdowns
- [ ] Revenue analytics and trending products
- [ ] Cart abandonment tracking
- [ ] Customer lifetime value (CLV) calculation
- [ ] Average order value (AOV) by segment

---

## Stored Procedures
*This section will contain stored procedures for business logic*

### Planned Procedures:
- [ ] `sp_CreateOrder` - Complete order creation workflow
- [ ] `sp_ProcessPayment` - Payment processing logic
- [ ] `sp_UpdateInventory` - Inventory management
- [ ] `sp_ApplyCoupon` - Coupon validation and application
- [ ] `sp_GenerateInvoice` - Invoice generation
- [ ] `sp_CancelOrder` - Order cancellation with refund
- [ ] `sp_ShipOrder` - Shipment creation and tracking
- [ ] `sp_CheckoutCart` - Convert cart to order

---

## Functions
*This section will contain user-defined functions*

### Planned Functions:
- [ ] `fn_CalculateCartTotal` - Calculate cart grand total
- [ ] `fn_GetAvailableInventory` - Get available stock (on_hand - reserved)
- [ ] `fn_ValidateCoupon` - Validate coupon eligibility
- [ ] `fn_CalculateShipping` - Shipping cost calculation
- [ ] `fn_CalculateTax` - Tax calculation by region
- [ ] `fn_GetProductRating` - Calculate average product rating
- [ ] `fn_GetUserRewardPoints` - Calculate loyalty points

---

## Triggers
*This section will contain database triggers*

### Planned Triggers:
- [ ] `tr_UpdateInventoryOnOrder` - Reserve inventory when order is placed
- [ ] `tr_UpdateInventoryOnShipment` - Deduct inventory when shipped
- [ ] `tr_UpdateTimestamps` - Auto-update `updated_at` fields
- [ ] `tr_ValidateOrderTotal` - Ensure order totals are correct
- [ ] `tr_PreventNegativeInventory` - Prevent overselling
- [ ] `tr_LogPriceChanges` - Audit trail for price modifications
- [ ] `tr_UpdateOrderStatus` - Cascade status changes
- [ ] `tr_EnforceOneDefaultAddress` - Ensure only one default address per user

---

## Database Design Principles

1. **Normalization**: Database is normalized to 3NF to reduce redundancy
2. **Performance**: Strategic indexes on foreign keys and frequently queried columns
3. **Data Integrity**: Comprehensive constraints, foreign keys, and check constraints (MySQL 8.0.16+)
4. **Scalability**: Uses BIGINT for high-volume tables (users, products, orders)
5. **Flexibility**: Native JSON data type for dynamic attributes (ProductVariants.attributes_json)
6. **Audit Trail**: Auto-updating timestamps with ON UPDATE UTC_TIMESTAMP() on most tables
7. **Multi-currency Support**: Currency field in ProductVariants
8. **Guest Checkout**: Nullable user_id in Carts for guest users
9. **InnoDB Engine**: ACID compliance, foreign key support, and row-level locking

---

## Technology Stack

- **Database**: MySQL 8.0+
- **Storage Engine**: InnoDB
- **Character Set**: utf8mb4
- **Collation**: utf8mb4_unicode_ci (international character support)
- **Timestamp**: DATETIME with UTC (UTC_TIMESTAMP())

---

## Installation

1. **Prerequisites**: MySQL 8.0 or later

2. **Using MySQL Workbench**:
   - Open MySQL Workbench
   - Connect to your MySQL server
   - Open `table_schema.sql`
   - Execute the script (it will create the database and all tables)

3. **Using Command Line**:
```bash
mysql -u root -p < table_schema.sql
```

4. **Verify Installation**:
```sql
USE urbanease_shop;
SHOW TABLES;
```

You should see all 18 tables listed.

---

## Future Enhancements

- [ ] Add full-text search capabilities for products
- [ ] Implement table partitioning for Orders (by date)
- [ ] Add audit tables for compliance
- [ ] Create views for common queries
- [ ] Implement row-level security
- [ ] Add support for wishlists
- [ ] Implement product recommendations
- [ ] Add support for product bundles/kits
- [ ] Implement multi-warehouse routing logic
- [ ] Add customer support ticket system

---

## Contributing

When adding new components to this database:
1. Follow the existing naming conventions
2. Add appropriate indexes for foreign keys
3. Include check constraints for data validation
4. Document all procedures and functions
5. Update this README with new additions

---

## License

[Specify your license here]

---

## Contact

**Project**: UrbanEase E-commerce Database  
**Version**: 1.0  
**Last Updated**: November 2025

---

## Acknowledgments

This database schema follows industry best practices for e-commerce platforms and includes features commonly found in production-grade online retail systems.

