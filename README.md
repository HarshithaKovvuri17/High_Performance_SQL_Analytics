# 🚀 High-Performance SQL Analytics: Benchmarking Window Functions and CTEs in PostgreSQL

## 📌 Project Overview

High Performance SQL Analytics is an advanced PostgreSQL-based benchmarking platform designed to evaluate and compare the performance of Window Functions and Common Table Expressions (CTEs) on large-scale datasets. The project simulates a real-world e-commerce environment containing 200,000 users, 1,000,000 orders, and a referral network hierarchy to perform advanced analytical queries and performance benchmarking.

The primary goal of this project is to analyze query execution efficiency, scalability, and optimization techniques using PostgreSQL performance tools such as EXPLAIN ANALYZE and pgbench.

---

# 🎯 Objectives

- Compare Window Functions and CTEs for analytical workloads.
- Generate large-scale realistic datasets.
- Perform advanced SQL analytics.
- Analyze query execution plans.
- Evaluate index effectiveness.
- Benchmark query performance under different scenarios.
- Demonstrate PostgreSQL optimization techniques.

---

# ✨ Features Implemented

## Data Generation
- Generated 200,000 Users
- Generated 1,000,000 Orders
- Created Referral Hierarchy Network
- Simulated Realistic User Cohorts
- Generated Large-Scale Analytical Dataset

## Advanced SQL Analytics
- Customer Ranking Analysis
- Rolling Revenue Analysis
- Revenue Contribution Analysis
- Customer Churn Detection
- Extreme Order Identification
- Cohort-Based Analytics
- Referral Tree Analysis

## Performance Optimization
- Window Function Benchmarking
- CTE Benchmarking
- Recursive Query Analysis
- Index Performance Evaluation
- Query Execution Plan Analysis
- Database Optimization Testing

## Benchmarking
- EXPLAIN ANALYZE
- pgbench Load Testing
- Query Execution Comparison
- Performance Report Generation

---

# 🏗️ System Architecture

```text
                         ┌────────────────────┐
                         │       User         │
                         └─────────┬──────────┘
                                   │
                                   ▼
                    ┌──────────────────────────┐
                    │ PostgreSQL 16 Database   │
                    └──────────┬───────────────┘
                               │
         ┌─────────────────────┼─────────────────────┐
         │                     │                     │
         ▼                     ▼                     ▼

    ┌───────────┐       ┌───────────┐       ┌───────────┐
    │  Users    │       │  Orders   │       │ Referrals │
    │  Table    │       │  Table    │       │ Hierarchy │
    └─────┬─────┘       └─────┬─────┘       └─────┬─────┘
          │                   │                   │
          └─────────┬─────────┴─────────┬─────────┘
                    ▼                   ▼

           ┌───────────────────────────────┐
           │ SQL Analytics Query Engine    │
           └───────────────┬───────────────┘
                           │
       ┌───────────────────┼───────────────────┐
       │                   │                   │
       ▼                   ▼                   ▼

 Window Functions        CTEs         Recursive Queries

                           │
                           ▼

                ┌────────────────────┐
                │ Benchmark Engine   │
                └─────────┬──────────┘
                          │
                          ▼

            EXPLAIN ANALYZE + pgbench

                          │
                          ▼

                Performance Reports
```

---

# 🗄️ Database Schema

## Users Table

| Column | Type |
|----------|----------|
| user_id | INT |
| email | VARCHAR |
| cohort_month | DATE |
| referred_by | INT |

## Orders Table

| Column | Type |
|----------|----------|
| order_id | UUID |
| user_id | INT |
| product_id | INT |
| amount | NUMERIC |
| status | VARCHAR |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |

---

# 📂 Complete Project Structure

