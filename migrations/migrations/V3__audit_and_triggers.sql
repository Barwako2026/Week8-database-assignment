CREATE TABLE audit_log (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tenant_id BIGINT,
    table_name TEXT NOT NULL,
    operation TEXT NOT NULL,
    old_row JSONB,
    new_row JSONB,
    changed_by TEXT NOT NULL DEFAULT current_user,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_audit_log_tenant_changed
    ON audit_log (tenant_id, changed_at DESC);

CREATE OR REPLACE FUNCTION audit_row_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_tenant_id BIGINT;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_tenant_id := (to_jsonb(OLD)->>'tenant_id')::BIGINT;
    ELSE
        v_tenant_id := (to_jsonb(NEW)->>'tenant_id')::BIGINT;
    END IF;

    INSERT INTO audit_log (
        tenant_id,
        table_name,
        operation,
        old_row,
        new_row
    )
    VALUES (
        v_tenant_id,
        TG_TABLE_NAME,
        TG_OP,
        CASE
            WHEN TG_OP IN ('UPDATE', 'DELETE')
            THEN to_jsonb(OLD)
            ELSE NULL
        END,
        CASE
            WHEN TG_OP IN ('INSERT', 'UPDATE')
            THEN to_jsonb(NEW)
            ELSE NULL
        END
    );

    RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE TRIGGER trg_products_audit
AFTER INSERT OR UPDATE OR DELETE
ON products
FOR EACH ROW
EXECUTE FUNCTION audit_row_change();

CREATE TRIGGER trg_orders_audit
AFTER INSERT OR UPDATE OR DELETE
ON orders
FOR EACH ROW
EXECUTE FUNCTION audit_row_change();

CREATE TRIGGER trg_order_items_audit
AFTER INSERT OR UPDATE OR DELETE
ON order_items
FOR EACH ROW
EXECUTE FUNCTION audit_row_change();

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_products_updated_at
BEFORE UPDATE
ON products
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
