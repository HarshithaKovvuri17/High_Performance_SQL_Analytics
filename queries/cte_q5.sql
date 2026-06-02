-- Query 5: Revenue Contribution (CTE Version)
-- For every order, calculate its percentage contribution to that user's lifetime total spend.
WITH user_totals AS (
    SELECT
        user_id,
        SUM(amount) AS total_spend
    FROM orders
    GROUP BY user_id
)
SELECT
    o.order_id,
    o.user_id,
    o.amount::numeric(12,2) AS amount,
    ((o.amount / t.total_spend) * 100)::numeric(10,6) AS lifetime_share_pct
FROM orders o
JOIN user_totals t ON o.user_id = t.user_id
ORDER BY o.user_id ASC, o.order_id ASC;
