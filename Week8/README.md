# Week 8 – E-Commerce Analytics System

This repository contains my **Week 8 assignment** for the **Celebal Excellence Internship Program – Data Engineering**.

## Objective

Design and develop an **end-to-end E-Commerce Analytics System** using **Python** and **SQL**. The project covers the complete data pipeline from generating realistic datasets to performing business analytics and building a reporting tool.

---

## Project Workflow

The project follows the workflow below:

1. Generate realistic e-commerce datasets using Python (Faker & Random).
2. Introduce intentional data inconsistencies for cleaning practice.
3. Clean and validate the datasets using Pandas.
4. Load the cleaned datasets into a MySQL database.
5. Perform SQL analytics using joins and aggregations.
6. Implement advanced SQL concepts including Window Functions and Common Table Expressions (CTEs).
7. Perform Cohort Analysis and Customer Segmentation.
8. Build a reporting tool using SQLite.
9. Handle common edge cases through Python test cases.

---

## Technologies Used

- Python
- Pandas
- Faker
- Random
- SQL
- MySQL
- MySQL Workbench
- SQLite
- VS Code

---

## Project Structure

```
Week8/
│── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   ├── cleaned/
│   │   ├── customers_clean.csv
│   │   ├── products_clean.csv
│   │   ├── orders_clean.csv
│   │   └── order_items_clean.csv
│   │
│   └── issues_report.txt
│
│── database/
│   └── ecommerce.db
│
│── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── report_cli.py
│   └── test_cases.py
│
│── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
│── Project Outputs.pdf
│
└── README.md
```

---

## Implementation

### Step 1 – Dataset Generation

Generated four realistic datasets using **Python**, **Faker**, and **Random**:

- Customers
- Products
- Orders
- Order Items

The generated data intentionally includes:

- Invalid email addresses
- NULL customer IDs
- Incorrect date formats
- Product names with formatting issues
- Negative quantities
- Duplicate records
- Invalid order references for referential integrity testing

---

### Step 2 – Data Cleaning

The raw datasets were cleaned using **Pandas** by:

- Handling missing values
- Removing duplicate records
- Correcting invalid email addresses
- Standardizing product names
- Converting incorrect date formats
- Correcting negative quantities
- Validating referential integrity across tables

A **Data Quality Report (issues_report.txt)** is generated containing:

- Invalid email records
- Invalid order references

The cleaned datasets were exported as CSV files.

---

### Step 3 – Database Design

Created the MySQL database schema with appropriate:

- Primary Keys
- Foreign Keys
- Table relationships

The cleaned datasets were then loaded into the database.

---

### Step 4 – SQL Analytics

Performed business analytics using SQL, including:

- Revenue per customer
- Revenue per category
- Monthly revenue
- Top-selling products by quantity
- Top-selling products by revenue
- Average Order Value (AOV) by customer type

These analyses were implemented using SQL JOINs and aggregation functions.

---

### Step 5 – Advanced SQL

Implemented advanced SQL concepts such as:

- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- Running Totals
- Moving Averages
- Common Table Expressions (CTEs)
- Monthly Revenue Analysis
- Monthly Growth Analysis using LAG()

---

### Step 6 – Customer Analytics

Performed customer analytics including:

- Cohort Analysis
- Monthly Retention Analysis
- One-Time vs Repeat Customer Analysis
- Purchase Frequency Segmentation
- Spend Tier Segmentation
- RFM (Recency, Frequency, Monetary) Analysis

---

### Step 7 – Reporting Tool

Developed a Python reporting tool that connects to a **SQLite** database and generates summary reports.

Supported reports include:

- Daily Report
- Weekly Report
- Monthly Report

The reporting tool also handles:

- Invalid date format
- Database connection errors
- Empty result sets
- Query execution errors

---

### Step 8 – Edge Case Handling

Implemented Python test cases to verify:

- Invalid order references
- Discount percentage greater than 100
- Zero quantity
- Future order dates

These tests demonstrate how the system detects unexpected or invalid input conditions.

---

## How to Run

### 1. Generate Raw Data

```bash
python scripts/generate_data.py
```

### 2. Clean the Data

```bash
python scripts/clean_data.py
```

### 3. Create Database

Execute:

```
sql/schema.sql
```

Import the cleaned CSV files into MySQL.

### 4. Run SQL Queries

Execute the SQL scripts:

- aggregations.sql
- window_functions.sql
- cohort_analysis.sql

### 5. Create SQLite Database

Create **ecommerce.db** from the cleaned CSV files for the reporting tool.

### 6. Run the Reporting Tool

```bash
python scripts/report_cli.py
```

Enter:

- Report Type (daily / weekly / monthly)
- Start Date
- End Date

### 7. Run Edge Case Tests

```bash
python scripts/test_cases.py
```

---

## Files Included

- data/raw/ - Raw Datasets
- data/cleaned/ - Cleaned Datasets
- scripts/generate_data.py - Dataset Generation Script
- scripts/clean_data.py - Data Cleaning Script
- scripts/report_cli.py - Reporting Tool
- scripts/test_cases.py - Edge Case Test Script
- sql/schema.sql - SQL Schema
- sql/aggregations.sql - SQL Analytics Queries
- sql/window_functions.sql - Window Function Queries
- sql/cohort_analysis.sql - Cohort Analysis Queries
- data/issues_report.txt - Data Quality Report
- database/ecommerce.db - E-Commerce Database
- Project Outputs.pdf - Project Outputs Screenshots

---

## Conclusion

This project demonstrates the complete workflow of an end-to-end e-commerce analytics system, covering realistic dataset generation using **Faker** and **Random**, data cleaning with **Pandas**, database design, SQL analytics, customer segmentation, edge case validation, and automated reporting using **Python**, **MySQL**, and **SQLite**.