import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Configuración de cantidad de registros
num_orders = 1000

# 1. Generar Dimension Clientes
customers = pd.DataFrame({
    'customer_id': range(1, 101),
    'name': [f'Customer_{i}' for i in range(1, 101)],
    'country': np.random.choice(['Mexico', 'USA', 'Canada', 'Brazil'], 100),
    'segment': np.random.choice(['B2B', 'B2C'], 100)
})

# 2. Generar Dimension Productos
products = pd.DataFrame({
    'product_id': range(1, 51),
    'product_name': [f'Product_{i}' for i in range(1, 51)],
    'category': np.random.choice(['Electronics', 'Home', 'Fashion', 'Toys'], 50),
    'price': np.random.uniform(10, 500, 50).round(2)
})

# 3. Generar Tabla de Hechos - Ordenes
orders = pd.DataFrame({
    'order_id': range(1, num_orders + 1),
    'customer_id': np.random.randint(1, 101, num_orders),
    'product_id': np.random.randint(1, 51, num_orders),
    'order_date': [datetime(2026, 1, 1) + timedelta(days=np.random.randint(0, 60)) for _ in range(num_orders)],
    'quantity': np.random.randint(1, 5, num_orders)
})

# Guardar a CSV
customers.to_csv('data/customers.csv', index=False)
products.to_csv('data/products.csv', index=False)
orders.to_csv('data/orders.csv', index=False)

print("Archivos CSV generados exitosamente: customers.csv, products.csv, orders.csv")