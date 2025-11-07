-- =============================================
-- Author:       Bajwa, Achint Kaur
-- Create date:  November 2025
-- Description:  Fulfillment SLA by warehouse & carrier:
--               - Ship time (placed_at -> shipped_at)
--               - Delivery time (shipped_at -> delivered_at)
--               - On-time shipping/delivery rates
--               - Volume of shipments
-- Tables:       Orders, Shipments, Warehouses
-- =============================================

USE urbanease_shop;

WITH params AS (
  SELECT 
    DATE('2024-01-01') AS p_start_date,
    DATE('2025-12-31') AS p_end_date,
    48  AS ship_sla_hours,     -- on-time ship threshold (2 days)
    168 AS delivery_sla_hours  -- on-time delivery threshold (7 days)
),
ship_events AS (
  SELECT
      s.shipment_id,
      s.order_id,
      s.warehouse_id,
      s.carrier,
      s.status,
      s.shipped_at,
      s.delivered_at,
      o.placed_at
  FROM Shipments s
  JOIN Orders o ON o.order_id = s.order_id
  JOIN params p
    ON o.placed_at >= p.p_start_date
   AND o.placed_at <  p.p_end_date + INTERVAL 1 DAY
),
durations AS (
  SELECT
      se.warehouse_id,
      se.carrier,
      se.status,
      se.placed_at,
      se.shipped_at,
      se.delivered_at,
      TIMESTAMPDIFF(HOUR, se.placed_at,   se.shipped_at)   AS ship_hours,
      TIMESTAMPDIFF(HOUR, se.shipped_at,  se.delivered_at) AS delivery_hours
  FROM ship_events se
  WHERE se.shipped_at IS NOT NULL
)
SELECT
  w.warehouse_id,
  w.name                 AS warehouse_name,
  w.code                 AS warehouse_code,
  d.carrier,
  COUNT(*)                                AS shipments_total,
  SUM(d.shipped_at   IS NOT NULL)         AS shipped_cnt,
  SUM(d.delivered_at IS NOT NULL)         AS delivered_cnt,
  ROUND(AVG(d.ship_hours), 1)             AS ship_hours_avg,
  MIN(d.ship_hours)                        AS ship_hours_min,
  MAX(d.ship_hours)                        AS ship_hours_max,
  ROUND(AVG(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END), 1) AS delivery_hours_avg,
  MIN(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END)           AS delivery_hours_min,
  MAX(CASE WHEN d.delivered_at IS NOT NULL THEN d.delivery_hours END)           AS delivery_hours_max,
  CONCAT(ROUND(100 * AVG(CASE 
           WHEN d.ship_hours    IS NOT NULL 
            AND d.ship_hours   <= (SELECT ship_sla_hours FROM params) 
           THEN 1 ELSE 0 END), 1), '%') AS ship_ontime_rate,
  CONCAT(ROUND(100 * AVG(CASE 
           WHEN d.delivery_hours IS NOT NULL
            AND d.delivery_hours <= (SELECT delivery_sla_hours FROM params)
           THEN 1 ELSE 0 END), 1), '%') AS delivery_ontime_rate
FROM durations d
LEFT JOIN Warehouses w ON w.warehouse_id = d.warehouse_id
GROUP BY w.warehouse_id, w.name, w.code, d.carrier
HAVING shipments_total > 0
ORDER BY delivery_ontime_rate DESC, ship_ontime_rate DESC, shipments_total DESC
LIMIT 100;

-- COMMENTS
-- 1) Date window & SLA thresholds stored in CTE `params` for easy edits.
-- 2) Ship time = Orders.placed_at → Shipments.shipped_at.
-- 3) Delivery time = Shipments.shipped_at → Shipments.delivered_at.
-- 4) On-time shipping = <=48 hours; on-time delivery = <=168 hours.
-- 5) Filters shipments tied to orders in date range.
-- 6) Aggregates SLA metrics by warehouse & carrier.
-- 7) Good indexes:
--      CREATE INDEX IX_Orders_placed ON Orders(placed_at);
--      CREATE INDEX IX_Shipments_order ON Shipments(order_id);
--      CREATE INDEX IX_Shipments_warehouse_carrier ON Shipments(warehouse_id, carrier);
