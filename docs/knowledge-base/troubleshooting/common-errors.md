---
title: Common Errors
aliases:
  - Troubleshooting
  - Debugging Guide
tags:
  - troubleshooting
  - errors
  - developer-guide
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../backend/index]]"
  - "[[../backend/utils/config]]"
  - "[[../frontend/index]]"
  - "[[../codebase/authentication]]"
---

# Common Errors

Five errors a new developer will hit first, with cause and resolution.

---

## 1. `Error: The engine "node" is incompatible`

| | Detail |
|-|--------|
| **Symptom** | `npm install` fails with engine compatibility warning or hard error |
| **Cause** | Nuxt 3 requires Node ≥ 18; running Node 16 or earlier |
| **Resolution** | Install Node 20 (see `.nvmrc`): `nvm install 20 && nvm use 20` |
| **Files** | `frontend/.nvmrc` |

---

## 2. Frontend contact form returns network error / CORS error

| | Detail |
|-|--------|
| **Symptom** | "Something went wrong" shown after submitting the contact form; browser console shows CORS or `net::ERR_CONNECTION_REFUSED` |
| **Cause** | Backend is not running, or `NUXT_PUBLIC_API_BASE` points to the wrong URL, or `allowed_origins` in [[../backend/utils/config\|Settings]] does not include the frontend origin |
| **Resolution** | 1. Confirm backend is running: `cd backend && uvicorn app.main:app --reload` → `localhost:8000`. 2. In dev the Nuxt proxy handles routing — no env var needed. 3. In prod set `NUXT_PUBLIC_API_BASE` and add the frontend URL to `ALLOWED_ORIGINS` in `.env` |
| **Files** | `backend/app/config.py`, `frontend/nuxt.config.ts` `routeRules` |

---

## 3. Backend `.env` not found / SMTP fields missing at startup

| | Detail |
|-|--------|
| **Symptom** | Backend starts fine but contact submissions are only logged to stdout and never emailed, or pydantic-settings throws a validation error |
| **Cause** | `.env` file not created — `.env` is gitignored and must be created locally |
| **Resolution** | `cp backend/.env.example backend/.env` — SMTP fields are optional; leaving them empty enables the log-fallback mode (fine for local dev). Fill in real SMTP credentials for production |
| **Files** | `backend/.env.example`, [[../backend/utils/config\|config.py]], [[../backend/utils/email\|email.py]] |

---

## 4. `pytest` fails: `anyio` backend error or `fixture 'client' not async`

| | Detail |
|-|--------|
| **Symptom** | `pytest` exits with `ScopeMismatch`, `fixture 'client' not found as async`, or `no event loop` |
| **Cause** | `pytest-anyio` requires the `anyio_backend` fixture defined in `conftest.py`; running with the wrong async backend or missing the fixture |
| **Resolution** | Ensure `tests/conftest.py` defines `anyio_backend` returning `"asyncio"`. Run `pytest` from inside `backend/` (not the repo root) so `conftest.py` is discovered. Never mix `pytest-asyncio` and `pytest-anyio` in the same project |
| **Files** | `backend/tests/conftest.py`, `backend/requirements.txt` |

---

## 5. Project page returns 404 / "Project not found"

| | Detail |
|-|--------|
| **Symptom** | Navigating to `/projects/my-slug` shows the not-found state or throws a Nuxt 404 |
| **Cause** | The `slug` field in `frontend/content/projects.json` does not match the URL segment exactly (case-sensitive `Array.find`) |
| **Resolution** | Check that `projects.json` contains an entry with `"slug": "my-slug"` matching the URL exactly. Slugs should be lowercase hyphen-separated. Re-run `npm run build` / `npm run generate` after editing JSON content |
| **Files** | `frontend/content/projects.json`, `frontend/pages/projects/[slug].vue` |
