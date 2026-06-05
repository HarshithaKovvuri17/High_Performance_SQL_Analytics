# Testing & Verification Guide (PowerShell)

All commands are for **Windows PowerShell**. Run from project root: `D:\GPP\High_Performance_SQL_Analytics\`

---

## 1. Start the Container (Req 12)

```powershell
docker-compose up -d
docker-compose ps
```

---

## 2. Verify Schema (Req 1)

```powershell
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "\d users"
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "\d orders"
```

---

## 3. Verify Row Counts (Req 2)

```powershell
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "SELECT count(*) FROM users; SELECT count(*) FROM orders;"
```

---

## 4. Run All 10 Query Variants (Req 3–7)

```powershell
# Query 1: Rolling Revenue
Get-Content queries/window_q1.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
Get-Content queries/cte_q1.sql   | docker exec -i sql_analytics_db psql -U postgres -d analytics_db

# Query 2: Cohort Spending Ranks
Get-Content queries/window_q2.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
Get-Content queries/cte_q2.sql   | docker exec -i sql_analytics_db psql -U postgres -d analytics_db

# Query 3: Extreme Orders
Get-Content queries/window_q3.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
Get-Content queries/cte_q3.sql   | docker exec -i sql_analytics_db psql -U postgres -d analytics_db

# Query 4: Customer Churn Risk
Get-Content queries/window_q4.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
Get-Content queries/cte_q4.sql   | docker exec -i sql_analytics_db psql -U postgres -d analytics_db

# Query 5: Revenue Contribution
Get-Content queries/window_q5.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
Get-Content queries/cte_q5.sql   | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
```

---

## 5. Recursive Referrals Query (Req 8)

```powershell
Get-Content queries/recursive_referrals.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db
```

---

## 6. Create & Verify Materialized View (Req 9)

```powershell
# Create the materialized view
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "CREATE MATERIALIZED VIEW IF NOT EXISTS daily_revenue_stats AS SELECT created_at::date AS revenue_date, SUM(amount) AS total_revenue, COUNT(*) AS total_orders, AVG(amount) AS avg_order_value FROM orders WHERE status = 'COMPLETED' GROUP BY created_at::date ORDER BY revenue_date;"

# Verify the materialized view exists
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "SELECT count(*) FROM pg_matviews WHERE matviewname = 'daily_revenue_stats';"

# Query the materialized view to confirm data
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "SELECT * FROM daily_revenue_stats LIMIT 5;"

# Test refresh capability
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "REFRESH MATERIALIZED VIEW daily_revenue_stats;"
```

---

## 7. Create & Verify Indexes (Req 10)

```powershell
# Create B-Tree indexes
Get-Content queries/create_indexes.sql | docker exec -i sql_analytics_db psql -U postgres -d analytics_db

# Verify indexes exist
docker exec -i sql_analytics_db psql -U postgres -d analytics_db -c "SELECT indexname, tablename FROM pg_indexes WHERE indexname IN ('idx_orders_user_created', 'idx_users_cohort');"
```

---

## 8. Run Benchmark Suite & Verify Results (Req 11)

```powershell
# Run the full automated benchmark (EXPLAIN plans + pgbench)
python benchmark.py

# Verify benchmarks.json was generated
Get-Content results/benchmarks.json
```
