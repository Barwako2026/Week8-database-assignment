CREATE INDEX idx_app_users_tenant_id
    ON app_users (tenant_id);

CREATE INDEX idx_products_tenant_id
    ON products (tenant_id);

CREATE INDEX idx_products_tenant_active
    ON products (tenant_id, is_active);

CREATE INDEX idx_products_tenant_price
    ON products (tenant_id, price);

CREATE INDEX idx_orders_tenant_created
    ON orders (tenant_id, created_at DESC);

CREATE INDEX idx_orders_tenant_status
    ON orders (tenant_id, status);

CREATE INDEX idx_orders_tenant_user
    ON orders (tenant_id, user_id);

CREATE INDEX idx_order_items_tenant_order
    ON order_items (tenant_id, order_id);

CREATE INDEX idx_order_items_tenant_product
    ON order_items (tenant_id, product_id);
