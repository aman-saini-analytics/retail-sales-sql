Create database retail_sales;

USE retail_sales;
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT, 
    gender VARCHAR(10), 
    age INT,
    category VARCHAR(50),
    quantiy INT,
    price_per_unit Decimal(2,10),
    cogs Decimal(2,10),
    total_sale Decimal(2,10)
);

SELECT * FROM retail_sales;

ALTER TABLE retail_sales
MODIFY sale_date DATE;

ALTER TABLE retail_sales
MODIFY sale_time TIME;


-- DATA CLEANING 
SELECT * 
FROM retail_sales
WHERE transaction_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL
   OR cogs IS NULL 
   OR total_sales IS NULL;
   
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE :
SELECT COUNT(*) as total_sales from retail_sales;

-- HOW MANY CUSTOMERS WE HAVE :
SELECT COUNT(Distinct customer_id) as customers from retail_sales;

-- HOW MANY CATEGOGY WE HAVE :
SELECT COUNT(Distinct category) as category from retail_sales;

-- NAME OF DIFFERENT CATEGOGY WE HAVE :
SELECT DISTINCT category  as category from retail_sales;


-- Write a Sql query to retrieve all column for sales made between '2022-11-01' to '2022-11-30'.
SELECT * 
from retail_sales
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30';


-- Write a Sql query to retrieve all column for sales made on '2022-11-22'.
SELECT * 
from retail_sales
WHERE sale_date = '2022-11-22';


-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022:
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND quantity > 3
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';


-- Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT Category,
SUM(total_sale) as total_sales
FROM retail_sales 
Group by category


-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT
AVG(age) as Avg_age
FROM retail_sales 
WHERE category = 'Beauty';


-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_sales 
WHERE total_sale > '1000';


-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT Gender, 
	   Category,
count(*) as total_transanctions
FROM retail_sales
Group by 
Category,
Gender
Order by 1;


-- Write a SQL query to calculate the average sale for each month. 
SELECT
Year(sale_date) as year,
Month(sale_date) as month, 
AVG(total_sale) as avg_sale
FROM retail_sales
Group by Year(sale_date), Month(sale_date)
ORDER By year, Month;


-- Find out best selling month in each year:
SELECT year, month, total_sales
FROM (
SELECT 
YEAR(sale_date) AS year,
MONTH(sale_date) AS month,
SUM(total_sale) AS total_sales,
RANK() OVER (PARTITION BY YEAR(sale_date) 
ORDER BY SUM(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t
WHERE rnk = '1';


-- Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT 
customer_id,
sum(total_sale) as total_sales
FROM retail_sales
Group By customer_id
Order By total_sales desc
Limit 5;


-- Write a SQL query to find the number of unique customers who purchased items from each category:
Select
Category,
Count(distinct customer_id) as unique_Customer
From retail_sales
Group By category;


-- Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;










