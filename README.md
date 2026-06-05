# 🚀 High Performance SQL Analytics Benchmarking System

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

```text
High_Performance_SQL_Analytics/
│
├── data/
│   ├── users.csv
│   ├── orders.csv
│
├── sql/
│   ├── schema.sql
│   ├── load_data.sql
│   ├── create_indexes.sql
│   ├── window_queries.sql
│   ├── cte_queries.sql
│   ├── recursive_queries.sql
│
├── benchmarks/
│   ├── explain_analyze_results.sql
│   ├── pgbench_results.log
│   ├── benchmark_report.json
│
├── scripts/
│   ├── benchmark.py
│   ├── data_generator.py
│
├── docker-compose.yml
├── requirements.txt
├── README.md
└── .env
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
