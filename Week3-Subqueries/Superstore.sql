CREATE DATABASE superstore;
USE superstore;

CREATE TABLE customers AS
SELECT DISTINCT
Customer_ID,
Customer_Name,
Segment,
Country,
City,
State,
Postal_Code,
Region
FROM superstore_raw;

CREATE TABLE products AS
SELECT DISTINCT
Product_ID,
Product_Name,
Category,
Sub_Category
FROM superstore_raw;

CREATE TABLE orders AS
SELECT DISTINCT
Row_ID,
Order_ID,
Order_Date,
Ship_Date,
Ship_Mode,
Customer_ID,
Product_ID,
Sales,
Quantity,
Discount,
Profit
FROM superstore_raw;

ALTER TABLE orders
ADD PRIMARY KEY (Row_ID);

-- STEP 2

-- Q1 Find all orders where sales are greater than the average sales. (Subquery)  
SELECT *
FROM orders
WHERE Sales > (SELECT AVG(Sales) FROM orders);

-- Q2 Find the highest sales order for each customer. (Subquery)  
SELECT *
FROM orders o
WHERE Sales = (SELECT MAX(os.Sales) FROM orders os WHERE os.Customer_ID = o.Customer_ID);

-- Q3 Calculate total sales for each customer. (CTE)  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales 
FROM orders 
GROUP BY Customer_ID)

SELECT *
FROM CustomerSales;

-- Q4 Find customers whose total sales are above average. (CTE + Subquery)  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT *
FROM CustomerSales
WHERE Total_Sales > (SELECT AVG(Total_Sales) FROM CustomerSales);

-- Q5 Rank all customers based on total sales. (Window Function)  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT Customer_ID, Total_Sales, RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM CustomerSales;

-- Q6 Assign row numbers to each order within a customer. (Window Function + PARTITION BY)  
SELECT Customer_ID, Order_ID, Sales, 
ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Sales DESC) AS Row_Num
FROM orders;

-- Q7 Display top 3 customers based on total sales. (Window Function)  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID),

RankedCustomers AS (SELECT Customer_ID, Total_Sales,
RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM CustomerSales)

SELECT *
FROM RankedCustomers
WHERE Sales_Rank <= 3;

-- STEP 3 
-- Final Combined Query (JOIN + CTE + Window Function) 

WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT c.Customer_Name, cs.Total_Sales,
RANK() OVER (ORDER BY cs.Total_Sales DESC) AS Sales_Rank
FROM CustomerSales cs
JOIN customers c
ON cs.Customer_ID = c.Customer_ID;

-- Mini Project: Customer Sales Insights 

-- Q1 Who are the top 5 customers?  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC
LIMIT 5;

-- Q2 Who are the bottom 5 customers?  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT *
FROM CustomerSales
ORDER BY Total_Sales ASC
LIMIT 5;

-- Q3 Which customers made only one order?  
SELECT Customer_ID, COUNT(DISTINCT Order_ID) AS Order_Count
FROM orders
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Order_ID) = 1;

-- Q4 Which customers have above-average sales?  
WITH CustomerSales AS (SELECT Customer_ID, SUM(Sales) AS Total_Sales
FROM orders
GROUP BY Customer_ID)

SELECT *
FROM CustomerSales
WHERE Total_Sales > (SELECT AVG(Total_Sales) FROM CustomerSales);

-- Q5 What is the highest order value per customer? 
SELECT Customer_ID, MAX(Sales) AS Highest_Order_Value
FROM orders
GROUP BY Customer_ID;
