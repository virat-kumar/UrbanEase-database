#!/usr/bin/env python3
"""
UrbanEase Database - Complete SQL File Builder
Simple approach: Read all files and concatenate, then remove comments
"""

import os
import re
from pathlib import Path

# Base directory
BASE_DIR = Path(__file__).parent

# Define execution order based on EXECUTION_ORDER.md
EXECUTION_ORDER = [
    # Schema
    "table_schema.sql",
    
    # Tables
    "tables/bajwa_achint_kaur/create_roles_table.sql",
    "tables/khapekar_pooja/create_categories_table.sql",
    "tables/kumar_virat/create_warehouses_table.sql",
    "tables/min_la_yaung/create_coupons_table.sql",
    "tables/bajwa_achint_kaur/create_users_table.sql",
    "tables/velarde_sosa_diana/create_addresses_table.sql",
    "tables/khapekar_pooja/create_products_table.sql",
    "tables/min_la_yaung/create_carts_table.sql",
    "tables/bajwa_achint_kaur/create_user_roles_table.sql",
    "tables/kumar_virat/create_product_variants_table.sql",
    "tables/khapekar_pooja/create_product_images_table.sql",
    "tables/kumar_virat/create_inventory_table.sql",
    "tables/min_la_yaung/create_cart_items_table.sql",
    "tables/tiwari_sneha/create_orders_table.sql",
    "tables/tiwari_sneha/create_order_items_table.sql",
    "tables/tiwari_sneha/create_shipments_table.sql",
    "tables/velarde_sosa_diana/create_payments_table.sql",
    "tables/velarde_sosa_diana/create_reviews_table.sql",
    
    # Procedures
    "procedures/sp_bajwa_manage_user_roles.sql",
    "procedures/sp_khapekar_manage_product.sql",
    "procedures/sp_kumar_update_inventory.sql",
    "procedures/sp_min_checkout_cart.sql",
    "procedures/sp_tiwari_create_shipment.sql",
    "procedures/sp_velarde_analyze_customer_performance.sql",
    
    # Functions
    "functions/fn_bajwa_check_user_role.sql",
    "functions/fn_khapekar_get_product_image_count.sql",
    "functions/fn_kumar_get_available_stock.sql",
    "functions/fn_min_calculate_cart_total.sql",
    "functions/fn_tiwari_get_order_item_count.sql",
    "functions/fn_velarde_fn_get_user_total_spending.sql",
    
    # Triggers
    "triggers/tr_bajwa_audit_user_changes.sql",
    "triggers/tr_khapekar_validate_product.sql",
    "triggers/tr_kumar_prevent_negative_inventory.sql",
    "triggers/tr_min_update_cart_timestamp.sql",
    "triggers/tr_tiwari_validate_review.sql",
    "triggers/tr_velarde_trg_update_order_status_after_payment.sql",
    
    # Queries
    "queries/bajwa_achint_kaur/query1_user_login_history.sql",
    "queries/bajwa_achint_kaur/query2_users_by_role.sql",
    "queries/bajwa_achint_kaur/query3_active_users_with_roles.sql",
    "queries/bajwa_achint_kaur/query4_Product_performance_by_sales_revenue_ratings.sql",
    "queries/bajwa_achint_kaur/query5_fulfillment_performance.sql",
    "queries/khapekar_pooja/query1_products_by_category.sql",
    "queries/khapekar_pooja/query2_category_hierarchy.sql",
    "queries/khapekar_pooja/query3_products_without_images.sql",
    "queries/kumar_virat/query1_customer_order_fulfillment_analysis.sql",
    "queries/kumar_virat/query2_product_performance_customer_insights.sql",
    "queries/kumar_virat/query3_abandoned_cart_recovery_intelligence.sql",
    "queries/kumar_virat/query4_comprehensive_revenue_profitability_dashboard.sql",
    "queries/kumar_virat/query5_customer_lifetime_value_segmentation.sql",
    "queries/min_la_yaung/query1_active_carts.sql",
    "queries/min_la_yaung/query2_abandoned_carts.sql",
    "queries/min_la_yaung/query3_coupon_usage.sql",
    "queries/min_la_yaung/query4_carttotals_coupdiscounts.sql",
    "queries/min_la_yaung/query5_popular_product.sql",
    "queries/tiwari_sneha/query1_order_summary.sql",
    "queries/tiwari_sneha/query2_Top_Selling_Products.sql",
    "queries/tiwari_sneha/query3_Coupon_Performance_Report.sql",
    "queries/tiwari_sneha/query4_Order_Fulfillment_Shipment_Tracking.sql",
    "queries/tiwari_sneha/query5_Customer_Lifetime_Value_Analysis.sql",
    "queries/velarde_sosa_diana/query1_Customer_Insights_Report.sql",
    "queries/velarde_sosa_diana/query2_user_addresses.sql",
    "queries/velarde_sosa_diana/query3_product_reviews.sql",
]

