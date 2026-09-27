# Database Security

## 1. Least-Privilege Roles

The database uses two application roles:

- `app_read` — read-only access
- `app_write` — read and write access to application tables

The application should use the least-privileged role required for each operation.

## 2. Row-Level Security

Row-Level Security (RLS) is enabled on tenant-owned tables:

- `app_users`
- `products`
- `orders`
- `order_items`
- `audit_log`

Tenant access is controlled using:

```sql
current_setting('app.tenant_id', true)
