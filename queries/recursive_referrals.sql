-- Phase 4: Recursive Referrals Query
-- Find the complete referral chain depth for the top 100 users by order count (e.g., User A referred B, B referred C).
-- Return the user and their maximum referral depth.
WITH RECURSIVE top_100_users AS (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    ORDER BY COUNT(*) DESC, user_id ASC
    LIMIT 100
),
referral_chain AS (
    -- Anchor member: Start with each of the top 100 users
    SELECT
        t.user_id AS root_user_id,
        t.user_id AS current_user_id,
        1 AS depth
    FROM top_100_users t

    UNION ALL

    -- Recursive member: Find users referred by the current user
    SELECT
        rc.root_user_id,
        u.user_id AS current_user_id,
        rc.depth + 1 AS depth
    FROM referral_chain rc
    JOIN users u ON u.referred_by = rc.current_user_id
)
SELECT
    root_user_id AS user_id,
    MAX(depth)::int AS chain_depth
FROM referral_chain
GROUP BY root_user_id
ORDER BY chain_depth DESC, user_id ASC;
