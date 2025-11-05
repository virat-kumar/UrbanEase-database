# How to Work on UrbanEase Database - Team Guide

> **Your complete guide to contributing to this project**

Welcome to the UrbanEase development team! This document explains **how to approach this repository**, **how files are organized**, and **how to work** on your assignments.

---

## 📚 Table of Contents

- [Quick Orientation](#quick-orientation)
- [Understanding the Repository](#understanding-the-repository)
- [Team Structure & Assignments](#team-structure--assignments)
- [Your Deliverables](#your-deliverables)
- [Repository File Organization](#repository-file-organization)
- [Getting Started - Step by Step](#getting-started---step-by-step)
- [Development Workflow](#development-workflow)
- [Working with Git](#working-with-git)
- [Code Quality Guidelines](#code-quality-guidelines)
- [Testing Your Code](#testing-your-code)
- [Progress Tracking](#progress-tracking)
- [Getting Help](#getting-help)

---

## Quick Orientation

### What You Need to Know First

1. **What is this project?** - Read [README.md](README.md) to understand the UrbanEase database
2. **What files exist?** - See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for complete file listing
3. **What do I need to do?** - This document! Keep reading

### Prerequisites

Before you start, make sure you have:
- ✅ MySQL 8.0+ installed
- ✅ MySQL Workbench installed (recommended)
- ✅ Git installed
- ✅ Repository cloned to your machine
- ✅ Database created (run `table_schema.sql`)

---

## Understanding the Repository

### How Files Are Organized

The repository uses a **modular structure** where each team member has their own folders:

```
UrbanEase-database/
│
├── 📄 README.md                  ← What the project IS
├── 📄 TEAM_ASSIGNMENTS.md       ← How to WORK on it (you are here)
├── 📄 PROJECT_STRUCTURE.md      ← Complete file listing
├── 📄 table_schema.sql          ← Complete database (DO NOT modify alone!)
│
├── 📁 tables/                   ← Individual table creation files
│   ├── bajwa_achint_kaur/       ← Your name here!
│   ├── khapekar_pooja/
│   ├── kumar_virat/
│   ├── min_la_yaung/
│   ├── tiwari_sneha/
│   └── velarde_sosa_diana/
│
├── 📁 queries/                  ← Your 3 queries go here
│   ├── bajwa_achint_kaur/
│   ├── khapekar_pooja/
│   ├── kumar_virat/
│   ├── min_la_yaung/
│   ├── tiwari_sneha/
│   └── velarde_sosa_diana/
│
├── 📁 procedures/               ← Your 1 procedure goes here
│   ├── sp_bajwa_manage_user_roles.sql
│   ├── sp_khapekar_manage_product.sql
│   ├── sp_kumar_update_inventory.sql
│   ├── sp_min_checkout_cart.sql
│   ├── sp_tiwari_create_shipment.sql
│   └── sp_velarde_process_payment.sql
│
├── 📁 functions/                ← Your 1 function goes here
│   ├── fn_bajwa_check_user_role.sql
│   ├── fn_khapekar_get_product_image_count.sql
│   ├── fn_kumar_get_available_stock.sql
│   ├── fn_min_calculate_cart_total.sql
│   ├── fn_tiwari_get_order_item_count.sql
│   └── fn_velarde_get_product_rating.sql
│
└── 📁 triggers/                 ← Your 1 trigger goes here
    ├── tr_bajwa_audit_user_changes.sql
    ├── tr_khapekar_validate_product.sql
    ├── tr_kumar_prevent_negative_inventory.sql
    ├── tr_min_update_cart_timestamp.sql
    ├── tr_tiwari_update_order_status.sql
    └── tr_velarde_validate_review.sql
```

### Key Principle: Find Your Name!

All your files are organized by your name. Simply look for folders or files with your name to find what you need to work on.

---

## Team Structure & Assignments

### Complete Team Assignment Table

| Team Member | Module | Tables (3) | Your Focus Area |
|-------------|--------|------------|-----------------|
| **Bajwa, Achint Kaur** | User Management | Users, Roles, UserRoles | Authentication & Access Control |
| **Khapekar, Pooja** | Product Catalog | Categories, Products, ProductImages | Product Organization |
| **Kumar, Virat** | Inventory | ProductVariants, Warehouses, Inventory | Stock Management |
| **Min, La Yaung** | Shopping Cart | Carts, CartItems, Coupons | Shopping Experience |
| **Tiwari, Sneha** | Orders | Orders, OrderItems, Shipments | Order Processing |
| **Velarde Sosa, Diana** | Payments & Reviews | Addresses, Payments, Reviews | Transactions & Feedback |

### Detailed Assignments by Person

#### 👤 Bajwa, Achint Kaur
**Module**: User Management & Authentication

**Your Tables:**
1. Users - Customer/admin accounts
2. Roles - Application roles (Admin, Customer, etc.)
3. UserRoles - User-to-role mapping

**Your Files:**
- `queries/bajwa_achint_kaur/query1_user_login_history.sql`
- `queries/bajwa_achint_kaur/query2_users_by_role.sql`
- `queries/bajwa_achint_kaur/query3_active_users_with_roles.sql`
- `procedures/sp_bajwa_manage_user_roles.sql`
- `functions/fn_bajwa_check_user_role.sql`
- `triggers/tr_bajwa_audit_user_changes.sql`

---

#### 👤 Khapekar, Pooja
**Module**: Product Catalog

**Your Tables:**
1. Categories - Product taxonomy (hierarchical)
2. Products - Product master data
3. ProductImages - Product images with ordering

**Your Files:**
- `queries/khapekar_pooja/query1_products_by_category.sql`
- `queries/khapekar_pooja/query2_category_hierarchy.sql`
- `queries/khapekar_pooja/query3_products_without_images.sql`
- `procedures/sp_khapekar_manage_product.sql`
- `functions/fn_khapekar_get_product_image_count.sql`
- `triggers/tr_khapekar_validate_product.sql`

---

#### 👤 Kumar, Virat
**Module**: Product Variants & Inventory Management

**Your Tables:**
1. ProductVariants - Sellable SKUs with pricing
2. Warehouses - Physical storage locations
3. Inventory - Stock levels per warehouse

**Your Files:**
- `queries/kumar_virat/query1_inventory_status.sql`
- `queries/kumar_virat/query2_low_stock_alert.sql`
- `queries/kumar_virat/query3_variant_pricing.sql`
- `procedures/sp_kumar_update_inventory.sql`
- `functions/fn_kumar_get_available_stock.sql`
- `triggers/tr_kumar_prevent_negative_inventory.sql`

---

#### 👤 Min, La Yaung
**Module**: Shopping Cart & Promotions

**Your Tables:**
1. Carts - Shopping carts (guest + registered users)
2. CartItems - Items in carts
3. Coupons - Promotional codes

**Your Files:**
- `queries/min_la_yaung/query1_active_carts.sql`
- `queries/min_la_yaung/query2_abandoned_carts.sql`
- `queries/min_la_yaung/query3_coupon_usage.sql`
- `procedures/sp_min_checkout_cart.sql`
- `functions/fn_min_calculate_cart_total.sql`
- `triggers/tr_min_update_cart_timestamp.sql`

---

#### 👤 Tiwari, Sneha
**Module**: Order Management & Fulfillment

**Your Tables:**
1. Orders - Order headers with pricing
2. OrderItems - Order line items
3. Shipments - Fulfillment tracking

**Your Files:**
- `queries/tiwari_sneha/query1_order_summary.sql`
- `queries/tiwari_sneha/query2_pending_shipments.sql`
- `queries/tiwari_sneha/query3_revenue_analysis.sql`
- `procedures/sp_tiwari_create_shipment.sql`
- `functions/fn_tiwari_get_order_item_count.sql`
- `triggers/tr_tiwari_update_order_status.sql`

---

#### 👤 Velarde Sosa, Diana
**Module**: User Addresses, Payments & Reviews

**Your Tables:**
1. Addresses - User shipping/billing addresses
2. Payments - Payment transactions
3. Reviews - Product reviews/ratings

**Your Files:**
- `queries/velarde_sosa_diana/query1_payment_status.sql`
- `queries/velarde_sosa_diana/query2_user_addresses.sql`
- `queries/velarde_sosa_diana/query3_product_reviews.sql`
- `procedures/sp_velarde_process_payment.sql`
- `functions/fn_velarde_get_product_rating.sql`
- `triggers/tr_velarde_validate_review.sql`

---

## Your Deliverables

### What Each Person Must Complete

Every team member is responsible for **3 tables** and must create **6 database components**:

| Component | Count | Description |
|-----------|-------|-------------|
| **Tables (Assigned)** | 3 | Your module's database tables (see your assignments) |
| **Complex Queries** | 3 | SQL queries with JOINs, aggregations, or subqueries |
| **Stored Procedure** | 1 | Business logic procedure with parameters |
| **Function** | 1 | Reusable calculation or validation function |
| **Trigger** | 1 | Automatic action on INSERT/UPDATE/DELETE |

### What "Complete" Means

A component is complete when:
- ✅ Code is written and works correctly
- ✅ Code is tested with sample data
- ✅ Comments explain the logic
- ✅ Code is committed to Git
- ✅ Checkbox in Progress Tracking is marked

---

## Repository File Organization

### Understanding File Types

#### 📁 `tables/` - Table Creation Files
**Purpose**: Help you understand your table structure

Each file contains:
- Complete CREATE TABLE statement
- Sample INSERT statements
- Example queries
- Comments explaining the table

**What to do**: Study these to understand your tables. You can run them individually to test.

#### 📁 `queries/` - Complex Queries
**Purpose**: Demonstrate advanced SQL skills

Your queries should:
- Use JOINs between multiple tables
- Include aggregations (COUNT, SUM, AVG, etc.)
- Use WHERE clauses for filtering
- Demonstrate real business scenarios

**Example scenarios**:
- Get user order history
- Find low-stock products
- Calculate revenue by period
- Show abandoned carts

#### 📁 `procedures/` - Stored Procedures
**Purpose**: Implement business logic

Your procedure should:
- Accept input parameters
- Perform multiple SQL operations
- Include error handling
- Return results or status

**Example tasks**:
- Process an order
- Update inventory levels
- Apply a coupon
- Create a shipment

#### 📁 `functions/` - User-Defined Functions
**Purpose**: Reusable calculations

Your function should:
- Accept parameters
- Return a single value
- Be deterministic (same input = same output)
- Be usable in queries

**Example functions**:
- Calculate cart total
- Check product availability
- Get average rating
- Validate coupon

#### 📁 `triggers/` - Database Triggers
**Purpose**: Automatic data management

Your trigger should:
- Respond to INSERT, UPDATE, or DELETE
- Validate data or enforce rules
- Update related records
- Log changes

**Example triggers**:
- Update timestamps automatically
- Prevent negative inventory
- Validate order totals
- Cascade status changes

---

## Getting Started - Step by Step

### Step 1: Set Up Your Environment (30 minutes)

```bash
# 1. Clone the repository
git clone https://github.com/virat-kumar/UrbanEase-database.git
cd UrbanEase-database

# 2. Open MySQL Workbench

# 3. Connect to your MySQL server

# 4. Open and run table_schema.sql

# 5. Verify all 18 tables are created
USE urbanease_shop;
SHOW TABLES;
```

### Step 2: Understand Your Tables (1 hour)

1. Navigate to `tables/your_name/`
2. Open each of your 3 table files
3. Read the structure and comments
4. Run the sample INSERT statements
5. Run the example queries
6. Understand the relationships with other tables

**Key questions to answer:**
- What data does this table store?
- What are the foreign keys? Which tables does it connect to?
- What business rules apply (CHECK constraints)?
- What are common query patterns?

### Step 3: Start with Query 1 (2-3 hours)

**Why start with queries?** They help you understand the data before writing complex procedures.

1. Go to `queries/your_name/`
2. Open `query1_*.sql`
3. Read the TODO comments and examples
4. Write your query step by step:
   - Start with a simple SELECT
   - Add JOINs one at a time
   - Add WHERE conditions
   - Add GROUP BY if needed
   - Add ORDER BY for sorting
5. Test with sample data
6. Add comments explaining the logic
7. Commit when it works!

```bash
git add queries/your_name/query1_*.sql
git commit -m "feat: add user login history query"
git push
```

### Step 4: Complete Queries 2 and 3 (4-6 hours)

Repeat the same process for your other two queries. Each should demonstrate different SQL concepts:
- Different JOIN types (INNER, LEFT, RIGHT)
- Different aggregations (COUNT, SUM, AVG, MAX, MIN)
- Different grouping strategies
- Subqueries or CTEs

### Step 5: Build Your Stored Procedure (4-6 hours)

1. Open `procedures/sp_yourname_*.sql`
2. Understand the parameters (inputs)
3. Plan the logic:
   - What validations are needed?
   - What tables need to be updated?
   - What should be returned?
4. Write it step by step:
   - Declare variables
   - Validate inputs
   - Perform operations
   - Handle errors
   - Return results
5. Test with different scenarios
6. Commit when working

### Step 6: Create Your Function (2-3 hours)

1. Open `functions/fn_yourname_*.sql`
2. Understand what it should calculate/return
3. Write the calculation logic
4. Test by calling it in a query
5. Verify the return value is correct
6. Commit when working

### Step 7: Implement Your Trigger (2-3 hours)

1. Open `triggers/tr_yourname_*.sql`
2. Decide:
   - BEFORE or AFTER?
   - INSERT, UPDATE, or DELETE?
3. Write the trigger logic:
   - Access OLD and NEW values
   - Perform validations
   - Update related records
4. Test by performing operations on your table
5. Verify the trigger fires correctly
6. Commit when working

### Step 8: Integration Testing (2-3 hours)

1. Create comprehensive sample data
2. Run all your queries
3. Call your procedure
4. Use your function in queries
5. Trigger your trigger
6. Verify everything works together
7. Document any issues

---

## Development Workflow

### Daily Workflow

#### Morning Routine
```bash
# 1. Pull latest changes
git pull origin main

# 2. Check what you need to work on today
# See Progress Tracking section below

# 3. Open MySQL Workbench
# 4. Open your file for today's task
```

#### Working on a Task
1. Read the file header and comments
2. Understand what it should do
3. Write code incrementally (small steps)
4. Test after each change
5. Add comments as you go
6. Save frequently

#### End of Day
```bash
# 1. Final test of your work
# 2. Add helpful comments
# 3. Commit your changes
git add <your-files>
git commit -m "descriptive message"
git push origin main

# 4. Update progress tracking (see below)
```

---

## Working with Git

### Initial Setup
```bash
# Clone repository (do this once)
git clone https://github.com/virat-kumar/UrbanEase-database.git
cd UrbanEase-database

# Configure your name and email (do this once)
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### Daily Git Commands

#### Before Starting Work
```bash
# Always pull latest changes first!
git pull origin main
```

#### While Working
```bash
# Check what files you've changed
git status

# See your changes
git diff <filename>
```

#### Saving Your Work
```bash
# Stage specific files
git add queries/your_name/query1_*.sql

# Or stage all your changes
git add queries/your_name/
git add procedures/sp_yourname_*.sql

# Commit with a message
git commit -m "feat: add inventory status query"

# Push to GitHub
git push origin main
```

### Commit Message Format

Use this format for clear commit messages:

```
<type>: <description>

Types:
- feat: New feature (query, procedure, function, trigger)
- fix: Bug fix
- docs: Documentation changes
- test: Adding test data
- refactor: Code improvement without changing functionality
```

**Good Examples:**
```bash
git commit -m "feat: add low stock alert query with warehouse filtering"
git commit -m "fix: correct calculation in cart total function"
git commit -m "docs: add comments explaining trigger logic"
git commit -m "test: add sample data for inventory testing"
```

**Bad Examples:**
```bash
git commit -m "update"  # Too vague
git commit -m "fixed stuff"  # What stuff?
git commit -m "asdf"  # Not descriptive
```

### Handling Conflicts

If you get a conflict when pulling:
```bash
# 1. Pull and see the conflict
git pull origin main

# 2. Open the conflicting file
# Look for <<<<<<< and >>>>>>> markers

# 3. Edit the file to resolve
# Remove conflict markers, keep the correct code

# 4. Stage the resolved file
git add <filename>

# 5. Commit the resolution
git commit -m "fix: resolve merge conflict in query file"

# 6. Push
git push origin main
```

---

## Code Quality Guidelines

### DO ✅

#### Comments
```sql
-- ✅ GOOD: Explain WHY, not just WHAT
-- Calculate available inventory by subtracting reserved from on_hand
-- This ensures we don't oversell products
SELECT (on_hand - reserved) as available
FROM Inventory;
```

#### Formatting
```sql
-- ✅ GOOD: Readable formatting
SELECT 
    u.user_id,
    u.email,
    o.order_id,
    o.grand_total_amount
FROM Users u
INNER JOIN Orders o ON u.user_id = o.user_id
WHERE o.status = 'PAID'
ORDER BY o.placed_at DESC;
```

#### Variable Names
```sql
-- ✅ GOOD: Descriptive names
DELIMITER //
CREATE PROCEDURE sp_UpdateInventory(
    IN p_variant_id BIGINT,
    IN p_quantity_change INT,
    IN p_operation VARCHAR(20)
)
```

#### Error Handling
```sql
-- ✅ GOOD: Check and handle errors
IF p_quantity_change < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Quantity change cannot be negative';
END IF;
```

### DON'T ❌

#### Poor Comments
```sql
-- ❌ BAD: Obvious or useless comments
SELECT * FROM Users;  -- Select from Users
```

#### Bad Formatting
```sql
-- ❌ BAD: Hard to read
SELECT u.user_id,u.email,o.order_id,o.grand_total_amount FROM Users u INNER JOIN Orders o ON u.user_id=o.user_id WHERE o.status='PAID' ORDER BY o.placed_at DESC;
```

#### Generic Names
```sql
-- ❌ BAD: Not descriptive
DELIMITER //
CREATE PROCEDURE sp_Do_Something(
    IN p_id INT,
    IN p_val INT,
    IN p_type VARCHAR(20)
)
```

#### No Error Handling
```sql
-- ❌ BAD: No validation
UPDATE Inventory 
SET on_hand = on_hand - p_quantity;
-- What if on_hand goes negative?
```

### Best Practices Checklist

Before committing, verify:
- [ ] Code works and has been tested
- [ ] Comments explain complex logic
- [ ] Consistent indentation (2 or 4 spaces)
- [ ] Descriptive variable names
- [ ] Error handling included
- [ ] No hardcoded values (use parameters)
- [ ] SQL keywords in UPPERCASE (optional but consistent)
- [ ] Table/column names match schema exactly

---

## Testing Your Code

### Testing Queries

```sql
-- 1. Create test data (if needed)
INSERT INTO Users (email, password_hash, full_name) VALUES
    ('test@example.com', SHA2('password', 256), 'Test User');

-- 2. Run your query
-- [Your query here]

-- 3. Verify results
-- Check if the output makes sense

-- 4. Test edge cases
-- Empty result sets
-- NULL values
-- Large result sets

-- 5. Clean up test data (optional)
-- DELETE FROM Users WHERE email = 'test@example.com';
```

### Testing Procedures

```sql
-- 1. Call with valid inputs
CALL sp_UpdateInventory(1, 10, 'ADD_STOCK');

-- 2. Check results
SELECT * FROM Inventory WHERE variant_id = 1;

-- 3. Test error conditions
CALL sp_UpdateInventory(1, -10, 'ADD_STOCK');  -- Should fail

-- 4. Test edge cases
CALL sp_UpdateInventory(999999, 10, 'ADD_STOCK');  -- Non-existent variant
```

### Testing Functions

```sql
-- 1. Call the function
SELECT fn_GetAvailableStock(1, 1);

-- 2. Verify the result
-- Compare with manual calculation

-- 3. Test with different inputs
SELECT fn_GetAvailableStock(1, 1);
SELECT fn_GetAvailableStock(2, 1);
SELECT fn_GetAvailableStock(1, 2);

-- 4. Test with NULL or invalid inputs
SELECT fn_GetAvailableStock(NULL, 1);
SELECT fn_GetAvailableStock(999999, 1);
```

### Testing Triggers

```sql
-- 1. Perform the action that should fire the trigger
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) 
VALUES (1, 1, 2, 99.99);

-- 2. Check if the trigger fired correctly
SELECT updated_at FROM Carts WHERE cart_id = 1;
-- Should be updated to current time

-- 3. Test with different operations
UPDATE CartItems SET qty = 3 WHERE cart_item_id = 1;
DELETE FROM CartItems WHERE cart_item_id = 1;

-- 4. Verify each operation triggers correctly
```

### Creating Test Data

Use the sample INSERT statements from your `tables/your_name/` files:

```sql
-- Example: Creating test users
INSERT INTO Users (email, password_hash, full_name, phone) VALUES
    ('alice@test.com', SHA2('password123', 256), 'Alice Smith', '+1-555-0001'),
    ('bob@test.com', SHA2('password123', 256), 'Bob Johnson', '+1-555-0002');

-- Example: Creating test products
INSERT INTO Products (category_id, title, description, brand) VALUES
    (1, 'Test Laptop', 'A test laptop product', 'TestBrand');
```

---

## Progress Tracking

### Individual Progress Checklist

Mark items as complete when you've:
1. Written the code
2. Tested it thoroughly
3. Added comments
4. Committed to Git

#### Bajwa, Achint Kaur
- [ ] Query 1: User Login History
- [ ] Query 2: Users by Role
- [ ] Query 3: Active Users with Roles
- [ ] Procedure: Manage User Roles
- [ ] Function: Check User Role
- [ ] Trigger: Audit User Changes

#### Khapekar, Pooja
- [ ] Query 1: Products by Category
- [ ] Query 2: Category Hierarchy
- [ ] Query 3: Products Without Images
- [ ] Procedure: Manage Product
- [ ] Function: Get Product Image Count
- [ ] Trigger: Validate Product

#### Kumar, Virat
- [x] **Table Sample Data: Warehouses (50 entries)**
- [x] **Table Sample Data: ProductVariants (50 entries)**
- [x] **Table Sample Data: Inventory (50 entries)**
- [x] **Query 1: Inventory Status** (Comprehensive dashboard with 6-level classification)
- [x] **Query 2: Low Stock Alert** (Priority-ranked with reorder recommendations)
- [x] **Query 3: Variant Pricing** (Multi-warehouse value analysis with ABC classification)
- [ ] Procedure: Update Inventory
- [ ] Function: Get Available Stock
- [ ] Trigger: Prevent Negative Inventory

#### Min, La Yaung
- [ ] Query 1: Active Carts
- [ ] Query 2: Abandoned Carts
- [ ] Query 3: Coupon Usage
- [ ] Procedure: Checkout Cart
- [ ] Function: Calculate Cart Total
- [ ] Trigger: Update Cart Timestamp

#### Tiwari, Sneha
- [ ] Query 1: Order Summary
- [ ] Query 2: Pending Shipments
- [ ] Query 3: Revenue Analysis
- [ ] Procedure: Create Shipment
- [ ] Function: Get Order Item Count
- [ ] Trigger: Update Order Status

#### Velarde Sosa, Diana
- [ ] Query 1: Payment Status
- [ ] Query 2: User Addresses
- [ ] Query 3: Product Reviews
- [ ] Procedure: Process Payment
- [ ] Function: Get Product Rating
- [ ] Trigger: Validate Review

### Team Progress Dashboard

| Component | Status | Count |
|-----------|--------|-------|
| Database Schema | ✅ Complete | 1/1 |
| Documentation | ✅ Complete | 3/3 |
| Table Placeholders | ✅ Created | 18/18 |
| **Table Sample Data** | 🔄 In Progress | 3/18 |
| Query Placeholders | ✅ Created | 18/18 |
| Procedure Placeholders | ✅ Created | 6/6 |
| Function Placeholders | ✅ Created | 6/6 |
| Trigger Placeholders | ✅ Created | 6/6 |
| **Queries Implemented** | 🔄 In Progress | 3/18 |
| **Procedures Implemented** | 🔄 In Progress | 0/6 |
| **Functions Implemented** | 🔄 In Progress | 0/6 |
| **Triggers Implemented** | 🔄 In Progress | 0/6 |

---

## Getting Help

### When You're Stuck

1. **Check the Placeholder File** - Read the comments and examples carefully
2. **Review Your Table Files** - Make sure you understand the table structure
3. **Look at README.md** - Review the table documentation
4. **Test Simple Queries First** - Build complexity gradually
5. **Ask a Teammate** - Someone else might have solved a similar problem
6. **Search Online** - MySQL documentation and Stack Overflow are helpful

### Common Issues

#### "I don't understand my tables"
→ Go to `tables/your_name/` and run the example queries

#### "My query returns wrong results"
→ Test each JOIN separately, verify your WHERE conditions

#### "Syntax error in my procedure"
→ Check DELIMITER usage, verify all BEGIN/END pairs

#### "My trigger doesn't fire"
→ Verify the trigger exists: `SHOW TRIGGERS;`

#### "Git merge conflict"
→ See "Handling Conflicts" section above

#### "I can't test without data"
→ Use INSERT statements from your `tables/your_name/` files

### Resources

#### Documentation
- **[README.md](README.md)** - Database documentation
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - File organization

#### MySQL Resources
- [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
- [MySQL Tutorial](https://www.mysqltutorial.org/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)

#### Git Resources
- [Git Basics](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics)
- [GitHub Guides](https://guides.github.com/)

### Team Collaboration

#### Coordinate with Teammates When:
- Your queries need data from their tables
- Your procedure needs to call operations on their tables
- You find a bug in the shared schema
- You have questions about relationships

#### Communication Tips:
- Be specific about what you need
- Show what you've tried
- Share your solutions when you figure something out
- Help others when you can

---

## Important Reminders

### Critical Rules

⚠️ **NEVER modify `table_schema.sql` alone!**
- This is the master schema
- Any changes affect everyone
- Discuss schema changes with the entire team first

⚠️ **ALWAYS test before committing!**
- Broken code affects the whole team
- Test with sample data
- Verify your logic is correct

⚠️ **COORDINATE cross-table work!**
- If your queries use someone else's tables, let them know
- Make sure you understand foreign key relationships
- Test with realistic data

### Success Tips

💡 **Start early** - Don't wait until the deadline

💡 **Start simple** - Begin with queries, they're easiest

💡 **Test frequently** - Small, tested steps are better than big untested changes

💡 **Comment as you go** - Future you will thank present you

💡 **Ask for help** - We're a team!

💡 **Help others** - Teaching reinforces your own learning

---

## Summary: Your Action Plan

### This Week
1. ✅ Read this entire document
2. ✅ Set up your environment
3. ✅ Run table_schema.sql
4. ✅ Explore your table files
5. ✅ Start Query 1

### Next Weeks
- Complete all 3 queries
- Build your stored procedure
- Create your function
- Implement your trigger
- Test everything together
- Update progress tracking

### Success Criteria
- All 6 components completed
- All code tested and working
- All code commented
- All work committed to Git
- Progress tracking updated

---

**Good luck and happy coding! Remember, we're all learning together. Don't hesitate to ask for help or offer assistance to others.** 🚀

---

**Last Updated**: November 2025  
**Repository**: https://github.com/virat-kumar/UrbanEase-database
