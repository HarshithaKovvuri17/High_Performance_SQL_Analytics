# Index Impact Report: Query 1 (Window version)

This report details the execution performance impact of applying B-Tree indexes on Query 1 (7-day rolling revenue average) window function version.

## Query Execution Metrics

- **Database Environment**: PostgreSQL 16 (Docker container)
- **Table Seeding**: 200,000 users, 1,000,000 orders
- **Target Query**: `queries/window_q1.sql` (Window Function version)

| Metric | Value |
| :--- | :--- |
| **Execution Time BEFORE Indexes** | 8217.76 ms |
| **Execution Time AFTER Indexes** | 1395.19 ms |
| **Speedup Ratio (Before / After)** | 5.89x |

## Optimizer Plan Analysis

### Before Indexing (Baseline)
- The execution plan for `queries/window_q1.sql` performs a sequential scan (`Seq Scan`) on the `orders` table to compute the daily aggregates.
- To execute the window function, a sort node is required: `Sort (Key: created_at::date)`.
- Without an index, this sort overflows to disk if `work_mem` is exceeded (or is executed as an in-memory sort but requires a full scan and sort of 1M rows).

### After Indexing (Indexed)
- Once the B-Tree index on `orders(user_id, created_at)` and `users(cohort_month)` is created:
  - While Query 1 aggregates by `created_at::date` and does not partition by `user_id`, the index does not completely avoid the sort node since the grouping is on a cast expression `created_at::date`.
  - However, the index allows faster index-only scans or improved data fetching depending on the physical clustering and execution path.
  - The speedup ratio of **5.89x** demonstrates the performance improvement.

## Comprehensive Query Execution Performance Summary

| Query | Window Function (Indexed, ms) | CTE / Subquery (Indexed, ms) | WF Index Speedup Ratio |
| :--- | :---: | :---: | :---: |
| **Query 1: Rolling Revenue** | 1395.19 | 1599.31 | 5.89x |
| **Query 2: Cohort Ranks** | 3008.47 | 59503.77 | 0.97x |
| **Query 3: Extreme Orders** | 4543.94 | 2957.14 | 0.79x |
| **Query 4: Customer Churn** | 865.22 | 714.56 | 2.53x |
| **Query 5: Revenue Share** | 2553.19 | 3486.32 | 1.96x |

## pgbench Concurrency Load Test Results (Query 1)

- **Clients**: 10 concurrent clients
- **Threads**: 2
- **Duration**: 60 seconds

- **Window Function (WF) version**:
  - TPS: 2.90 tps
  - Average Latency: 3449.79 ms
- **CTE / Self-Join version**:
  - TPS: 3.93 tps
  - Average Latency: 2544.12 ms
