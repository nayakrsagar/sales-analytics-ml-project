SELECT
    customer_id,
    DATE_TRUNC('month', order_date) AS order_month
FROM sales
ORDER BY customer_id, order_month
LIMIT 10;

SELECT
    customer_id,
    MIN(DATE_TRUNC('month', order_date)) AS cohort_month
FROM sales
GROUP BY customer_id
ORDER BY customer_id
LIMIT 10;

SELECT
    s.customer_id,
    c.cohort_month,
    DATE_TRUNC('month', s.order_date) AS order_month
FROM sales s
JOIN (
    SELECT
        customer_id,
        MIN(DATE_TRUNC('month', order_date)) AS cohort_month
    FROM sales
    GROUP BY customer_id
) c
ON s.customer_id = c.customer_id
ORDER BY s.customer_id, order_month
LIMIT 15;

SELECT
    s.customer_id,
    c.cohort_month,
    DATE_TRUNC('month', s.order_date) AS order_month,
    (
        EXTRACT(YEAR FROM DATE_TRUNC('month', s.order_date)) -
        EXTRACT(YEAR FROM c.cohort_month)
    ) * 12 +
    (
        EXTRACT(MONTH FROM DATE_TRUNC('month', s.order_date)) -
        EXTRACT(MONTH FROM c.cohort_month)
    ) AS cohort_index
FROM sales s
JOIN (
    SELECT
        customer_id,
        MIN(DATE_TRUNC('month', order_date)) AS cohort_month
    FROM sales
    GROUP BY customer_id
) c
ON s.customer_id = c.customer_id
ORDER BY s.customer_id, order_month
LIMIT 20;



SELECT
    c.cohort_month,
    (
        EXTRACT(YEAR FROM DATE_TRUNC('month', s.order_date)) -
        EXTRACT(YEAR FROM c.cohort_month)
    ) * 12 +
    (
        EXTRACT(MONTH FROM DATE_TRUNC('month', s.order_date)) -
        EXTRACT(MONTH FROM c.cohort_month)
    ) AS cohort_index,
    COUNT(DISTINCT s.customer_id) AS customer_count
FROM sales s
JOIN (
    SELECT
        customer_id,
        MIN(DATE_TRUNC('month', order_date)) AS cohort_month
    FROM sales
    GROUP BY customer_id
) c
ON s.customer_id = c.customer_id
GROUP BY
    c.cohort_month,
    cohort_index
ORDER BY
    c.cohort_month,
    cohort_index;


SELECT
    cohort_month,
    cohort_index,
    customer_count,
    ROUND(
        customer_count * 100.0 /
        FIRST_VALUE(customer_count) OVER (
            PARTITION BY cohort_month
            ORDER BY cohort_index
        ),
        2
    ) AS retention_percentage
FROM (
    SELECT
        c.cohort_month,
        (
            EXTRACT(YEAR FROM DATE_TRUNC('month', s.order_date)) -
            EXTRACT(YEAR FROM c.cohort_month)
        ) * 12 +
        (
            EXTRACT(MONTH FROM DATE_TRUNC('month', s.order_date)) -
            EXTRACT(MONTH FROM c.cohort_month)
        ) AS cohort_index,
        COUNT(DISTINCT s.customer_id) AS customer_count
    FROM sales s
    JOIN (
        SELECT
            customer_id,
            MIN(DATE_TRUNC('month', order_date)) AS cohort_month
        FROM sales
        GROUP BY customer_id
    ) c
    ON s.customer_id = c.customer_id
    GROUP BY
        c.cohort_month,
        cohort_index
) t
ORDER BY
    cohort_month,
    cohort_index;


COPY (
    SELECT
        cohort_month,
        cohort_index,
        ROUND(
            customer_count * 100.0 /
            FIRST_VALUE(customer_count) OVER (
                PARTITION BY cohort_month
                ORDER BY cohort_index
            ),
            2
        ) AS retention_percentage
    FROM (
        SELECT
            c.cohort_month,
            (
                EXTRACT(YEAR FROM DATE_TRUNC('month', s.order_date)) -
                EXTRACT(YEAR FROM c.cohort_month)
            ) * 12 +
            (
                EXTRACT(MONTH FROM DATE_TRUNC('month', s.order_date)) -
                EXTRACT(MONTH FROM c.cohort_month)
            ) AS cohort_index,
            COUNT(DISTINCT s.customer_id) AS customer_count
        FROM sales s
        JOIN (
            SELECT
                customer_id,
                MIN(DATE_TRUNC('month', order_date)) AS cohort_month
            FROM sales
            GROUP BY customer_id
        ) c
        ON s.customer_id = c.customer_id
        GROUP BY
            c.cohort_month,
            cohort_index
    ) t
    ORDER BY cohort_month, cohort_index
)
TO 'D:/tableau/cohort_retention.csv'
DELIMITER ','
CSV HEADER;
