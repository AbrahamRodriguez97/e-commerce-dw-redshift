-- Cargar Clientes
COPY ecommerce_project.stg_customers
FROM 's3:/ ... /raw_data/customers.csv' 
IAM_ROLE 'arn:aws:iam::'
FORMAT AS CSV 
IGNOREHEADER 1
REGION 'us-east-1';

-- Cargar Productos
COPY ecommerce_project.stg_products
FROM 's3:/ ... /raw_data/products.csv' 
IAM_ROLE 'arn:aws:iam::'
FORMAT AS CSV 
IGNOREHEADER 1
REGION 'us-east-1';

-- Cargar Ordenes (Hechos crudos)
COPY ecommerce_project.stg_orders
FROM 's3:/ ... /raw_data/orders.csv' 
IAM_ROLE 'arn:aws:iam::'
FORMAT AS CSV 
IGNOREHEADER 1
REGION 'us-east-1';