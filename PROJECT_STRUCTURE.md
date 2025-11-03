# UrbanEase Database - Project File Structure

## 📁 Complete Directory Structure

```
UrbanEase-database/
│
├── README.md                          # Main project documentation
├── TEAM_ASSIGNMENTS.md               # Team member assignments and tasks
├── PROJECT_STRUCTURE.md              # This file - explains file organization
├── table_schema.sql                  # Main database schema (18 tables)
│
├── queries/                          # Complex SQL Queries (3 per person = 18 total)
│   ├── bajwa_achint_kaur/
│   │   ├── query1_user_login_history.sql
│   │   ├── query2_users_by_role.sql
│   │   └── query3_active_users_with_roles.sql
│   │
│   ├── khapekar_pooja/
│   │   ├── query1_products_by_category.sql
│   │   ├── query2_category_hierarchy.sql
│   │   └── query3_products_without_images.sql
│   │
│   ├── kumar_virat/
│   │   ├── query1_inventory_status.sql
│   │   ├── query2_low_stock_alert.sql
│   │   └── query3_variant_pricing.sql
│   │
│   ├── min_la_yaung/
│   │   ├── query1_active_carts.sql
│   │   ├── query2_abandoned_carts.sql
│   │   └── query3_coupon_usage.sql
│   │
│   ├── tiwari_sneha/
│   │   ├── query1_order_summary.sql
│   │   ├── query2_pending_shipments.sql
│   │   └── query3_revenue_analysis.sql
│   │
│   └── velarde_sosa_diana/
│       ├── query1_payment_status.sql
│       ├── query2_user_addresses.sql
│       └── query3_product_reviews.sql
│
├── procedures/                       # Stored Procedures (1 per person = 6 total)
│   ├── sp_bajwa_manage_user_roles.sql
│   ├── sp_khapekar_manage_product.sql
│   ├── sp_kumar_update_inventory.sql
│   ├── sp_min_checkout_cart.sql
│   ├── sp_tiwari_create_shipment.sql
│   └── sp_velarde_process_payment.sql
│
├── functions/                        # User-Defined Functions (1 per person = 6 total)
│   ├── fn_bajwa_check_user_role.sql
│   ├── fn_khapekar_get_product_image_count.sql
│   ├── fn_kumar_get_available_stock.sql
│   ├── fn_min_calculate_cart_total.sql
│   ├── fn_tiwari_get_order_item_count.sql
│   └── fn_velarde_get_product_rating.sql
│
└── triggers/                         # Database Triggers (1 per person = 6 total)
    ├── tr_bajwa_audit_user_changes.sql
    ├── tr_khapekar_validate_product.sql
    ├── tr_kumar_prevent_negative_inventory.sql
    ├── tr_min_update_cart_timestamp.sql
    ├── tr_tiwari_update_order_status.sql
    └── tr_velarde_validate_review.sql
```

---

## 📊 File Count Summary

| Category | Files | Status |
|----------|-------|--------|
| **Documentation** | 3 | ✅ Complete |
| **Schema** | 1 | ✅ Complete |
| **Queries** | 18 | 📝 Placeholders Ready |
| **Procedures** | 6 | 📝 Placeholders Ready |
| **Functions** | 6 | 📝 Placeholders Ready |
| **Triggers** | 6 | 📝 Placeholders Ready |
| **TOTAL** | **40 files** | 🎯 Ready for Development |

---

## 👥 Files by Team Member

### Bajwa, Achint Kaur (User Management)
- ✅ 3 Query files in `queries/bajwa_achint_kaur/`
- ✅ 1 Procedure: `sp_bajwa_manage_user_roles.sql`
- ✅ 1 Function: `fn_bajwa_check_user_role.sql`
- ✅ 1 Trigger: `tr_bajwa_audit_user_changes.sql`
- **Total: 6 files**

### Khapekar, Pooja (Product Catalog)
- ✅ 3 Query files in `queries/khapekar_pooja/`
- ✅ 1 Procedure: `sp_khapekar_manage_product.sql`
- ✅ 1 Function: `fn_khapekar_get_product_image_count.sql`
- ✅ 1 Trigger: `tr_khapekar_validate_product.sql`
- **Total: 6 files**

