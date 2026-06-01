-- Query 5: Revenue Contribution (Window Function Version)
-- For every order, calculate its percentage contribution to that user's lifetime total spend.
SELECT
    order_id,
    user_id,
    amount::numeric(12,2) AS amount,
    ((amount / SUM(amount) OVER (PARTITION BY user_id)) * 100)::numeric(10,6) AS lifetime_share_pct
FROM orders
ORDER BY user_id ASC, order_id ASC;
