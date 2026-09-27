CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO tenants (name)
VALUES
    ('Demo Electronics Ltd'),
    ('Demo Fashion Ltd');

INSERT INTO app_users (
    tenant_id,
    full_name,
    email_hash,
    role
)
SELECT
    id,
    'Demo Administrator',
    encode(
        digest('admin@electronics.example', 'sha256'),
        'hex'
    ),
    'admin'
FROM tenants
WHERE name = 'Demo Electronics Ltd';

INSERT INTO app_users (
    tenant_id,
    full_name,
    email_hash,
    role
)
SELECT
    id,
    'Fashion Administrator',
    encode(
        digest('admin@fashion.example', 'sha256'),
        'hex'
    ),
    'admin'
FROM tenants
WHERE name = 'Demo Fashion Ltd';

INSERT INTO products (
    tenant_id,
    name,
    description,
    price,
    stock_quantity,
    is_active
)
SELECT
    id,
    'Laptop Pro 15',
    'Professional laptop',
    1299.99,
    50,
    TRUE
FROM tenants
WHERE name = 'Demo Electronics Ltd';

INSERT INTO products (
    tenant_id,
    name,
    description,
    price,
    stock_quantity,
    is_active
)
SELECT
    id,
    'Wireless Headphones',
    'Bluetooth headphones',
    149.99,
    100,
    TRUE
FROM tenants
WHERE name = 'Demo Electronics Ltd';

INSERT INTO products (
    tenant_id,
    name,
    description,
    price,
    stock_quantity,
    is_active
)
SELECT
    id,
    'Cotton T-Shirt',
    'Unisex cotton shirt',
    29.99,
    250,
    TRUE
FROM tenants
WHERE name = 'Demo Fashion Ltd';

INSERT INTO orders (
    tenant_id,
    user_id,
    order_number,
    status,
    total_amount
)
SELECT
    t.id,
    u.id,
    'ORD-10001',
    'paid',
    1449.98
FROM tenants t
JOIN app_users u
    ON u.tenant_id = t.id
WHERE t.name = 'Demo Electronics Ltd'
  AND u.role = 'admin'
LIMIT 1;

INSERT INTO order_items (
    tenant_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    line_total
)
SELECT
    o.tenant_id,
    o.id,
    p.id,
    1,
    p.price,
    p.price
FROM orders o
JOIN products p
    ON p.tenant_id = o.tenant_id
WHERE o.order_number = 'ORD-10001'
  AND p.name = 'Laptop Pro 15';

INSERT INTO order_items (
    tenant_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    line_total
)
SELECT
    o.tenant_id,
    o.id,
    p.id,
    1,
    p.price,
    p.price
FROM orders o
JOIN products p
    ON p.tenant_id = o.tenant_id
WHERE o.order_number = 'ORD-10001'
  AND p.name = 'Wireless Headphones';
