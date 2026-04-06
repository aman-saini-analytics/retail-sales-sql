# 🛍️ Retail Sales Analysis (SQL Project)

## 📌 Project Overview

* **Project Name:** Retail Sales Analysis
* **Level:** Beginner
* **Database:** `retail_sales`

This project demonstrates SQL skills used in real-world data analysis, including database creation, data cleaning, exploration, and business-driven analysis using retail sales data.

---

## 🎯 Objectives

* Create and structure a retail database
* Clean and validate data
* Perform exploratory data analysis (EDA)
* Solve business problems using SQL queries

---

## 🗂️ Database Setup

```sql
CREATE DATABASE retail_sales;
USE retail_sales;

CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT, 
    gender VARCHAR(10), 
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);
```

---

## 🧹 Data Cleaning

```sql
SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL
   OR cogs IS NULL 
   OR total_sale IS NULL;
```

---

## 🔍 Data Exploration

```sql
-- Total Sales Records
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS customers FROM retail_sales;

-- Total Categories
SELECT COUNT(DISTINCT category) AS category_count FROM retail_sales;

-- List of Categories
SELECT DISTINCT category FROM retail_sales;
```

---

## 📊 Business Analysis Queries

### 📅 Sales in November 2022

```sql
SELECT * 
FROM retail_sales
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

---

### 📌 Sales on Specific Date

```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-22';
```

---

### 👕 Clothing Sales (Quantity > 3)

```sql
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND quantity > 3
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

---

### 💰 Total Sales by Category

```sql
SELECT 
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales 
GROUP BY category;
```

---

### 👩 Average Age (Beauty Category)

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales 
WHERE category = 'Beauty';
```

---

### 💸 High Value Transactions

```sql
SELECT *
FROM retail_sales 
WHERE total_sale > 1000;
```

---

### 👥 Transactions by Gender & Category

```sql
SELECT 
    gender, 
    category,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

---

### 📆 Monthly Average Sales

```sql
SELECT
YEAR(sale_date) AS year,
MONTH(sale_date) AS month, 
AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;
```

---

### 🏆 Best Selling Month Each Year

```sql
SELECT year, month, total_sales
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY SUM(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
WHERE rnk = 1;
```

---

### 🥇 Top 5 Customers

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 🛒 Unique Customers per Category

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

### ⏰ Sales by Shift

```sql
WITH hourly_sale AS (
SELECT *,
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;
```

---

## 📈 Key Insights

* Sales are distributed across multiple product categories
* High-value transactions (>1000) indicate premium customers
* Monthly trends highlight peak sales periods
* Customer segmentation helps identify top buyers

---

## ✅ Conclusion

This project provides a strong foundation in SQL by covering:

* Database design
* Data cleaning
* Data analysis
* Business insights generation

---

## 🚀 How to Use

1. Clone the repository
2. Run the SQL script to create database & table
3. Import dataset
4. Execute queries for insights

---

## 👨‍💻 Author

**Aman Saini**
