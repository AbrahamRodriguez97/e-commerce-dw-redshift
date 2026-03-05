-- 1. Poblar Dimensiones (Carga Directa)
INSERT INTO ecommerce_project.dim_customers (customer_id, name, country, segment)
SELECT customer_id, name, country, segment FROM ecommerce_project.stg_customers;

INSERT INTO ecommerce_project.dim_products (product_id, product_name, category, price)
SELECT product_id, product_name, category, price FROM ecommerce_project.stg_products;

-- 2. Poblar Tabla de Hechos con Transformación
-- Calculamos el total_amount uniendo la tabla de órdenes con la de productos (precio * cantidad)
INSERT INTO ecommerce_project.fact_orders (order_id, customer_id, product_id, order_date, quantity, total_amount)
SELECT 
    o.order_id,
    o.customer_id,
    o.product_id,
    o.order_date,
    o.quantity,
    (o.quantity * p.price) as total_amount
FROM ecommerce_project.stg_orders o
JOIN ecommerce_project.stg_products p ON o.product_id = p.product_id;

-- 3. Vista de Rendimiento por Categoría y País
CREATE OR REPLACE VIEW ecommerce_project.v_sales_by_region AS
SELECT 
    c.country,
    p.category,
    SUM(f.quantity) as total_units,
    SUM(f.total_amount) as total_revenue,
    AVG(f.total_amount) as avg_order_value
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_customers c ON f.customer_id = c.customer_id
JOIN ecommerce_project.dim_products p ON f.product_id = p.product_id
GROUP BY c.country, p.category;

-- 4. Vista de Clientes "VIP" (Los que más gastan)
CREATE OR REPLACE VIEW ecommerce_project.v_top_customers AS
SELECT 
    c.name,
    c.segment,
    SUM(f.total_amount) as lifetime_value,
    COUNT(f.order_id) as total_orders
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.name, c.segment
ORDER BY lifetime_value DESC;

-- Prueba
-- SELECT * FROM ecommerce_project.v_sales_by_region;