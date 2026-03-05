-- 1. Crear un esquema para organizar el proyecto
CREATE SCHEMA IF NOT EXISTS ecommerce_project;

-- ==========================================================
-- CAPA DE STAGING (Carga directa desde S3)
-- ==========================================================

CREATE TABLE ecommerce_project.stg_customers (
    customer_id INT,
    name VARCHAR(100),
    country VARCHAR(50),
    segment VARCHAR(50)
);

CREATE TABLE ecommerce_project.stg_products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE ecommerce_project.stg_orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

-- ==========================================================
-- CAPA DE PRODUCCIÓN (Modelado Dimensional Optimizado)
-- ==========================================================

-- Dimensión Clientes: Usamos DISTSTYLE ALL porque es una tabla pequeña 
-- y queremos que esté presente en todos los nodos para evitar "shuffling" en los joins.
CREATE TABLE ecommerce_project.dim_customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50),
    segment VARCHAR(50)
) DISTSTYLE ALL;

-- Dimensión Productos: También DISTSTYLE ALL.
CREATE TABLE ecommerce_project.dim_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
) DISTSTYLE ALL;

-- Tabla de Hechos (Ventas): 
-- DISTSTYLE KEY (customer_id) para alinear datos con clientes si fuera necesario,
-- o simplemente DISTSTYLE AUTO. Usaremos SORTKEY en la fecha para filtrar rápido por tiempo.
CREATE TABLE ecommerce_project.fact_orders (
    order_id INT,
    customer_id INT REFERENCES ecommerce_project.dim_customers(customer_id),
    product_id INT REFERENCES ecommerce_project.dim_products(product_id),
    order_date DATE SORTKEY,
    quantity INT,
    total_amount DECIMAL(12,2)
) 
DISTSTYLE AUTO;