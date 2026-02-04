-- =====================================================
-- Store Admin - Quick Setup SQL
-- Run this in PostgreSQL (pgAdmin, DBeaver, or psql)
-- =====================================================

-- 1. Drop existing tables (if any)
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS users;

-- 2. Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100),
    phone VARCHAR(20),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create category table
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create product table
CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price INTEGER NOT NULL DEFAULT 0,
    stock INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category(id)
);

-- 5. Insert sample categories
INSERT INTO category (name) VALUES ('Electronics');
INSERT INTO category (name) VALUES ('Clothing');
INSERT INTO category (name) VALUES ('Food');
INSERT INTO category (name) VALUES ('Furniture');
INSERT INTO category (name) VALUES ('Books');

-- 6. Insert sample products
INSERT INTO product (name, price, stock, category_id) VALUES ('Laptop', 1500000, 50, 1);
INSERT INTO product (name, price, stock, category_id) VALUES ('Smartphone', 1200000, 100, 1);
INSERT INTO product (name, price, stock, category_id) VALUES ('T-Shirt', 29000, 300, 2);
INSERT INTO product (name, price, stock, category_id) VALUES ('Jeans', 59000, 150, 2);
INSERT INTO product (name, price, stock, category_id) VALUES ('Ramen Box', 12000, 1000, 3);
INSERT INTO product (name, price, stock, category_id) VALUES ('Coffee Beans', 25000, 100, 3);
INSERT INTO product (name, price, stock, category_id) VALUES ('Office Chair', 150000, 40, 4);
INSERT INTO product (name, price, stock, category_id) VALUES ('Java Programming', 32000, 100, 5);

-- 7. Insert sample users
INSERT INTO users (username, email, password, name, phone, status) VALUES ('john', 'john@email.com', '1234', 'John Doe', '010-1111-1111', 'ACTIVE');
INSERT INTO users (username, email, password, name, phone, status) VALUES ('jane', 'jane@email.com', '1234', 'Jane Smith', '010-2222-2222', 'ACTIVE');
INSERT INTO users (username, email, password, name, phone, status) VALUES ('admin', 'admin@email.com', 'admin', 'Admin', '010-0000-0000', 'ACTIVE');

-- 8. Verify data
SELECT * FROM category ORDER BY id;
SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id ORDER BY p.id;
SELECT * FROM users ORDER BY id;
