---
title: email.py — Email Service
aliases:
  - send_contact_email
  - Email Module
tags:
  - backend
  - service
  - email
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../index]]"
  - "[[config]]"
  - "[[../../codebase/api-endpoints]]"
  - "[[../../codebase/data-flow-maps]]"
---

# email.py — Email Service

Handles contact-form email delivery via SMTP. Gracefully falls back to `logger.info` stdout logging when SMTP is not configured, so local development works without a mail server.

**File:** `backend/app/services/email.py`

---

## Function Inventory

| Name | Parameters | Returns | Description |
|------|-----------|---------|-------------|
| `send_contact_email` | `payload: ContactRequest` | `None` (async) | Sends a formatted email to `contact_recipient` or logs to stdout if `smtp_host` is empty |

---

## `send_contact_email` — Detail

| Aspect | Detail |
|--------|--------|
| Async | `async def` — awaitable but uses blocking `smtplib` internally (acceptable for low-volume personal site) |
| Subject | `f"New contact from {payload.name}"` |
| Body | Plain text: name, email, message |
| `From` | `settings.smtp_user` |
| `To` | `settings.contact_recipient` |
| `Reply-To` | `payload.email` — so replies go directly to the sender |
| SMTP security | `starttls()` — upgrades plain connection to TLS on port 587 |
| Fallback | If `settings.smtp_host` is falsy (empty string), logs body via `logger.info` and returns without raising |
| Error handling | Any `smtplib` exception propagates up to the router, which catches it and returns HTTP 500 |

---

## Dependencies

| Type | Name | Reason |
|------|------|--------|
| stdlib | `smtplib` | SMTP connection and send |
| stdlib | `email.message.EmailMessage` | RFC-compliant email construction |
| stdlib | `logging` | Stdout fallback log |
| internal | `app.config.settings` | SMTP credentials and recipient |
| internal | `app.schemas.contact.ContactRequest` | Type annotation for payload |

---

## Used By

| Caller | Path | How |
|--------|------|-----|
| `submit_contact` | `app/routers/contact.py` | `await send_contact_email(payload)` inside a try/except |

---

## Why blocking `smtplib`?

`smtplib` is synchronous. For a personal portfolio that receives low contact volume this is acceptable. If concurrency becomes a concern, replace with an async SMTP library (`aiosmtplib`) or an HTTP-based mail API (SendGrid, Resend) without changing the caller interface.

---

## Anti-Patterns

| ❌ Don't | ✅ Do instead |
|---------|-------------|
| `await smtplib_call()` | `smtplib` is blocking/sync — remove the `await`; the function is `async def` but internal calls are sync |
| Raise when `smtp_host` is empty | The log fallback is intentional for local dev — let it return silently |
| Store or cache the contact payload | Forward it to `contact_recipient` and discard — no PII retention |
| Catch `smtplib.SMTPException` and swallow silently | Let it propagate to the router, which returns HTTP 500 and preserves the error in logs |
