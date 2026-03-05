# GlobalCommerce Analytics: AWS Redshift Data Warehouse Implementation

<img width="1024" height="572" alt="Architecture Diagram" src="https://github.com/user-attachments/assets/tu-imagen-aqui" />

## Overview / Resumen

**EN:** This project demonstrates the implementation of a scalable Data Warehouse using **AWS Redshift**. It covers the end-to-end process: from synthetic data generation with Python, ingestion from **Amazon S3** using the high-performance `COPY` command, to dimensional modeling (Star Schema) and ELT transformations for business intelligence.

**ES:** Este proyecto demuestra la implementación de un Data Warehouse escalable utilizando **AWS Redshift**. Cubre el proceso de extremo a extremo: desde la generación de datos sintéticos con Python, la ingesta desde **Amazon S3** mediante el comando de alto rendimiento `COPY`, hasta el modelado dimensional (Esquema en Estrella) y transformaciones ELT para inteligencia de negocios.

---

## Tech Stack / Tecnologías

* **Cloud Provider:** AWS (Amazon Web Services).
* **Data Warehouse:** Amazon Redshift (Serverless).
* **Storage / Data Lake:** Amazon S3.
* **Languages:** SQL (Redshift Dialect), Python 3.x (Pandas, Numpy).
* **Security:** AWS IAM Roles & Policies.
* **Methodology:** Star Schema & ELT (Extract, Load, Transform).

---

## Key Features / Aspectos Destacados

* **High-Speed Ingestion:** Implementation of the `COPY` command for parallel loading from S3, bypassing slow individual `INSERT` statements.
* **Performance Optimization:** Strategic use of `DISTSTYLE ALL` for small dimensions and `SORTKEY` on temporal columns to optimize query execution time.
* **Automated Data Generation:** Python script included to simulate 1,000+ orders with realistic customer and product distributions.
* **Analytical Layers:** Creation of a semantic layer via SQL Views for direct consumption by BI tools like QuickSight or Tableau.

---

## Project Structure / Estructura del Proyecto

* `scripts/`: Python scripts for data generation and local environment setup.
* `sql/01_create_tables.sql`: DDL for Staging and Production layers (Star Schema).
* `sql/02_copy_from_s3.sql`: High-performance ingestion scripts.
* `sql/03_transformations.sql`: Business logic, ELT processes, and analytical views.
* `data/`: (Local only) Source files in CSV format.

---

## Setup & Usage / Configuración

1.  **Generate Data:** Run `python scripts/data_generation.py` to create the dataset.
2.  **AWS Setup:** Create an S3 bucket and an IAM Role with `AmazonS3ReadOnlyAccess` for Redshift.
3.  **Database DDL:** Execute scripts in the `sql/` folder in numerical order within the Redshift Query Editor v2.
4.  **Verification:** Run the provided analytical queries to see the dashboard-ready results.

---

## Business Insights / Resultados de Negocio

The system provides immediate answers to:
* **Top Performing Categories:** Total revenue and order volume by product type.
* **Customer Lifetime Value (CLV):** Identification of VIP segments for targeted marketing.
* **Regional Performance:** Sales distribution across Mexico, USA, Canada, and Brazil.