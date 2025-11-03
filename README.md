# 🛍️ UrbanEase Database Project

> A comprehensive e-commerce database system for modern online retail platforms

**Welcome to the UrbanEase Database Repository!** This is a college project where we're building a production-ready MySQL database for an e-commerce platform. This README will help you understand the project, find your assignments, and get started with development.

---

## 📚 Table of Contents

- [Project Overview](#-project-overview)
- [Quick Start](#-quick-start)
- [Team Structure](#-team-structure)
- [Your Responsibilities](#-your-responsibilities)
- [Repository Structure](#-repository-structure)
- [Database Architecture](#-database-architecture)
- [Getting Started Guide](#-getting-started-guide)
- [Development Workflow](#-development-workflow)
- [Technical Documentation](#-technical-documentation)
- [Resources & Help](#-resources--help)

---

## 🎯 Project Overview

**UrbanEase** is a full-featured e-commerce database that handles:
- 👥 User Management & Authentication
- 📦 Product Catalog with Categories & Images
- 🏭 Inventory Management across Multiple Warehouses
- 🛒 Shopping Cart & Promotional Coupons
- 📋 Order Processing & Fulfillment
- 💳 Payment Processing
- ⭐ Customer Reviews & Ratings

### Key Statistics
- **Database**: MySQL 8.0+
- **Tables**: 18 interconnected tables
- **Team Members**: 6 people
- **Components**: Queries, Procedures, Functions, Triggers
- **Files Created**: 58+ placeholder files ready for development

---

## 🚀 Quick Start

### Prerequisites
- **MySQL 8.0 or later** installed
- **MySQL Workbench** (recommended) or command-line access
- **Git** for version control

### Clone the Repository
```bash
git clone https://github.com/virat-kumar/UrbanEase-database.git
cd UrbanEase-database
```

### Set Up the Database
```bash
# Using MySQL Workbench:
# 1. Open MySQL Workbench
# 2. Connect to your MySQL server
# 3. Open table_schema.sql
# 4. Execute the script

# OR using command line:
mysql -u root -p < table_schema.sql
```

### Verify Installation
```sql
USE urbanease_shop;
SHOW TABLES;
-- You should see all 18 tables listed
```

---

## 👥 Team Structure

Our team of **6 members** is organized into functional modules:

| Team Member | Module | Tables |
|-------------|--------|--------|
| **Bajwa, Achint Kaur** | User Management & Authentication | Users, Roles, UserRoles |
| **Khapekar, Pooja** | Product Catalog | Categories, Products, ProductImages |
| **Kumar, Virat** | Inventory Management | ProductVariants, Warehouses, Inventory |
| **Min, La Yaung** | Shopping Cart & Promotions | Carts, CartItems, Coupons |
| **Tiwari, Sneha** | Order Management | Orders, OrderItems, Shipments |
| **Velarde Sosa, Diana** | Payments & Reviews | Addresses, Payments, Reviews |

📖 **See [TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md) for detailed task breakdown**

---

## 📋 Your Responsibilities

Each team member is responsible for creating:

### ✅ Your Deliverables (per person):

1. **3 Complex Queries** - SQL queries demonstrating complex operations on your tables
2. **1 Stored Procedure** - A procedure that performs business logic
3. **1 Function** - A reusable function for calculations or checks
4. **1 Trigger** - An automatic action on table events

### 📂 Where to Find Your Files

All placeholder files are already created and organized by your name:

```
your_name/
├── queries/your_name/           # 3 query files here
├── procedures/sp_yourname_*.sql # 1 procedure file
├── functions/fn_yourname_*.sql  # 1 function file
├── triggers/tr_yourname_*.sql   # 1 trigger file
└── tables/your_name/            # 3 table files (for reference)
```

**Example for Kumar, Virat:**
- `queries/kumar_virat/` - Contains 3 query placeholders
- `procedures/sp_kumar_update_inventory.sql`
- `functions/fn_kumar_get_available_stock.sql`
- `triggers/tr_kumar_prevent_negative_inventory.sql`
- `tables/kumar_virat/` - Contains table creation scripts

---

## 📁 Repository Structure

```
UrbanEase-database/
│
├── 📄 README.md                    # This file - Project overview
├── 📄 TEAM_ASSIGNMENTS.md         # Detailed team assignments & progress
├── 📄 PROJECT_STRUCTURE.md        # Complete file organization guide
├── 📄 table_schema.sql            # Complete database schema (18 tables)
│
├── 📁 tables/                     # Individual table creation files
│   ├── bajwa_achint_kaur/         # 3 tables
│   ├── khapekar_pooja/            # 3 tables
│   ├── kumar_virat/               # 3 tables
│   ├── min_la_yaung/              # 3 tables
│   ├── tiwari_sneha/              # 3 tables
│   └── velarde_sosa_diana/        # 3 tables
│
├── 📁 queries/                    # Complex SQL queries
│   ├── bajwa_achint_kaur/         # 3 queries
│   ├── khapekar_pooja/            # 3 queries
│   ├── kumar_virat/               # 3 queries
│   ├── min_la_yaung/              # 3 queries
│   ├── tiwari_sneha/              # 3 queries
│   └── velarde_sosa_diana/        # 3 queries
│
├── 📁 procedures/                 # Stored procedures (6 files)
│   ├── sp_bajwa_manage_user_roles.sql
│   ├── sp_khapekar_manage_product.sql
│   ├── sp_kumar_update_inventory.sql
│   ├── sp_min_checkout_cart.sql
│   ├── sp_tiwari_create_shipment.sql
│   └── sp_velarde_process_payment.sql
│
├── 📁 functions/                  # User-defined functions (6 files)
│   ├── fn_bajwa_check_user_role.sql
│   ├── fn_khapekar_get_product_image_count.sql
│   ├── fn_kumar_get_available_stock.sql
│   ├── fn_min_calculate_cart_total.sql
│   ├── fn_tiwari_get_order_item_count.sql
│   └── fn_velarde_get_product_rating.sql
│
└── 📁 triggers/                   # Database triggers (6 files)
    ├── tr_bajwa_audit_user_changes.sql
    ├── tr_khapekar_validate_product.sql
    ├── tr_kumar_prevent_negative_inventory.sql
    ├── tr_min_update_cart_timestamp.sql
    ├── tr_tiwari_update_order_status.sql
    └── tr_velarde_validate_review.sql
```

---

## 🏗️ Database Architecture

### Database: `urbanease_shop`

The database consists of **18 tables** organized into **6 logical modules**:

#### 1️⃣ User Management (Bajwa, Achint Kaur)
- **Users** - Customer/admin accounts
- **Roles** - Application roles (Admin, Customer, etc.)
- **UserRoles** - Many-to-many link

#### 2️⃣ Product Catalog (Khapekar, Pooja)
- **Categories** - Hierarchical product categories
- **Products** - Product master data
- **ProductImages** - Product images with sort order

#### 3️⃣ Inventory Management (Kumar, Virat)
- **ProductVariants** - Sellable SKUs with pricing
- **Warehouses** - Physical locations
- **Inventory** - Stock levels per warehouse

#### 4️⃣ Shopping Cart (Min, La Yaung)
- **Carts** - Shopping carts (guest + registered)
- **CartItems** - Items in carts
- **Coupons** - Promotional codes

#### 5️⃣ Order Management (Tiwari, Sneha)
- **Orders** - Order headers with totals
- **OrderItems** - Line items
- **Shipments** - Fulfillment tracking

#### 6️⃣ Payments & Reviews (Velarde Sosa, Diana)
- **Addresses** - Shipping/billing addresses
- **Payments** - Payment transactions
- **Reviews** - Product reviews/ratings

### Entity Relationship Diagram (Conceptual)

```
Users ──┬── Addresses
        ├── UserRoles ── Roles
        ├── Carts ── CartItems ── ProductVariants ── Products ── Categories
        ├── Orders ──┬── OrderItems ── ProductVariants                ├── ProductImages
        │            ├── Payments
        │            └── Shipments ── Warehouses
        └── Reviews ── Products

ProductVariants ── Inventory ── Warehouses
Orders ── Coupons
```

---

## 🎓 Getting Started Guide

### Step 1: Understand the Project
1. Read this README completely
2. Review [TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md) for your specific tasks
3. Check [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for file organization

### Step 2: Set Up Your Environment
1. Install MySQL 8.0+ and MySQL Workbench
2. Clone the repository
3. Run `table_schema.sql` to create the database
4. Verify all 18 tables are created successfully

### Step 3: Explore Your Tables
1. Navigate to `tables/your_name/`
2. Review your 3 table creation files
3. Understand the table structure, relationships, and sample data
4. Run the sample INSERT and SELECT queries to see how data flows

### Step 4: Start with Queries
**Queries are the easiest place to start!**

1. Go to `queries/your_name/`
2. Open `query1_*.sql`
3. Read the header and TODO comments
4. Replace the commented example with your actual query
5. Test in MySQL Workbench
6. Commit when working

### Step 5: Build the Procedure
1. Open `procedures/sp_yourname_*.sql`
2. Understand the parameters and purpose
3. Implement the logic step by step
4. Test with different scenarios
5. Add error handling

### Step 6: Create the Function
1. Open `functions/fn_yourname_*.sql`
2. Implement the calculation/check logic
3. Test the return value
4. Use it in your queries to verify

### Step 7: Implement the Trigger
1. Open `triggers/tr_yourname_*.sql`
2. Decide BEFORE vs AFTER and INSERT/UPDATE/DELETE
3. Implement validation or automatic actions
4. Test by performing operations on your tables

### Step 8: Test Everything Together
1. Create sample data in your tables
2. Run your queries to verify results
3. Call your procedure with test inputs
4. Use your function in queries
5. Trigger your trigger and verify it works

---

## 💻 Development Workflow

### Working with Git

```bash
# 1. Pull latest changes
git pull origin main

# 2. Work on your files
# Edit your queries, procedures, functions, triggers

# 3. Test your code in MySQL Workbench
# Make sure everything works!

# 4. Stage your changes
git add queries/your_name/
git add procedures/sp_yourname_*.sql
git add functions/fn_yourname_*.sql
git add triggers/tr_yourname_*.sql

# 5. Commit with descriptive message
git commit -m "feat: add inventory queries for low stock alerts"

# 6. Push to repository
git push origin main
```

### Commit Message Guidelines

Use descriptive commit messages:
- `feat: add user login history query`
- `fix: correct inventory calculation in procedure`
- `docs: update comments in function`
- `test: add sample data for testing`

### Code Quality Standards

✅ **DO:**
- Add comments explaining your logic
- Use proper indentation (consistent spaces/tabs)
- Test thoroughly before committing
- Handle edge cases and errors
- Use meaningful variable names

❌ **DON'T:**
- Modify `table_schema.sql` without team discussion
- Commit broken or untested code
- Use hardcoded values (use parameters)
- Ignore errors or exceptions

---

## 📖 Technical Documentation

### Database Features

#### Data Types Used
- **BIGINT** - High-volume IDs (users, orders, products)
- **INT** - Standard IDs and quantities
- **VARCHAR** - Text fields with length limits
- **TEXT** - Long descriptions
- **JSON** - Dynamic attributes (ProductVariants)
- **DECIMAL(12,2)** - Monetary values
- **BOOLEAN** - True/false flags
- **DATETIME** - Timestamps with auto-update

#### Constraints & Validation
- **PRIMARY KEY** - Unique identifiers
- **FOREIGN KEY** - Relationship enforcement
- **UNIQUE** - Prevent duplicates (email, SKU, etc.)
- **CHECK** - Value validation (price >= 0, rating 1-5)
- **NOT NULL** - Required fields
- **DEFAULT** - Default values

#### Special Features
- **AUTO_INCREMENT** - Automatic ID generation
- **GENERATED COLUMNS** - Computed fields (grand_total)
- **ON UPDATE UTC_TIMESTAMP()** - Auto-update timestamps
- **JSON data type** - Flexible variant attributes
- **InnoDB engine** - ACID compliance, foreign keys

### Performance Optimization

#### Indexes Created
```sql
IX_Variant_Product   -- Fast product variant lookups
IX_Product_Category  -- Category filtering
IX_Inventory_Variant -- Inventory checks
IX_Order_User        -- User order history
IX_OrderItems_Order  -- Order details
IX_CartItems_Cart    -- Cart contents
IX_Payments_Order    -- Payment history
```

### Common Queries Examples

#### Get User's Active Orders
```sql
SELECT o.order_id, o.status, o.grand_total_amount, o.placed_at
FROM Orders o
WHERE o.user_id = 1 AND o.status IN ('PENDING', 'PAID', 'FULFILLED')
ORDER BY o.placed_at DESC;
```

#### Check Product Availability
```sql
SELECT 
    pv.sku,
    w.name as warehouse,
    (i.on_hand - i.reserved) as available
FROM Inventory i
JOIN ProductVariants pv ON i.variant_id = pv.variant_id
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
WHERE pv.sku = 'IPHONE15PRO-128GB-BLK';
```

#### Calculate Cart Total
```sql
SELECT 
    c.cart_id,
    SUM(ci.qty * ci.unit_price) as cart_total
FROM Carts c
JOIN CartItems ci ON c.cart_id = ci.cart_id
WHERE c.cart_id = 1
GROUP BY c.cart_id;
```

---

## 🤝 Resources & Help

### Documentation Files
- **[TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md)** - Detailed task assignments and progress tracking
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Complete file organization guide

### MySQL Resources
- [MySQL 8.0 Documentation](https://dev.mysql.com/doc/refman/8.0/en/)
- [MySQL Tutorial](https://www.mysqltutorial.org/)
- [SQL Cheat Sheet](https://www.sqltutorial.org/sql-cheat-sheet/)

### Need Help?
1. **Check the placeholder files** - They contain examples and hints
2. **Review table creation files** - Understand your table structure
3. **Ask teammates** - Collaborate and help each other
4. **Test frequently** - Small incremental changes are easier to debug

### Important Notes

⚠️ **IMPORTANT:**
- **DO NOT** modify `table_schema.sql` individually - Discuss schema changes with the entire team
- **COORDINATE** with teammates when your queries need data from their tables
- **TEST** your code thoroughly before pushing to repository
- **DOCUMENT** your work with comments and clear variable names

💡 **TIP:**
Start with queries first - they help you understand the data and relationships before building more complex procedures, functions, and triggers.

---

## 🎯 Project Goals

### Learning Objectives
- ✅ Understand relational database design and normalization
- ✅ Master SQL query writing (JOINs, aggregations, subqueries)
- ✅ Learn stored procedures and business logic implementation
- ✅ Create reusable functions for calculations
- ✅ Implement triggers for automatic data management
- ✅ Practice version control and team collaboration
- ✅ Build a production-ready database system

### Project Success Criteria
- ✅ All 18 tables created and populated with sample data
- ✅ 18 complex queries (3 per person) - working and tested
- ✅ 6 stored procedures (1 per person) - functional
- ✅ 6 functions (1 per person) - returning correct results
- ✅ 6 triggers (1 per person) - activating properly
- ✅ Complete documentation and comments
- ✅ All code committed to repository

---

## 📊 Project Status

### Current Phase: **Development** 🚧

| Component | Status | Files |
|-----------|--------|-------|
| Database Schema | ✅ Complete | 1/1 |
| Documentation | ✅ Complete | 3/3 |
| Table Placeholders | ✅ Created | 18/18 |
| Query Placeholders | ✅ Created | 18/18 |
| Procedure Placeholders | ✅ Created | 6/6 |
| Function Placeholders | ✅ Created | 6/6 |
| Trigger Placeholders | ✅ Created | 6/6 |
| **Implementation** | 🔄 In Progress | TBD |

**Track progress in [TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md)**

---

## 👨‍💻 Team Members

- **Bajwa, Achint Kaur** - User Management Module
- **Khapekar, Pooja** - Product Catalog Module
- **Kumar, Virat** - Inventory Management Module  
- **Min, La Yaung** - Shopping Cart Module
- **Tiwari, Sneha** - Order Management Module
- **Velarde Sosa, Diana** - Payments & Reviews Module

---

## 📝 License

This is a college project created for educational purposes.

---

## 🙏 Acknowledgments

This database schema follows industry best practices for e-commerce platforms and includes features commonly found in production-grade online retail systems.

---

## 📞 Contact & Support

**Project Repository**: [https://github.com/virat-kumar/UrbanEase-database](https://github.com/virat-kumar/UrbanEase-database)  
**Version**: 1.0  
**Last Updated**: November 2025

---

### 🚀 Let's Build Something Great Together!

Remember: This is a team project. Help each other, share knowledge, and don't hesitate to ask questions. We're all learning together! 💪

**Happy Coding!** 🎉
