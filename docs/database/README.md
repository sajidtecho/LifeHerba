# Database Schema & Migrations

This directory hosts entity-relationship diagrams, schema configurations, and documentation regarding data storage strategies.

## Overview
- **Database Engine**: PostgreSQL
- **Schema Management**: Managed via Laravel Migrations.

## Core Schema Principles
- Use UUIDs (`uuid_generate_v4()`) for primary keys on all primary user-facing entities.
- Enforce soft-deletes (`deleted_at`) for patient, doctor, and consultation records.
- Index foreign key columns and fields used heavily in search operations (e.g., patient phone numbers, doctor specialization).

## Seeding & Development
To seed the database with synthetic data for local development:
```bash
php artisan db:seed
```
