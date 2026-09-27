# Database Capstone Requirements

## Project Title

Multi-Tenant SaaS Order Management System

## Project Overview

This project is a multi-tenant order management system designed for businesses that need to manage users, products, orders, and order items securely.

PostgreSQL is used as the main relational database because it provides strong data integrity, transactions, indexing, security, and reporting capabilities.

Redis is used for temporary shopping cart data because cart information can be accessed quickly and can expire automatically.

## Functional Requirements

### 1. Tenant Management

- The system shall support multiple businesses (tenants).
- Each tenant shall have a unique ID and name.
- Tenant data must remain isolated from other tenants.

### 2. User Management

- The system shall store users belonging to each tenant.
- Users shall have a name, hashed email, role, and creation date.
- Supported roles are administrator, manager, and user.

### 3. Product Management

- Users shall be able to manage products.
- Products shall contain a name, description, price, stock quantity, and active status.
- Product prices and stock quantities cannot be negative.

### 4. Order Management

- Users shall be able to create and manage orders.
- Each order belongs to a tenant and a user.
- Orders shall have an order number, status, total amount, and creation date.
- Supported order statuses include pending, paid, shipped, completed, and cancelled.

### 5. Order Items

- Each order can contain multiple products.
- Order items shall store quantity, unit price, and line total.
- An order item must belong to the same tenant as its order.

### 6. Audit Logging

- Important changes to products, orders, and order items shall be recorded.
- The audit log shall store the operation, old data, new data, user, and timestamp.

### 7. Security

- The database shall use role-based permissions.
- Row-Level Security (RLS) shall restrict users to their own tenant data.
- Sensitive email information shall be stored as a SHA-256 hash.
- Database credentials and secrets shall not be committed to GitHub.

### 8. Performance

- Indexes shall be created for common tenant-based queries.
- Query performance shall be evaluated using `EXPLAIN ANALYZE`.
- Query optimization results shall be documented.

### 9. Redis

- Redis shall store temporary shopping cart information.
- Cart data shall use a 24-hour expiration time.
- PostgreSQL shall remain the source of truth for completed orders.

### 10. Backup and Recovery

- The database shall support PostgreSQL backups using `pg_dump`.
- Backup restoration shall be tested using `pg_restore`.
- Backup and restore procedures shall be documented.

## Non-Functional Requirements

- The system should provide tenant data isolation.
- Database operations should maintain data integrity.
- Common queries should be optimized with appropriate indexes.
- The project should use version-controlled database migrations.
- The project should be reproducible from an empty database using Flyway migrations.
- The project documentation should explain the database design, security, optimization, and recovery approach.

## Technology Stack

- PostgreSQL
- Flyway
- Redis
- Python
- SQL
- Git and GitHub

## Main Deliverables

1. Requirements summary
2. ER diagram
3. Versioned database migrations
4. Indexes and query optimization
5. Redis integration
6. Audit logging and security
7. Backup and restore scripts
8. Project documentation
9. Final project walkthrough
