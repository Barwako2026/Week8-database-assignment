EXPLAIN (ANALYZE, BUFFERS)
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


EXPLAIN (ANALYZE, BUFFERS)
SELECT
    id,
    name,
    price,
    stock_quantity
FROM products
WHERE tenant_id = 1
  AND is_active = TRUE
ORDER BY price DESC
LIMIT 50;


EXPLAIN (ANALYZE, BUFFERS)
SELECT
    oi.id,
    oi.quantity,
    oi.unit_price,
    oi.line_total,
    p.name
FROM order_items oi
JOIN products p
    ON p.id = oi.product_id
   AND p.tenant_id = oi.tenant_id
WHERE oi.tenant_id = 1
  AND oi.order_id = 1;
