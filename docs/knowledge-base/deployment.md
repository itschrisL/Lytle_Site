---
title: Deployment
aliases:
  - Deploy Guide
  - Production Setup
tags:
  - deployment
  - production
  - security
  - devops
type: reference
status: active
created: 2026-04-23
updated: 2026-04-23
related:
  - "[[codebase/architecture]]"
  - "[[codebase/authentication]]"
  - "[[backend/utils/config]]"
---

# Deployment

The site deploys as two independent services: a static frontend and a small API backend.

---

## Overview

| Service | Recommended Host | Cost | HTTPS |
|---------|-----------------|------|-------|
| Frontend (Nuxt 3 static) | Vercel or Netlify | Free | Automatic |
| Backend (FastAPI) | Railway or Render | Free tier available | Automatic |

The frontend generates a fully static site (`nuxt generate`) — no server needed. The backend runs as a single Python process.

---

## Frontend Deployment (Vercel / Netlify)

1. Push the repo to GitHub.
2. Connect the repo to [Vercel](https://vercel.com) or [Netlify](https://netlify.com).
3. Set **root directory** to `frontend/`.
4. Set **build command** to `npm run generate`.
5. Set **output directory** to `.output/public`.
6. Add the environment variable:

   | Variable | Value |
   |----------|-------|
   | `NUXT_PUBLIC_API_BASE` | `https://your-backend-url.com` |

The `NUXT_PUBLIC_API_BASE` value is consumed by `runtimeConfig.public.apiBase` in `nuxt.config.ts` and drives all API calls from `useContactForm`.

---

## Backend Deployment (Railway / Render)

1. Connect the repo to [Railway](https://railway.app) or [Render](https://render.com).
2. Set **root directory** to `backend/`.
3. Set **start command** to:
   ```
   uvicorn app.main:app --host 0.0.0.0 --port $PORT
   ```
4. Set all environment variables (see table below) — **never commit these to the repo**.

### Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `ALLOWED_ORIGINS` | Frontend production URL — restricts CORS | `https://chrislytle.dev` |
| `SMTP_HOST` | Mail provider hostname | `smtp.gmail.com` |
| `SMTP_PORT` | SMTP port (TLS) | `587` |
| `SMTP_USER` | Sending email address | `noreply@chrislytle.dev` |
| `SMTP_PASSWORD` | App password (not your account password) | — |
| `CONTACT_RECIPIENT` | Address that receives form submissions | `chris@chrislytle.dev` |
| `DEBUG` | Leave **unset** in production | (omit entirely) |

> `DEBUG` defaults to `False` when unset. Setting it `True` re-enables `/api/docs` and `/api/openapi.json` — never do this in production.

---

## Custom Domain (Optional)

Both Vercel/Netlify and Railway/Render support custom domains:

1. Buy a domain (e.g. Namecheap or Cloudflare, ~$12/yr for `.dev`).
2. Add it in the host dashboard — they'll provide DNS records.
3. Update `ALLOWED_ORIGINS` on the backend to match the new domain.
4. Update `NUXT_PUBLIC_API_BASE` on the frontend to the backend's production URL.

---

## Security Checklist (Pre-Launch)

- [ ] `ALLOWED_ORIGINS` is set to the exact production frontend URL (no trailing slash, no wildcards)
- [ ] `DEBUG` is **not set** in the production environment
- [ ] All SMTP credentials are env vars — not in any committed file
- [ ] `backend/.env` is listed in `.gitignore` (it is — do not remove it)
- [ ] Rate limiting is active (SlowAPI middleware is registered in `create_app()`)
- [ ] Security headers middleware is registered in `create_app()` — added 2026-04-23

### Security Headers Applied (as of 2026-04-23)

The backend adds these headers to every response via HTTP middleware in `backend/app/main.py`:

| Header | Value |
|--------|-------|
| `X-Content-Type-Options` | `nosniff` |
| `X-Frame-Options` | `DENY` |
| `Referrer-Policy` | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | `geolocation=(), microphone=(), camera=()` |

---

## What Does Not Need Deployment

| Thing | Why |
|-------|-----|
| Database | There is none — content is static JSON in `frontend/content/` |
| Migrations | No database, no migrations |
| Auth service | No authentication exists — see [[codebase/authentication]] |
| Workers / queues | Email is sent synchronously in the request handler |

---

## Verifying the Deployment

After deploying both services, confirm:

```
GET https://your-backend-url.com/api/health
→ 200 { "status": "ok" }
```

Then submit the contact form on the live site and confirm the email arrives at `CONTACT_RECIPIENT`.

---

## Related

- [[codebase/authentication]] — CORS posture and what to add if auth is needed later
- [[backend/utils/config]] — full Settings field reference
- [[decisions/2026-04-22-initial-architecture]] — rationale for the split-deploy architecture
