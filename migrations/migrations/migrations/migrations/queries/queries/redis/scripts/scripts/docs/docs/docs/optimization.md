# Query Optimization Evidence

## Objective

The purpose of query optimization is to improve database performance by using appropriate indexes and verifying query execution with `EXPLAIN (ANALYZE, BUFFERS)`.

## Query 1: Recent Orders for a Tenant

### Query

```sql
SELECT
    id,
    order_number,
    status,
    total_amount,
    created_at
FROM orders
WHERE tenant_id = 1
ORDER BY created_at DESC
LIMIT 50;
