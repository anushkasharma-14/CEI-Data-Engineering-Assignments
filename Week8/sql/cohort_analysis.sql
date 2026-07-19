-- Customer Cohort (First Purchase Month)

SELECT
    customer_id,
    DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
FROM orders
GROUP BY customer_id
ORDER BY cohort_month;

-- Monthly Retention

WITH customer_cohort AS
(
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
)

SELECT
    cc.cohort_month,
    DATE_FORMAT(o.order_date,'%Y-%m') AS active_month,
    COUNT(DISTINCT o.customer_id) AS retained_customers
FROM customer_cohort cc
JOIN orders o
ON cc.customer_id = o.customer_id
GROUP BY
    cc.cohort_month,
    active_month
ORDER BY
    cohort_month,
    active_month;
    
-- Customers who purchased only once

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1;

-- Customers with more than one order

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Purchase Frequency Segmentation

SELECT
    customer_id,
    COUNT(order_id) AS total_orders,

    CASE
        WHEN COUNT(order_id)=1
            THEN 'One-Time'
        WHEN COUNT(order_id) BETWEEN 2 AND 5
            THEN 'Occasional'
        ELSE 'Loyal'
    END AS customer_segment
    
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- Spend Tier Segmentation

SELECT
    c.customer_id,
    c.customer_name,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1-oi.discount_percent/100)
        ),
        2
    ) AS total_spend,

    CASE
        WHEN SUM(
            oi.quantity *
            oi.unit_price *
            (1-oi.discount_percent/100)
        ) <50000
            THEN 'Low'

        WHEN SUM(
            oi.quantity *
            oi.unit_price *
            (1-oi.discount_percent/100)
        ) <150000
            THEN 'Medium'

        ELSE 'High'
    END AS spend_tier
    
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id

JOIN order_items oi
ON o.order_id=oi.order_id

GROUP BY
c.customer_id,
c.customer_name

ORDER BY total_spend DESC;

-- RFM Analysis

SELECT

    c.customer_id,

    c.customer_name,

    DATEDIFF(
        CURDATE(),
        MAX(o.order_date)
    ) AS Recency,

    COUNT(DISTINCT o.order_id) AS Frequency,

    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1-oi.discount_percent/100)
        ),
        2
    ) AS Monetary

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN order_items oi
ON o.order_id=oi.order_id

GROUP BY
c.customer_id,
c.customer_name

ORDER BY Monetary DESC;