---
title: config.py — Settings
aliases:
  - Settings
  - Configuration
  - Environment Variables
tags:
  - backend
  - config
  - environment
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../index]]"
  - "[[email]]"
  - "[[../../codebase/authentication]]"
---

# config.py — Settings

Single-source application configuration. Uses `pydantic-settings` to read env vars and `.env` file, providing typed defaults.

**File:** `backend/app/config.py`

---

## Settings Fields

| Field | Type | Default | Env Var | Notes |
|-------|------|---------|---------|-------|
| `allowed_origins` | `list[str]` | `["http://localhost:3000"]` | `ALLOWED_ORIGINS` | CORS allowed origins; **must** include prod frontend URL before launch |
| `smtp_host` | `str` | `""` (empty) | `SMTP_HOST` | Empty → email service logs to stdout instead of sending |
| `smtp_port` | `int` | `587` | `SMTP_PORT` | Standard STARTTLS port |
| `smtp_user` | `str` | `""` | `SMTP_USER` | SMTP login username (usually the sender email) |
| `smtp_password` | `str` | `""` | `SMTP_PASSWORD` | SMTP login password — **never hardcode; use .env** |
| `contact_recipient` | `str` | `""` | `CONTACT_RECIPIENT` | Email address that receives contact form submissions |

---

## Usage Pattern

`settings` is a module-level singleton. Import and use directly — never instantiate `Settings()` again:

```python
from app.config import settings

if not settings.smtp_host:
    ...
```

---

## Dependencies

| Type | Name | Reason |
|------|------|--------|
| third-party | `pydantic-settings` | Reads `.env` + environment variables into typed `BaseSettings` |

---

## Used By

| Caller | Path | Fields accessed |
|--------|------|----------------|
| `create_app` | `app/main.py` | `allowed_origins` |
| `send_contact_email` | `app/services/email.py` | `smtp_host`, `smtp_port`, `smtp_user`, `smtp_password`, `contact_recipient` |

---

## Local Setup

Copy `.env.example` to `.env` and fill in values. SMTP fields are optional — omitting them enables the log-fallback mode in [[email\|email.py]]:

```bash
cp .env.example .env
# SMTP fields optional for local dev — backend logs submissions to stdout
```
