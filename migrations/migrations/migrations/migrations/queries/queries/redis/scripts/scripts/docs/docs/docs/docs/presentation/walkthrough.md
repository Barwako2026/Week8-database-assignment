# Database Capstone Final Walkthrough

## 1. Project Title

Multi-Tenant SaaS Order Management System

## 2. Project Objective

The project demonstrates the design and implementation of a secure, scalable database system for multiple businesses.

The system manages:

- Tenants
- Users
- Products
- Orders
- Order items
- Audit logs

PostgreSQL is the main source of truth, while Redis provides temporary shopping cart storage.

## 3. Technology Stack

- PostgreSQL
- Flyway
- Redis
- Python
- SQL
- GitHub

## 4. Database Design

The database contains the following main entities:

1. `tenants`
2. `app_users`
3. `products`
4. `orders`
5. `order_items`
6. `audit_log`

The ER diagram is available in:

```text
docs/er_diagram.dbml
