-- Query 1: Rolling Revenue (Window Function Version)
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
        day,
        daily_revenue,
        AVG(daily_revenue) OVER (
            ORDER BY day
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_7d_avg
    FROM daily_revenue
)
SELECT
    day,
    daily_revenue::numeric(14,2) AS daily_revenue,
    rolling_7d_avg::numeric(14,2) AS rolling_7d_avg
FROM rolling_calculations
WHERE day >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY day ASC;