def remove_test_sections(content, filepath):
    """Remove test/verification sections from SQL files."""
    
    # For table files - remove verification queries
    if filepath.startswith('tables/'):
        lines = content.split('\n')
        result_lines = []
        skip = False
        
        for line in lines:
            # Start skipping at verification comments or SELECT queries after data
            if any(marker in line for marker in ['-- Verify', 'SELECT COUNT(*) AS total_', 'SELECT * FROM']):
                # Check if it's part of INSERT (subquery)
                if '(SELECT' in line or 'VALUES' in line:
                    result_lines.append(line)
                else:
                    skip = True
            
            if not skip:
                result_lines.append(line)
        
        return '\n'.join(result_lines)
    
    # For procedures - remove everything after the final DELIMITER ;
    elif filepath.startswith('procedures/'):
        lines = content.split('\n')
        result_lines = []
        delimiter_count = 0
        
        for line in lines:
            if 'DELIMITER ;' in line:
                delimiter_count += 1
                result_lines.append(line)
                # After second DELIMITER ; (end of procedure), stop including lines
                if delimiter_count >= 2:
                    break
            else:
                result_lines.append(line)
        
        return '\n'.join(result_lines)
    
    # For functions and triggers - remove test sections
    elif filepath.startswith('functions/') or filepath.startswith('triggers/'):
        lines = content.split('\n')
        result_lines = []
        skip = False
        delimiter_count = 0
        
        for line in lines:
            # Count DELIMITER statements
            if 'DELIMITER' in line:
                delimiter_count += 1
                result_lines.append(line)
                # After final DELIMITER ; (end of definition), start checking for tests
                if delimiter_count >= 2:
                    skip = True
                continue
            
            # Skip test sections
            if skip and any(marker in line for marker in ['-- Test', 'SELECT', 'CALL', 'INSERT', 'UPDATE']):
                continue
            
            if not skip:
                result_lines.append(line)
        
        return '\n'.join(result_lines)
    
    # Return as-is for other files
    return content

def create_complete_database_file():
    """Create the complete database SQL file."""
    output_file = BASE_DIR / "complete_urbanease_database.sql"
    
    print("=" * 70)
    print("UrbanEase Database - Complete SQL File Builder")
    print("=" * 70)
    print()
    print("Concatenating all SQL files in execution order...")
    print()
    
    with open(output_file, 'w', encoding='utf-8') as outfile:
        # Add header
        outfile.write("""-- =============================================
-- UrbanEase Database - Complete Setup Script
-- =============================================
-- Auto-generated from 63 SQL files (Schema + Tables + Procedures + Functions + Triggers + Queries)
-- Database: urbanease_shop
-- MySQL Version: 8.0+
-- Generated: 2025-12-06
-- =============================================

""")
        
        # Read and concatenate all files
        for i, filepath in enumerate(EXECUTION_ORDER, 1):
            full_path = BASE_DIR / filepath
            
            if not full_path.exists():
                print(f"  [{i}/{len(EXECUTION_ORDER)}] ⚠ WARNING: {filepath} not found")
                continue
            
            print(f"  [{i}/{len(EXECUTION_ORDER)}] {filepath}")
            
            with open(full_path, 'r', encoding='utf-8') as infile:
                content = infile.read()
            
            # Remove test sections
            content = remove_test_sections(content, filepath)
            
            # Add file separator
            outfile.write(f"\n-- {'=' * 68}\n")
            outfile.write(f"-- File: {filepath}\n")
            outfile.write(f"-- {'=' * 68}\n\n")
            
            # Write filtered content
            outfile.write(content)
            outfile.write("\n\n")
    
    # Calculate file size
    file_size = output_file.stat().st_size
    
    print()
    print("=" * 70)
    print(f"✓ Complete database file created: {output_file.name}")
    print(f"✓ File size: {file_size:,} bytes ({file_size / 1024:.1f} KB)")
    print(f"✓ Total files combined: {len(EXECUTION_ORDER)}")
    print("=" * 70)
    print()
    
    return output_file

if __name__ == "__main__":
    try:
        output_file = create_complete_database_file()
        print("✓ Success! Test with:")
        print(f"  mysql -u root -p < {output_file.name}")
        print()
    except Exception as e:
        print(f"✗ Error: {e}")
        import traceback
        traceback.print_exc()
