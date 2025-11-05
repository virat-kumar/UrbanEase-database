-- Target: MySQL 8.0+
-- Create database and use it
CREATE DATABASE IF NOT EXISTS urbanease_shop
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE urbanease_shop;

/* ===========================
   1) Accounts & Addresses
   =========================== */

CREATE TABLE Users (
  user_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
  email         VARCHAR(320) NOT NULL UNIQUE,
  password_hash VARBINARY(256) NOT NULL,
  full_name     VARCHAR(120) NOT NULL,
  phone         VARCHAR(32) NULL,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Roles (
  role_id   INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(64) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE UserRoles (
  user_id BIGINT NOT NULL,
  role_id INT NOT NULL,
  assigned_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  CONSTRAINT FK_UserRoles_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
  CONSTRAINT FK_UserRoles_Role FOREIGN KEY (role_id) REFERENCES Roles(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Addresses (
  address_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id      BIGINT NOT NULL,
  label        VARCHAR(40) NULL,     -- Home/Office
  name         VARCHAR(120) NOT NULL,
  line1        VARCHAR(160) NOT NULL,
  line2        VARCHAR(160) NULL,
  city         VARCHAR(80)  NOT NULL,
  state_region VARCHAR(80)  NOT NULL,
  postal_code  VARCHAR(20)  NOT NULL,
  country_code CHAR(2)      NOT NULL,
  phone        VARCHAR(32)  NULL,
  is_default   BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Address_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   2) Catalog (single-category per product to keep 18 total)
   =========================== */

CREATE TABLE Categories (
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  parent_id   BIGINT NULL,
  name        VARCHAR(120) NOT NULL,
  slug        VARCHAR(160) NOT NULL UNIQUE,
  CONSTRAINT FK_Category_Parent FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Products (
  product_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NULL,
  title       VARCHAR(200) NOT NULL,
  description TEXT NULL,
  brand       VARCHAR(100) NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES Categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ProductImages (
  image_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  url        VARCHAR(512) NOT NULL,
  alt_text   VARCHAR(160) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Image_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   3) Variants & Inventory
   =========================== */

CREATE TABLE ProductVariants (
  variant_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id      BIGINT       NOT NULL,
  sku             VARCHAR(64)  NOT NULL UNIQUE,
  attributes_json JSON NULL,  -- {"size":"M","color":"Black"}
  price           DECIMAL(12,2) NOT NULL CHECK (price >= 0),
  currency        CHAR(3)       NOT NULL DEFAULT 'USD',
  is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
  created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Variant_Product FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Warehouses (
  warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(120) NOT NULL,
  code         VARCHAR(32)  NOT NULL UNIQUE,
  city         VARCHAR(80)  NULL,
  state_region VARCHAR(80)  NULL,
  country_code CHAR(2)      NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Inventory (
  warehouse_id BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  on_hand      INT    NOT NULL CHECK (on_hand >= 0),
  reserved     INT    NOT NULL DEFAULT 0 CHECK (reserved >= 0),
  PRIMARY KEY (warehouse_id, variant_id),
  CONSTRAINT FK_Inv_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
  CONSTRAINT FK_Inv_Variant   FOREIGN KEY (variant_id)   REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   4) Cart & Coupons
   =========================== */

CREATE TABLE Carts (
  cart_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    BIGINT NULL,  -- allow guest carts if NULL (tracked externally)
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Cart_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE CartItems (
  cart_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  cart_id      BIGINT NOT NULL,
  variant_id   BIGINT NOT NULL,
  qty          INT    NOT NULL CHECK (qty > 0),
  unit_price   DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  added_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_CI_Cart    FOREIGN KEY (cart_id)    REFERENCES Carts(cart_id),
  CONSTRAINT FK_CI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Coupons (
  coupon_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  code         VARCHAR(40)   NOT NULL UNIQUE,
  type         VARCHAR(20)   NOT NULL CHECK (type IN ('PERCENT','AMOUNT')),
  value        DECIMAL(12,2) NOT NULL CHECK (value >= 0),
  starts_at    DATETIME      NULL,
  expires_at   DATETIME      NULL,
  min_subtotal DECIMAL(12,2) NULL,
  is_active    BOOLEAN       NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   5) Orders, Items, Shipments
   =========================== */

CREATE TABLE Orders (
  order_id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id             BIGINT NOT NULL,
  status              VARCHAR(20) NOT NULL CHECK (status IN ('PENDING','PAID','CANCELLED','FULFILLED','REFUNDED')),
  subtotal_amount     DECIMAL(12,2) NOT NULL CHECK (subtotal_amount >= 0),
  discount_amount     DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
  shipping_amount     DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (shipping_amount >= 0),
  tax_amount          DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
  grand_total_amount  DECIMAL(12,2) GENERATED ALWAYS AS (subtotal_amount - discount_amount + shipping_amount + tax_amount) STORED,
  coupon_id           BIGINT NULL,
  shipping_address_id BIGINT NOT NULL,
  billing_address_id  BIGINT NOT NULL,
  placed_at           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT FK_Order_User     FOREIGN KEY (user_id)             REFERENCES Users(user_id),
  CONSTRAINT FK_Order_Coupon   FOREIGN KEY (coupon_id)           REFERENCES Coupons(coupon_id),
  CONSTRAINT FK_Order_ShipAdr  FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
  CONSTRAINT FK_Order_BillAdr  FOREIGN KEY (billing_address_id)  REFERENCES Addresses(address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE OrderItems (
  order_item_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id        BIGINT        NOT NULL,
  variant_id      BIGINT        NOT NULL,
  qty             INT           NOT NULL CHECK (qty > 0),
  unit_price      DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  tax_amount      DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
  discount_amount DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
  CONSTRAINT FK_OI_Order   FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
  CONSTRAINT FK_OI_Variant FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Shipments (
  shipment_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT      NOT NULL,
  warehouse_id BIGINT      NULL,
  carrier      VARCHAR(80) NOT NULL,
  tracking_no  VARCHAR(120) NULL,
  status       VARCHAR(20) NOT NULL CHECK (status IN ('CREATED','PICKED','IN_TRANSIT','DELIVERED','CANCELLED')),
  shipped_at   DATETIME NULL,
  delivered_at DATETIME NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Ship_Order     FOREIGN KEY (order_id)     REFERENCES Orders(order_id),
  CONSTRAINT FK_Ship_Warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ===========================
   6) Payments & Reviews
   =========================== */

CREATE TABLE Payments (
  payment_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id     BIGINT       NOT NULL,
  provider     VARCHAR(40)  NOT NULL,  -- Stripe/PayPal/etc.
  provider_ref VARCHAR(120) NULL,
  amount       DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
  status       VARCHAR(20)   NOT NULL CHECK (status IN ('INITIATED','AUTHORIZED','CAPTURED','FAILED','REFUNDED')),
  paid_at      DATETIME      NULL,
  created_at   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Payment_Order FOREIGN KEY (order_id) REFERENCES Orders(order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Reviews (
  review_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  user_id    BIGINT NOT NULL,
  rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  title      VARCHAR(160) NULL,
  body       TEXT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Review_Product FOREIGN KEY (product_id) REFERENCES Products(product_id),
  CONSTRAINT FK_Review_User    FOREIGN KEY (user_id)    REFERENCES Users(user_id),
  CONSTRAINT UQ_Review_User_Product UNIQUE (product_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Helpful indexes */
CREATE INDEX IX_Variant_Product   ON ProductVariants(product_id);
CREATE INDEX IX_Product_Category  ON Products(category_id);
CREATE INDEX IX_Inventory_Variant ON Inventory(variant_id);
CREATE INDEX IX_Order_User        ON Orders(user_id);
CREATE INDEX IX_OrderItems_Order  ON OrderItems(order_id);
CREATE INDEX IX_CartItems_Cart    ON CartItems(cart_id);
CREATE INDEX IX_Payments_Order    ON Payments(order_id);


/* Sample Values Created by La Yaung Min */
-- Note: These samples are required to run La Yaung Min's queries, trigger, function, and procedure.
-- Added values into users table 
INSERT INTO Users (email, password_hash, full_name, phone) VALUES
  ('alice@gmail.com', UNHEX(SHA2('password1', 256)), 'Alice Johnson', '+1-555-1010'),
  ('bob@gmail.com',   UNHEX(SHA2('password2', 256)), 'Bob Smith', '+1-555-2020'),
  ('carol@gmail.com', UNHEX(SHA2('password3', 256)), 'Carol Lee', '+1-555-3030'),
  ('dave@gmail.com',  UNHEX(SHA2('password4', 256)), 'Dave Kim', '+1-555-4040'),
  ('emma@gmail.com',  UNHEX(SHA2('password5', 256)), 'Emma Brown', '+1-555-5050');


-- Added values into categories table 
INSERT INTO Categories (parent_id, name, slug) VALUES
  (NULL, 'Electronics', 'electronics'),
  (1, 'Smartphones', 'smartphones'),
  (1, 'Laptops', 'laptops'),
  (1, 'Accessories', 'accessories'),
  (NULL, 'Home Appliances', 'home-appliances');


-- Added values into products table
INSERT INTO Products (category_id, title, description, brand) VALUES
  (2, 'iPhone 15', 'Apple’s latest smartphone with A17 Pro chip', 'Apple'),
  (2, 'Galaxy S24', 'Samsung flagship smartphone with AI features', 'Samsung'),
  (3, 'MacBook Air 13"', 'Lightweight laptop with M3 chip', 'Apple'),
  (3, 'Dell XPS 13', 'Compact ultrabook with Intel i7', 'Dell'),
  (4, 'AirPods Pro 2', 'Wireless noise-cancelling earbuds', 'Apple'),
  (4, 'Logitech MX Master 3S', 'Wireless mouse with ergonomic design', 'Logitech'),
  (5, 'Dyson V15 Detect', 'Cordless vacuum cleaner', 'Dyson'),
  (5, 'Instant Pot Duo 7-in-1', 'Multi-functional electric pressure cooker', 'Instant Brands');


-- Added values into productvariants table
INSERT INTO ProductVariants (product_id, sku, attributes_json, price, currency) VALUES
  (1, 'SKU-IP15-128', '{"storage":"128GB","color":"Black"}', 999.99, 'USD'),
  (1, 'SKU-IP15-256', '{"storage":"256GB","color":"Silver"}', 1099.99, 'USD'),
  (2, 'SKU-GS24-256', '{"storage":"256GB","color":"Gray"}', 899.99, 'USD'),
  (3, 'SKU-MBA13-8',  '{"ram":"8GB","storage":"256GB"}', 1299.00, 'USD'),
  (3, 'SKU-MBA13-16', '{"ram":"16GB","storage":"512GB"}', 1599.00, 'USD'),
  (4, 'SKU-XPS13-16', '{"ram":"16GB","storage":"1TB"}', 1399.00, 'USD'),
  (5, 'SKU-APP2-WHT', '{"color":"White"}', 249.99, 'USD'),
  (6, 'SKU-LMX3S-BLK', '{"color":"Black"}', 99.99, 'USD'),
  (7, 'SKU-DYSV15', '{"accessory":"Standard Kit"}', 749.99, 'USD'),
  (8, 'SKU-IPD7', '{"size":"6QT"}', 129.99, 'USD');
  
  -- Added values into carts table
  INSERT INTO Carts (user_id) VALUES
  (1),
  (2),
  (3),
  (NULL),
  (4),
  (NULL),
  (5),
  (NULL),
  (NULL),
  (NULL);


-- Added values into cart items table
INSERT INTO CartItems (cart_id, variant_id, qty, unit_price) VALUES 
  (1, 1, 2, 999.99),
  (1, 2, 1, 1099.99),
  (2, 3, 3, 49.99),
  (2, 4, 1, 89.99),
  (3, 5, 1, 799.00),
  (4, 6, 2, 1299.00),
  (5, 7, 1, 59.99),
  (6, 8, 4, 29.99),
  (7, 9, 2, 249.99),
  (8, 10, 1, 149.99);


-- Added values into coupons table
INSERT INTO Coupons (code, type, value, starts_at, expires_at, min_subtotal, is_active) VALUES 
  ('SAVE10', 'PERCENT', 10.00, '2024-01-01', '2024-12-31', 50.00, TRUE),
  ('FREESHIP', 'AMOUNT', 15.00, '2024-01-01', '2024-06-30', 100.00, TRUE),
  ('WELCOME20', 'PERCENT', 20.00, '2024-01-01', '2024-12-31', NULL, TRUE),
  ('FLASH50', 'AMOUNT', 50.00, '2024-11-01', '2024-11-30', 200.00, TRUE);
  
-- End La Yaung Min's sample values



