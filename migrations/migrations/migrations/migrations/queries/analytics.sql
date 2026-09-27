SELECT
    tenant_id,
    COUNT(*) AS orders,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY tenant_id
ORDER BY revenue DESC;


SELECT
    tenant_id,
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*) AS order_count,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY tenant_id, DATE_TRUNC('month', created_at)
ORDER BY month DESC;


SELECT
    oi.tenant_id,
    oi.product_id,
    p.name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.line_total) AS revenue
FROM order_items oi
JOIN products p
    ON p.id = oi.product_id
   AND p.tenant_id = oi.tenant_id
GROUP BY oi.tenant_id, oi.product_id, p.name
ORDER BY revenue DESC;


SELECT
    tenant_id,
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY tenant_id, status
ORDER BY tenant_id, order_count DESC;