### Kumar, Virat (Inventory Management)
- ✅ 3 Query files in `queries/kumar_virat/`
- ✅ 1 Procedure: `sp_kumar_update_inventory.sql`
- ✅ 1 Function: `fn_kumar_get_available_stock.sql`
- ✅ 1 Trigger: `tr_kumar_prevent_negative_inventory.sql`
- **Total: 6 files**

### Min, La Yaung (Cart & Promotions)
- ✅ 3 Query files in `queries/min_la_yaung/`
- ✅ 1 Procedure: `sp_min_checkout_cart.sql`
- ✅ 1 Function: `fn_min_calculate_cart_total.sql`
- ✅ 1 Trigger: `tr_min_update_cart_timestamp.sql`
- **Total: 6 files**

### Tiwari, Sneha (Order Management)
- ✅ 3 Query files in `queries/tiwari_sneha/`
- ✅ 1 Procedure: `sp_tiwari_create_shipment.sql`
- ✅ 1 Function: `fn_tiwari_get_order_item_count.sql`
- ✅ 1 Trigger: `tr_tiwari_update_order_status.sql`
- **Total: 6 files**

### Velarde Sosa, Diana (Payments & Reviews)
- ✅ 3 Query files in `queries/velarde_sosa_diana/`
- ✅ 1 Procedure: `sp_velarde_process_payment.sql`
- ✅ 1 Function: `fn_velarde_get_product_rating.sql`
- ✅ 1 Trigger: `tr_velarde_validate_review.sql`
- **Total: 6 files**

---

## 📝 What's in Each Placeholder File?

Each placeholder file contains:
1. ✅ **Header comment block** with author, date, description, and related tables
2. ✅ **USE urbanease_shop;** statement to ensure correct database
3. ✅ **Example structure/template** showing how to write the code
4. ✅ **TODO comment** marking where to implement logic
5. ✅ **Test example** showing how to run/test the code
6. ✅ **Helpful hints** about what the code should do

---

## 🚀 How to Use These Files

### For Team Members:

1. **Find your files** - Look for files with your name in the path
2. **Open a file** - Read the header to understand what it should do
3. **Replace TODO** - Implement the logic where it says "TODO"
4. **Test your code** - Use the provided test examples
5. **Commit your work** - Git commit when done

### Example Workflow:

```bash
# 1. Navigate to your query file
cd queries/kumar_virat/

# 2. Open and edit query1_inventory_status.sql
# 3. Write your SQL query
# 4. Test it in MySQL Workbench
# 5. Commit when working

git add query1_inventory_status.sql
git commit -m "feat: add inventory status query"
git push
```

---

## 🎯 Next Steps

### For Each Team Member:

- [ ] Review your assigned files
- [ ] Understand the table relationships for your module
- [ ] Start with the queries (easier to understand the data)
- [ ] Then build the procedure (business logic)
- [ ] Create the function (reusable calculation/check)
- [ ] Finally, implement the trigger (automatic action)

### For the Team:

- [ ] Review TEAM_ASSIGNMENTS.md for detailed task descriptions
- [ ] Coordinate on shared tables (some queries might overlap)
- [ ] Test each component thoroughly
- [ ] Document any issues or questions
- [ ] Help each other when stuck!

---

## 💡 Tips for Success

1. **Start Simple** - Get basic queries working first
2. **Test Frequently** - Test each query/procedure/function as you write it
3. **Comment Your Code** - Add comments explaining complex logic
4. **Use Meaningful Names** - Name variables and parameters clearly
5. **Handle Errors** - Add error checking in procedures
6. **Ask for Help** - Don't hesitate to ask teammates for guidance

---

## 📚 Additional Resources

- Main README.md - Database overview and schema documentation
- TEAM_ASSIGNMENTS.md - Detailed task assignments
- table_schema.sql - Reference for all table structures

---

**Last Updated**: November 2025  
**Status**: All placeholder files created ✅  
**Ready for Development**: YES 🎉

