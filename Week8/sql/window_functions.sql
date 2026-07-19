-- Rank Customers by Lifetime Value (RANK())
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)),2) AS lifetime_value,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

-- Dense Rank Customers (DENSE_RANK())
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)),2) AS lifetime_value,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) DESC
    ) AS dense_rank_customer
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

-- Running Total Revenue (SUM() OVER)
SELECT
    order_day,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_day
    ) AS running_total
FROM
(
    SELECT
        DATE(o.order_date) AS order_day,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS daily_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE(o.order_date)
) t
ORDER BY order_day;

-- Moving Average Revenue (AVG() OVER)
SELECT
    order_day,
    revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY order_day
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_average
FROM
(
    SELECT
        DATE(o.order_date) AS order_day,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE(o.order_date)
) t;

-- Monthly Revenue using CTE
WITH monthly_revenue AS
(
    SELECT
        DATE_FORMAT(order_date,'%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(order_date,'%Y-%m')
)

SELECT *
FROM monthly_revenue
ORDER BY month;

-- Monthly Growth Rate (CTE + LAG())
WITH monthly_revenue AS
(
    SELECT
        DATE_FORMAT(order_date,'%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(order_date,'%Y-%m')
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month,
    ROUND(
        (
            revenue - LAG(revenue) OVER (ORDER BY month)
        ) /
        LAG(revenue) OVER (ORDER BY month) * 100,
        2
    ) AS growth_percent
FROM monthly_revenue;

-- Row Number by Lifetime Value
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)),
        2
    ) AS lifetime_value,
    ROW_NUMBER() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) DESC
    ) AS row_num
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name;