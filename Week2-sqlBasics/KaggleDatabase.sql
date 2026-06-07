CREATE DATABASE superstore_db;
USE superstore_db;

-- 1. Data Exploration

DESCRIBE superstore;

SELECT *
FROM superstore
LIMIT 5;

-- 2. WHERE Filters

-- data of west region
SELECT *
FROM superstore
WHERE Region = 'West';

-- data of office supplies category
SELECT *
FROM superstore
WHERE Category = 'Office Supplies';

-- data of year 2017
SELECT *
FROM superstore
WHERE STR_TO_DATE(Order_Date,'%m/%d/%Y')
BETWEEN '2017-01-01' AND '2017-12-31';

-- data where sales is between 500 and 1000
SELECT *
FROM superstore
WHERE Sales BETWEEN 500 AND 1000;

-- data of central region and technology category
SELECT *
FROM superstore
WHERE Region = 'Central' AND Category = 'Technology';

-- data of west or east region
SELECT *
FROM superstore
WHERE Region = 'West' OR Region = 'East';

-- data of west region and technology category where sales is greater than 1000
SELECT *
FROM superstore
WHERE Region = 'West' AND Category = 'Technology' AND Sales > 1000;

-- 3. Aggregations using Group By Filters

-- Total Sales
SELECT Category, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category;

-- Total Quantity
SELECT Category, SUM(Quantity) AS Total_Quantity
FROM superstore
GROUP BY Category;

-- Average Sales
SELECT Category, AVG(Sales) AS Avg_Sales
FROM superstore
GROUP BY Category;

-- Category wise total sales greater than 500000
SELECT Category, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 500000;

-- 4. Sorting and Limiting

-- Top Products
SELECT Product_Name, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top Categories
SELECT Category, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 5. Use Cases

-- Top Customers
SELECT Customer_Name, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Monthly Trend Sales
SELECT
	YEAR(STR_TO_DATE(Order_Date,'%m/%d/%Y')) AS Year_,
    MONTH(STR_TO_DATE(Order_Date,'%m/%d/%Y')) AS Month_,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Year_, Month_
ORDER BY Year_, Month_;

-- Duplicate Orders
SELECT Order_ID, COUNT(*) AS Cnt
FROM superstore
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- 6. Data Validation

SELECT COUNT(*) AS Total_Rows
FROM superstore;

SELECT COUNT(*) AS Null_Sales
FROM superstore
WHERE Sales IS NULL;

SELECT COUNT(*) AS Null_Customers
FROM superstore
WHERE Customer_Name IS NULL;
