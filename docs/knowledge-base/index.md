---
title: Knowledge Base Index
aliases:
  - Home
  - Catalog
tags:
  - index
  - meta
type: index
status: active
created: 2026-04-22
updated: 2026-04-22
related: []
---

# Knowledge Base Index

Top-level catalog for the Lytle Site monorepo.

---

## Codebase

| Page | Description |
|------|-------------|
| [[codebase/architecture\|Architecture]] | System components, responsibilities, and ASCII data-flow diagram |
| [[codebase/api-endpoints\|API Endpoints]] | All REST routes with method, path, handler, and auth status |
| [[codebase/database-schema\|Database Schema]] | Persistent data — static JSON content files and their shapes |
| [[codebase/authentication\|Authentication]] | Current auth posture (none) and what to add for future protected routes |
| [[codebase/data-flow-maps\|Data Flow Maps]] | End-to-end request traces for the two key user actions |

---

## Backend

| Page | Description |
|------|-------------|
| [[backend/index\|Backend Index]] | FastAPI service hub: subsystems, modules, and entry points |
| [[backend/utils/email\|email.py]] | SMTP email service with graceful local-dev log fallback |
| [[backend/utils/config\|config.py]] | Pydantic-settings configuration: env vars, types, and defaults |

---

## Frontend

| Page | Description |
|------|-------------|
| [[frontend/index\|Frontend Index]] | Nuxt 3 hub: routing, modules, runtime config, and app shell |
| [[frontend/stores\|Composables / State]] | All composables — state shape, return values, and side effects |
| [[frontend/components\|Components]] | Major components: props, emits, and composable dependencies |

---

## Decisions

| Page | Description |
|------|-------------|
| [[decisions/2026-04-22-initial-architecture\|2026-04-22 Initial Architecture]] | ADR: why Nuxt 3 + FastAPI was chosen |

---

## Troubleshooting

| Page | Description |
|------|-------------|
| [[troubleshooting/common-errors\|Common Errors]] | Five errors a new developer will hit first, with causes and fixes |
