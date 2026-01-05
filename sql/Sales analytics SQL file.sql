CREATE TABLE sales (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state_ VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

SET datestyle = 'MDY';

COPY sales
FROM 'D:\Superstore.csv'
DELIMITER ','
CSV HEADER;

SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM sales;

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_orders,
    COUNT(*) FILTER (WHERE sales IS NULL) AS null_sales,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_qty
FROM sales;

SELECT
    COUNT(*) FILTER (WHERE sales <= 0) AS bad_sales,
    COUNT(*) FILTER (WHERE quantity <= 0) AS bad_qty
FROM sales;


SELECT ROUND(SUM(sales), 2) AS total_sales
FROM sales;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales;

SELECT 
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM sales;


SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(sales), 2) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY sub_category
ORDER BY total_sales DESC;

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales ASC
LIMIT 10;

SELECT
    category,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    region,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;

SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;


SELECT
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales;

SELECT
    discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales
GROUP BY discount
ORDER BY discount;

SELECT
    discount,
    ROUND(AVG(profit), 2) AS avg_profit
FROM sales
GROUP BY discount
ORDER BY discount;

SELECT
    order_id,
    ROUND(SUM(profit), 2) AS order_profit
FROM sales
GROUP BY order_id
HAVING SUM(profit) < 0
ORDER BY order_profit;








































