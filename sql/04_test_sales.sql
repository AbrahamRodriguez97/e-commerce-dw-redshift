-- Consulta de prueba: Top 5 categorías con más ventas
SELECT 
    p.category, 
    SUM(f.total_amount) as revenue,
    COUNT(f.order_id) as total_orders
FROM ecommerce_project.fact_orders f
JOIN ecommerce_project.dim_products p ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 5;