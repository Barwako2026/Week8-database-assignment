# Multi-Tenant SaaS Order Management System

A database capstone project demonstrating a secure, scalable, multi-tenant order management system using PostgreSQL, Flyway, Redis, and Python.

## Project Overview

This system supports multiple business tenants that manage:

- Users
- Products
- Customer orders
- Order items
- Audit records
- Temporary shopping carts

PostgreSQL is the primary source of truth for permanent business data. Redis is used for temporary shopping cart storage with a 24-hour expiration.

## Technology Stack

- PostgreSQL
- Flyway
- Redis
- Python
- SQL
- Git/GitHub
- dbdiagram.io

## Repository Structure

```text
Week8-database-assignment/
├── migrations/
│   ├── V1__core_tables.sql
│   ├── V2__indexes.sql
│   ├── V3__audit_and_triggers.sql
│   ├── V4__row_level_security.sql
│   └── V5__seed_demo_data.sql
├── queries/
│   ├── analytics.sql
│   └── optimization.sql
├── redis/
│   ├── cart_example.py
│   └── requirements.txt
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── docs/
│   ├── requirements.md
│   ├── er_diagram.dbml
│   ├── optimization.md
│   └── security.md
├── presentation/
│   └── walkthrough.md
├── flyway.toml
├── README.md
└── .gitignore
