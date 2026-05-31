-- Enable uuid-ossp for UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    cohort_month DATE NOT NULL,
    referred_by INT REFERENCES users(user_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id INT REFERENCES users(user_id),
    product_id INT NOT NULL,
    amount NUMERIC CHECK (amount > 0),
    status VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Populate users table (200,000 rows)
INSERT INTO users (user_id, email, cohort_month, referred_by)
SELECT
  i AS user_id,
  'user_' || i || '@example.com' AS email,
  (date_trunc('month', CURRENT_DATE - (random() * 24 * 30 * interval '1 day')))::date AS cohort_month,
  CASE
    WHEN i > 1 AND random() < 0.3 THEN floor(random() * (i - 1))::int + 1
    ELSE NULL
  END AS referred_by
FROM generate_series(1, 200000) AS s(i);

-- Populate orders table (1,000,000 rows)
INSERT INTO orders (order_id, user_id, product_id, amount, status, created_at, updated_at)
SELECT
  gen_random_uuid() AS order_id,
  o.user_id,
  floor(random() * 1000)::int + 1 AS product_id,
  round((random() * 495 + 5)::numeric, 2) AS amount,
  (ARRAY['COMPLETED', 'PENDING', 'CANCELLED', 'SHIPPED'])[floor(random() * 4) + 1] AS status,
  o.order_date AS created_at,
  o.order_date AS updated_at
FROM (
  SELECT
    u_id AS user_id,
    u.cohort_month + (random() * (CURRENT_TIMESTAMP - u.cohort_month)) AS order_date
  FROM (
    SELECT floor(1 + 199999 * power(random(), 4.0))::int AS u_id
    FROM generate_series(1, 1000000)
  ) s
  JOIN users u ON u.user_id = s.u_id
) o;
