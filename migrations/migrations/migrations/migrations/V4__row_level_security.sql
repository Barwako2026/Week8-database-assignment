DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = 'app_read'
    ) THEN
        CREATE ROLE app_read NOLOGIN;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = 'app_write'
    ) THEN
        CREATE ROLE app_write NOLOGIN;
    END IF;
END
$$;

GRANT USAGE ON SCHEMA public
TO app_read, app_write;

GRANT SELECT
ON tenants, app_users, products, orders, order_items, audit_log
TO app_read;

GRANT SELECT, INSERT, UPDATE, DELETE
ON tenants, app_users, products, orders, order_items
TO app_write;

GRANT SELECT
ON audit_log
TO app_write;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO app_write;

ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_users FORCE ROW LEVEL SECURITY;
ALTER TABLE products FORCE ROW LEVEL SECURITY;
ALTER TABLE orders FORCE ROW LEVEL SECURITY;
ALTER TABLE order_items FORCE ROW LEVEL SECURITY;
ALTER TABLE audit_log FORCE ROW LEVEL SECURITY;

CREATE POLICY app_users_tenant_policy
ON app_users
FOR ALL
TO app_read, app_write
USING (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
)
WITH CHECK (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
);

CREATE POLICY products_tenant_policy
ON products
FOR ALL
TO app_read, app_write
USING (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
)
WITH CHECK (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
);

CREATE POLICY orders_tenant_policy
ON orders
FOR ALL
TO app_read, app_write
USING (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
)
WITH CHECK (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
);

CREATE POLICY order_items_tenant_policy
ON order_items
FOR ALL
TO app_read, app_write
USING (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
)
WITH CHECK (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
);

CREATE POLICY audit_log_tenant_policy
ON audit_log
FOR SELECT
TO app_read, app_write
USING (
    tenant_id =
    current_setting('app.tenant_id', true)::BIGINT
);
