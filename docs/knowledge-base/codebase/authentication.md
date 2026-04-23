---
title: Authentication
aliases:
  - Auth Flow
  - Security
tags:
  - authentication
  - security
  - codebase
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[api-endpoints]]"
  - "[[architecture]]"
  - "[[../backend/index]]"
---

# Authentication

## Current State

**There is no authentication.** All API routes are fully public. The site is a read-only portfolio with a single write action (contact form submission) that requires no identity.

---

## Middleware in Place

| Middleware | Where registered | Purpose |
|-----------|-----------------|---------|
| `CORSMiddleware` | `app/main.py` `create_app()` | Restricts cross-origin requests to `allowed_origins` from [[../backend/utils/config\|Settings]] |

No authentication decorators, no token validation, no role checks exist anywhere in the codebase.

---

## CORS as a Lightweight Guard

CORS is not authentication — it is a browser-enforced origin filter. It prevents arbitrary web pages from calling the API in a browser context but does **not** prevent direct `curl` or server-to-server requests.

| Setting | Value in dev | Value needed in prod |
|---------|-------------|---------------------|
| `allowed_origins` | `["http://localhost:3000"]` | Production frontend URL (e.g. `https://chrislytle.dev`) |

---

## If Authentication Is Added Later

Recommended path for protecting future admin or write routes:

| Step | Implementation |
|------|---------------|
| Token issuance | Add `POST /api/auth/login` → return a signed JWT |
| Token validation | `fastapi.security.HTTPBearer` + custom `Depends(verify_token)` dependency |
| Role check | Embed `role` claim in JWT payload; check in route dependency |
| Middleware | `fastapi.middleware` or a route-level `Depends` — not global middleware, to keep public routes free |

No code changes are needed today. This section documents the constraint so future developers understand the current posture.

---

## Anti-Patterns

| ❌ Don't | ✅ Do instead |
|---------|-------------|
| Add `Depends(verify_token)` to existing routes without updating this file | Update this doc to reflect the new auth posture before the PR merges |
| Use `allow_origins=["*"]` in `CORSMiddleware` | Always specify explicit origins — wildcard is only safe for fully public, read-only resources |
| Add auth in global middleware that runs on every request | Use route-level `Depends` so public routes (health, contact form) remain unaffected |
| Hardcode a token or secret in source code | Store in `.env` and access via `settings` — see [[../backend/utils/config\|config.md]] |
