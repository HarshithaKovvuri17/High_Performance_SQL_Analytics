-- Query 4: Customer Churn Risk (Window Function Version)
-- Identify users who are 'At Risk'.
-- A user is at risk if their order count in the last 30 days is lower than their order count in the 30-day period prior to that.
WITH active_users AS (
    SELECT DISTINCT user_id
    FROM orders
    WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '60 days'
),
user_buckets AS (
    SELECT user_id, bucket_id
    FROM active_users
    CROSS JOIN (SELECT 1 AS bucket_id UNION ALL SELECT 2) b
),
orders_in_buckets AS (
    SELECT
        user_id,
        CASE
            WHEN created_at >= CURRENT_TIMESTAMP - INTERVAL '30 days' THEN 1
            ELSE 2
        END AS bucket_id,
        COUNT(*) AS order_count
    FROM orders
    WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '60 days'
    GROUP BY user_id, 2
),
densified_counts AS (
    SELECT
        ub.user_id,
        ub.bucket_id,
        COALESCE(o.order_count, 0) AS order_count
    FROM user_buckets ub
    LEFT JOIN orders_in_buckets o ON o.user_id = ub.user_id AND o.bucket_id = ub.bucket_id
),
lagged_counts AS (
    SELECT
        user_id,
        bucket_id,
        order_count,
        LAG(order_count, 1, 0) OVER (PARTITION BY user_id ORDER BY bucket_id DESC) AS prev_order_count
    FROM densified_counts
)
SELECT
    user_id,
    order_count::int AS orders_last_30d,
    prev_order_count::int AS orders_prev_30d
FROM lagged_counts
WHERE bucket_id = 1 AND order_count < prev_order_count
ORDER BY user_id ASC;
