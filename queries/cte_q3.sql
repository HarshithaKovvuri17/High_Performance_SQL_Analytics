-- Query 3: Extreme Orders (CTE / Array Aggregation Version)
-- For every user, find their very first order and their very last order in a single query result.
-- Do not use self-joins.
WITH ordered_order_arrays AS (
    SELECT
        user_id,
        array_agg(created_at ORDER BY created_at ASC, order_id ASC) AS order_dates,
        array_agg(amount ORDER BY created_at ASC, order_id ASC) AS order_amounts
    FROM orders
    GROUP BY user_id
)
SELECT
    user_id,
    order_dates[1] AS first_order_date,
    order_dates[cardinality(order_dates)] AS last_order_date,
    order_amounts[1]::numeric(14,2) AS first_order_amount,
    order_amounts[cardinality(order_amounts)]::numeric(14,2) AS last_order_amount
FROM ordered_order_arrays
ORDER BY user_id ASC;
