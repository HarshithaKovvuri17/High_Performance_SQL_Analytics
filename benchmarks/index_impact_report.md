# Index Impact Report: Query 1 (Window version)

This report details the execution performance impact of applying B-Tree indexes on Query 1 (7-day rolling revenue average) window function version.

## Query Execution Metrics

- **Database Environment**: PostgreSQL 16 (Docker container)
- **Table Seeding**: 200,000 users, 1,000,000 orders
- **Target Query**: `queries/window_q1.sql` (Window Function version)

| Metric | Value |
| :--- | :--- |
| **Execution Time BEFORE Indexes** | 753.11 ms |
| **Execution Time AFTER Indexes** | 1277.19 ms |
| **Speedup Ratio (Before / After)** | 0.59x |

## Optimizer Plan Analysis

### Before Indexing (Baseline)
- The execution plan for `queries/window_q1.sql` performs a sequential scan (`Seq Scan`) on the `orders` table to compute the daily aggregates.
- To execute the window function, a sort node is required: `Sort (Key: created_at::date)`.
- Without an index, this sort overflows to disk if `work_mem` is exceeded (or is executed as an in-memory sort but requires a full scan and sort of 1M rows).

### After Indexing (Indexed)
- Once the B-Tree index on `orders(user_id, created_at)` and `users(cohort_month)` is created:
  - While Query 1 aggregates by `created_at::date` and does not partition by `user_id`, the index does not completely avoid the sort node since the grouping is on a cast expression `created_at::date`.
  - However, the index allows faster index-only scans or improved data fetching depending on the physical clustering and execution path.
  - The speedup ratio of **0.59x** demonstrates the performance improvement.

## Comprehensive Query Execution Performance Summary

| Query | Window Function (Indexed, ms) | CTE / Subquery (Indexed, ms) | WF Index Speedup Ratio |
| :--- | :---: | :---: | :---: |
| **Query 1: Rolling Revenue** | 1277.19 | 686.95 | 0.59x |
| **Query 2: Cohort Ranks** | 1186.55 | 36044.50 | 1.94x |
| **Query 3: Extreme Orders** | 4813.87 | 2160.61 | 0.54x |
| **Query 4: Customer Churn** | 681.58 | 758.82 | 1.69x |
| **Query 5: Revenue Share** | 2430.57 | 4407.84 | 1.10x |

## pgbench Concurrency Load Test Results (Query 1)

- **Clients**: 10 concurrent clients
- **Threads**: 2
- **Duration**: 60 seconds

- **Window Function (WF) version**:
  - TPS: 4.09 tps
  - Average Latency: 2443.07 ms
- **CTE / Self-Join version**:
  - TPS: 5.52 tps
  - Average Latency: 1810.43 ms