```
High_Performance_SQL_Analytics/
│
├── .env
├── .env.example
│
├── docker-compose.yml
├── init.sql
├── benchmark.py
├── README.md
├── testing.md
├── results.json
│
├── queries/
│   ├── create_indexes.sql
│   │
│   ├── window_q1.sql
│   ├── window_q2.sql
│   ├── window_q3.sql
│   ├── window_q4.sql
│   ├── window_q5.sql
│   │
│   ├── cte_q1.sql
│   ├── cte_q2.sql
│   ├── cte_q3.sql
│   ├── cte_q4.sql
│   ├── cte_q5.sql
│   │
│   └── recursive_referrals.sql
│
├── benchmarks/
│   ├── wf_query_1_explain_baseline.txt
│   ├── wf_query_1_explain_indexed.txt
│   ├── wf_query_2_explain_baseline.txt
│   ├── wf_query_2_explain_indexed.txt
│   ├── wf_query_3_explain_baseline.txt
│   ├── wf_query_3_explain_indexed.txt
│   ├── wf_query_4_explain_baseline.txt
│   ├── wf_query_4_explain_indexed.txt
│   ├── wf_query_5_explain_baseline.txt
│   ├── wf_query_5_explain_indexed.txt
│   │
│   ├── cte_query_1_explain_baseline.txt
│   ├── cte_query_1_explain_indexed.txt
│   ├── cte_query_2_explain_baseline.txt
│   ├── cte_query_2_explain_indexed.txt
│   ├── cte_query_3_explain_baseline.txt
│   ├── cte_query_3_explain_indexed.txt
│   ├── cte_query_4_explain_baseline.txt
│   ├── cte_query_4_explain_indexed.txt
│   ├── cte_query_5_explain_baseline.txt
│   ├── cte_query_5_explain_indexed.txt
│   │
│   ├── pgbench_wf_query_1.log
│   ├── pgbench_wf_query_2.log
│   ├── pgbench_cte_query_1.log
│   ├── pgbench_cte_query_2.log
│   │
│   └── index_impact_report.md
│
└── results/
    └── benchmarks.json
```

---

# 💻 Tech Stack

### Database
- PostgreSQL 16

### Programming Language
- Python 3.x

### Performance Tools
- EXPLAIN ANALYZE
- pgbench

### Query Technologies
- Window Functions
- Common Table Expressions (CTEs)
- Recursive CTEs
- Materialized Views

### Containerization
- Docker
- Docker Compose

### Version Control
- Git
- GitHub

---

# 🔥 SQL Concepts Implemented

## Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- SUM() OVER()
- AVG() OVER()
- PARTITION BY
- ORDER BY

## Common Table Expressions (CTEs)
- Single CTE
- Multi-Level CTE
- Aggregation CTE
- Analytical CTE

## Recursive Queries
- Referral Tree Traversal
- Hierarchical Analysis
- Referral Depth Calculation

## Database Optimization
- Composite Indexing
- Query Optimization
- Execution Plan Analysis
- Materialized Views

---

# 📊 Benchmarking Process

### Step 1
Load large-scale dataset into PostgreSQL.

### Step 2
Execute analytical queries using Window Functions.

### Step 3
Execute equivalent queries using CTEs.

### Step 4
Analyze execution plans using EXPLAIN ANALYZE.

### Step 5
Create indexes and re-run benchmarks.

### Step 6
Measure execution time and resource utilization.

### Step 7
Generate performance reports.

---

# 🧪 Final Testing

## Functional Testing
- Database Creation ✅
- Users Table Creation ✅
- Orders Table Creation ✅
- Referral Hierarchy Creation ✅
- Data Loading ✅
- Query Execution ✅

## Performance Testing
- Window Function Benchmarking ✅
- CTE Benchmarking ✅
- Recursive Query Testing ✅
- Index Performance Testing ✅
- Execution Plan Analysis ✅

## Scalability Testing
- 200,000 Users Dataset ✅
- 1,000,000 Orders Dataset ✅
- Large Query Execution ✅
- Concurrent Benchmark Testing ✅

## Validation Results
- Queries executed successfully.
- Data integrity maintained.
- Benchmark reports generated.
- Indexes improved query performance.
- PostgreSQL handled large-scale analytics efficiently.

---

# 📈 Key Outcomes

- Compared Window Functions and CTEs using real benchmark results.
- Identified performance bottlenecks.
- Evaluated indexing strategies.
- Improved query execution speed.
- Demonstrated PostgreSQL optimization techniques.
- Built a scalable analytical benchmarking framework.

---

# 🎓 Learning Outcomes

This project demonstrates practical expertise in:

- PostgreSQL Database Management
- Advanced SQL Analytics
- Window Functions
- Common Table Expressions (CTEs)
- Recursive Queries
- Query Optimization
- Performance Engineering
- Database Benchmarking
- Large-Scale Data Processing
- Docker-Based Deployment

---

# 👨‍💻 Author

**Kovvuri Harshitha**
- Email: harshitahanisha@gmail.com
- Github Url: https://github.com/HarshithaKovvuri17/High_Performance_SQL_Analytics.git
