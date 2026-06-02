-- Query 1: Rolling Revenue (CTE / Self-Join Version)
-- Calculate the 7-day rolling average revenue per calendar day for the last 90 days.
WITH daily_revenue AS (
    SELECT
        created_at::date AS day,
        SUM(amount) AS daily_revenue
    FROM orders
    GROUP BY created_at::date
),
rolling_calculations AS (
    SELECT
        d1.day,
        d1.daily_revenue,
        AVG(d2.daily_revenue) AS rolling_7d_avg
    FROM daily_revenue d1
    JOIN daily_revenue d2 ON d2.day BETWEEN d1.day - 6 AND d1.day
    GROUP BY d1.day, d1.daily_revenue
)
SELECT
    day,
    daily_revenue::numeric(14,2) AS daily_revenue,
    rolling_7d_avg::numeric(14,2) AS rolling_7d_avg
FROM rolling_calculations
WHERE day >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY day ASC;
