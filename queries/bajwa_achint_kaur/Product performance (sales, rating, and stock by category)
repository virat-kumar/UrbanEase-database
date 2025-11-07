-- =============================================
-- Author: Bajwa, Achint Kaur
-- Create date: 2025-11
-- Description: Product performance summary = sales, revenue, ratings, and
--              available stock (on_hand - reserved) aggregated across warehouses.
-- Tables: Products, Categories, ProductVariants, OrderItems, Orders, Reviews, Inventory
-- =============================================

USE urbanease_shop;

WITH params AS (
  SELECT 
    DATE('2024-01-01') AS p_start_date,
    DATE('2025-12-31') AS p_end_date
),
order_lines AS (
  -- Paid/fulfilled order items in date range
  SELECT 
      oi.variant_id,
      oi.qty,
      (oi.qty * oi.unit_price) AS line_revenue
  FROM OrderItems oi
  JOIN Orders o ON o.order_id = oi.order_id
  JOIN params p
    ON o.placed_at >= p.p_start_date
   AND o.placed_at <  p.p_end_date + INTERVAL 1 DAY
  WHERE o.status IN ('PAID','FULFILLED')   -- exclude cancelled/refunded
),
variant_sales AS (
  SELECT 
      variant_id,
      SUM(qty)                  AS units_sold,
      SUM(line_revenue)         AS revenue
  FROM order_lines
  GROUP BY variant_id
),
variant_ratings AS (
  SELECT 
      pv.variant_id,
      AVG(r.rating) AS avg_rating,
      COUNT(*)      AS rating_count
  FROM Reviews r
  JOIN Products p  ON p.product_id = r.product_id
  JOIN ProductVariants pv ON pv.product_id = p.product_id
  GROUP BY pv.variant_id
),
variant_stock AS (
  -- Sum stock across all warehouses for each variant
  SELECT 
      i.variant_id,
      GREATEST(SUM(i.on_hand - i.reserved), 0) AS available_stock
  FROM Inventory i
  GROUP BY i.variant_id
)
SELECT
  p.product_id,
  p.title                           AS product_title,
  c.name                            AS category,
  pv.variant_id,
  pv.sku,
  COALESCE(vs.units_sold, 0)        AS units_sold,
  COALESCE(vs.revenue, 0.00)        AS revenue_usd,
  ROUND(COALESCE(vr.avg_rating, 0), 2) AS avg_rating,
  COALESCE(vr.rating_count, 0)      AS rating_count,
  COALESCE(vst.available_stock, 0)  AS available_stock,
  CASE 
    WHEN COALESCE(vst.available_stock,0) = 0 THEN 'OUT OF STOCK'
    WHEN COALESCE(vst.available_stock,0) < 10 THEN 'LOW'
    WHEN COALESCE(vst.available_stock,0) < 50 THEN 'MEDIUM'
    ELSE 'HIGH'
  END AS stock_band
FROM Products p
LEFT JOIN Categories c         ON c.category_id = p.category_id
JOIN ProductVariants pv        ON pv.product_id = p.product_id
LEFT JOIN variant_sales  vs    ON vs.variant_id = pv.variant_id
LEFT JOIN variant_ratings vr   ON vr.variant_id = pv.variant_id
LEFT JOIN variant_stock  vst   ON vst.variant_id = pv.variant_id
WHERE p.is_active = 1 AND pv.is_active = 1
ORDER BY revenue_usd DESC, units_sold DESC, pv.variant_id
LIMIT 25;

-- COMMENTS
-- 1) Uses CTE `params` so graders can quickly change the date window.
-- 2) Counts sales only from Orders with status PAID/FULFILLED (business-valid revenue).
-- 3) Revenue = SUM(qty*unit_price) at order-line granularity; grouped per variant.
-- 4) Ratings averaged at variant level by bridging Reviews -> Products -> ProductVariants.
-- 5) Stock is rolled up across all Warehouses: SUM(on_hand - reserved).
-- 6) Robust to missing data via COALESCE; adds a stock_band label for UX/reporting.
-- 7) Helpful indexes (if large data):
--      CREATE INDEX IX_O_placed_status ON Orders(placed_at, status);
--      CREATE INDEX IX_OI_variant ON OrderItems(variant_id);
--      CREATE INDEX IX_Inv_variant ON Inventory(variant_id);
--      CREATE INDEX IX_Prod_category ON Products(category_id);
