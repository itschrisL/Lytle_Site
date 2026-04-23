---
title: Backend Index
aliases:
  - FastAPI Hub
  - Backend Overview
tags:
  - backend
  - index
type: index
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../codebase/architecture]]"
  - "[[../codebase/api-endpoints]]"
  - "[[utils/email]]"
  - "[[utils/config]]"
---

# Backend Index

FastAPI service hub. Entry point: `backend/app/main.py` → `create_app()`.

---

## Subsystems

| Module | Path | Role |
|--------|------|------|
| App factory | `app/main.py` | Constructs `FastAPI` instance, registers middleware and routers |
| Configuration | `app/config.py` | [[utils/config\|Settings]] singleton via pydantic-settings |
| Health router | `app/routers/health.py` | `GET /api/health` liveness probe |
| Contact router | `app/routers/contact.py` | `POST /api/contact` form intake |
| Contact schema | `app/schemas/contact.py` | `ContactRequest` and `ContactResponse` Pydantic models |
| Email service | `app/services/email.py` | [[utils/email\|send_contact_email]] — SMTP with log fallback |

---

## App Factory Pattern

`create_app()` is called at module level (`app = create_app()`) so uvicorn can import the `app` object. The factory pattern keeps the app testable — tests import `app` from `app.main` directly via `ASGITransport`.

```python
# Startup sequence inside create_app():
FastAPI(title, version, docs_url, openapi_url)
  └─ CORSMiddleware(allow_origins=settings.allowed_origins, ...)
  └─ include_router(health.router, prefix="/api")
  └─ include_router(contact.router, prefix="/api")
```

---

## Dependency Map

```
main.py
  ├─ config.py (settings singleton)
  ├─ routers/health.py
  └─ routers/contact.py
       ├─ schemas/contact.py  (ContactRequest, ContactResponse)
       └─ services/email.py   (send_contact_email)
            └─ config.py      (smtp_host, smtp_port, smtp_user, ...)
```

---

## Testing

Tests use `httpx.AsyncClient` with `ASGITransport` — no live server required. `send_contact_email` is implicitly tested via the no-SMTP path (smtp_host empty → logs → returns without raising).

| Test | File |
|------|------|
| `test_health` | `tests/test_contact.py` |
| `test_contact_valid` | `tests/test_contact.py` |
| `test_contact_invalid_email` | `tests/test_contact.py` |

Run: `cd backend && pytest`

---

## Key Dependencies

| Package | Purpose |
|---------|---------|
| `fastapi>=0.115` | Web framework |
| `uvicorn[standard]` | ASGI server |
| `pydantic[email]>=2.9` | Request validation + `EmailStr` |
| `pydantic-settings>=2.6` | Settings from `.env` |
| `httpx` | Test client (ASGITransport) |
| `pytest-anyio` | Async test runner |
