-- Top Performing Categories
SELECT 
    p.category, 
    SUM(f.total_amount) as revenue,
    COUNT(f.order_id) as total_orders
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_products p ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 5;

-- Customer Lifetime Value (CLV)
SELECT 
    c.customer_id,
    c.name,
    c.segment,
    SUM(f.total_amount) AS clv, -- Valor total de vida del cliente
    COUNT(f.order_id) AS total_transactions,
    MAX(f.order_date) AS last_purchase_date
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.customer_id, c.name, c.segment
HAVING SUM(f.total_amount) > 0
ORDER BY clv DESC;

-- Regional Performance
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS unique_customers,
    COUNT(f.order_id) AS total_orders,
    SUM(f.total_amount) AS total_revenue,
    -- Calculamos el porcentaje de contribución por país
    ROUND(100.0 * SUM(f.total_amount) / SUM(SUM(f.total_amount)) OVER(), 2) AS revenue_percentage
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;