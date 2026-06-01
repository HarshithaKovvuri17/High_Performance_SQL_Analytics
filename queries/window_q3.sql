-- Query 3: Extreme Orders (Window Function Version)
-- For every user, find their very first order and their very last order in a single query result.
-- Do not use self-joins.
WITH ranked_orders AS (
    SELECT
        user_id,
        created_at,
        amount,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at ASC, order_id ASC) AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC, order_id DESC) AS rn_last
    FROM orders
)
SELECT
    user_id,
    MAX(CASE WHEN rn_first = 1 THEN created_at END) AS first_order_date,
    MAX(CASE WHEN rn_last = 1 THEN created_at END) AS last_order_date,
    MAX(CASE WHEN rn_first = 1 THEN amount END)::numeric(14,2) AS first_order_amount,
    MAX(CASE WHEN rn_last = 1 THEN amount END)::numeric(14,2) AS last_order_amount
FROM ranked_orders
WHERE rn_first = 1 OR rn_last = 1
GROUP BY user_id
ORDER BY user_id ASC;
