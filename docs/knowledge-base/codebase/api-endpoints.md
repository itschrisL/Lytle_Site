---
title: API Endpoints
aliases:
  - REST Routes
  - API Reference
tags:
  - api
  - backend
  - codebase
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[architecture]]"
  - "[[data-flow-maps]]"
  - "[[../backend/index]]"
  - "[[../backend/utils/email]]"
---

# API Endpoints

All REST routes exposed by the FastAPI backend. Every route is prefixed `/api` via `app.include_router(..., prefix="/api")` in `create_app()`.

---

## Route Table

| Method | Path | Auth Required | Handler | Description |
|--------|------|:---:|---------|-------------|
| GET | `/api/health` | No | `health_check` — `routers/health.py` | Liveness probe; returns `{"status":"ok"}` |
| POST | `/api/contact` | No | `submit_contact` — `routers/contact.py` | Validates payload, calls [[../backend/utils/email\|send_contact_email]], returns success message |

---

## POST `/api/contact`

### Request — `ContactRequest`

| Field | Type | Validation | Notes |
|-------|------|-----------|-------|
| `name` | `str` | Required | Sender display name |
| `email` | `EmailStr` | Required, valid RFC-5321 address | Validated by Pydantic `email-validator` |
| `message` | `str` | Required | Free-form message body |

### Response — `ContactResponse`

| Field | Type | Value on success |
|-------|------|-----------------|
| `message` | `str` | `"Message sent successfully."` |

### Error responses

| Status | Trigger |
|--------|---------|
| 422 Unprocessable Entity | Pydantic validation failure — bad email format or missing field |
| 500 Internal Server Error | SMTP exception — generic user message returned, full trace logged server-side |

---

## Interactive Docs

| URL | Available in |
|-----|-------------|
| `/api/docs` | Non-production (Swagger UI) |
| `/api/openapi.json` | Non-production (OpenAPI spec) |

---

## Open TODOs

- Rate limiting on `POST /api/contact` to prevent spam (Phase 3 in [[../../docs/TODO\|TODO]])
- `allowed_origins` in [[../backend/utils/config\|Settings]] must include production domain before launch
