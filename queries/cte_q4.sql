-- Query 4: Customer Churn Risk (CTE Version)
-- Identify users who are 'At Risk'.
-- A user is at risk if their order count in the last 30 days is lower than their order count in the 30-day period prior to that.
WITH orders_last_30d AS (
    SELECT
        user_id,
        COUNT(*)::int AS orders_last_30d
    FROM orders
    WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '30 days'
    GROUP BY user_id
),
orders_prev_30d AS (
    SELECT
        user_id,
        COUNT(*)::int AS orders_prev_30d
    FROM orders
    WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '60 days'
      AND created_at < CURRENT_TIMESTAMP - INTERVAL '30 days'
    GROUP BY user_id
),
all_active_users AS (
    SELECT user_id FROM orders_last_30d
    UNION
    SELECT user_id FROM orders_prev_30d
)
SELECT
    u.user_id,
    COALESCE(l.orders_last_30d, 0) AS orders_last_30d,
    COALESCE(p.orders_prev_30d, 0) AS orders_prev_30d
FROM all_active_users u
LEFT JOIN orders_last_30d l ON u.user_id = l.user_id
LEFT JOIN orders_prev_30d p ON u.user_id = p.user_id
WHERE COALESCE(l.orders_last_30d, 0) < COALESCE(p.orders_prev_30d, 0)
ORDER BY u.user_id ASC;
