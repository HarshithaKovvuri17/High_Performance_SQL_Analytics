-- Create indexes to optimize Window Functions and CTEs sorting and partitioning
CREATE INDEX IF NOT EXISTS idx_orders_user_created ON orders(user_id, created_at);
CREATE INDEX IF NOT EXISTS idx_users_cohort ON users(cohort_month);
