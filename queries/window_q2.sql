-- Query 2: Cohort Spending Ranks (Window Function Version)
-- Rank users by their total lifetime spend, but only within their signup-month cohort.
-- Return the Top 10 spenders for every cohort.
WITH user_spend AS (
    SELECT
        user_id,
        SUM(amount) AS total_spend
    FROM orders
    GROUP BY user_id
),
cohort_spending AS (
    SELECT
        u.cohort_month,
        u.user_id,
        s.total_spend,
        DENSE_RANK() OVER (
            PARTITION BY u.cohort_month
            ORDER BY s.total_spend DESC
        ) AS rank_in_cohort
    FROM users u
    JOIN user_spend s ON u.user_id = s.user_id
)
SELECT
    cohort_month,
    user_id,
    total_spend::numeric(14,2) AS total_spend,
    rank_in_cohort::int AS rank_in_cohort
FROM cohort_spending
WHERE rank_in_cohort <= 10
ORDER BY cohort_month ASC, rank_in_cohort ASC, user_id ASC;
