-- Query 2: Cohort Spending Ranks (CTE / Lateral Join Version)
-- Rank users by their total lifetime spend, but only within their signup-month cohort.
-- Return the Top 10 spenders for every cohort.
WITH user_spend AS (
    SELECT
        user_id,
        SUM(amount) AS total_spend
    FROM orders
    GROUP BY user_id
),
cohort_months AS (
    SELECT DISTINCT cohort_month
    FROM users
),
top_spenders AS (
    SELECT cm.cohort_month, l.user_id, l.total_spend
    FROM cohort_months cm
    CROSS JOIN LATERAL (
        SELECT u.user_id, s.total_spend
        FROM users u
        JOIN user_spend s ON u.user_id = s.user_id
        WHERE u.cohort_month = cm.cohort_month
        ORDER BY s.total_spend DESC
        LIMIT 10
    ) l
)
SELECT
    t1.cohort_month,
    t1.user_id,
    t1.total_spend::numeric(14,2) AS total_spend,
    (
        SELECT COUNT(DISTINCT t2.total_spend)
        FROM top_spenders t2
        WHERE t2.cohort_month = t1.cohort_month
          AND t2.total_spend > t1.total_spend
    )::int + 1 AS rank_in_cohort
FROM top_spenders t1
ORDER BY cohort_month ASC, rank_in_cohort ASC, user_id ASC;
