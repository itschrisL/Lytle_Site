---
title: AGENTS — Quick Context
aliases:
  - Agent Context
  - AI Context
tags:
  - meta
  - agents
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[index]]"
  - "[[codebase/architecture]]"
  - "[[codebase/conventions]]"
---

# AGENTS — Quick Context

Compressed project reference for AI agents. Read this first, then consult the relevant KB section for deeper detail.

---

## What This Is

Personal portfolio site for Chris Lytle — Software Developer, Sales Engineer. Two services, no database, minimal ops.

---

## Stack (one line each)

| Layer | Stack | Entry point |
|-------|-------|------------|
| Frontend | Nuxt 3 + Vue 3 + TypeScript, custom CSS | `frontend/nuxt.config.ts` |
| Backend | FastAPI + Python 3.14 + Pydantic | `backend/app/main.py` → `create_app()` |
| Content | Static JSON in `frontend/content/` | Imported directly in components |
| Styling | CSS variables only — no framework | `frontend/assets/css/main.css` |

---

## Hard Rules

1. **No hardcoded secrets** — all config via `backend/.env` + `pydantic-settings`
2. **No database** — content is static JSON; backend stores nothing
3. **No inline styles** — use CSS variables only (`--color-primary`, `--color-bg`, etc.)
4. **No raw `<a>` for internal links** — use `<UiBaseButton :to="...">` or `<NuxtLink>`
5. **API prefix** — every backend route must start with `/api`
6. **Component naming** — file at `components/domain/Name.vue` → used as `<DomainName>`
7. **Composables** — named `use*`, live in `composables/`, use `useState` for SSR-safe global state
8. **Tests** — every new backend endpoint needs a test in `backend/tests/test_*.py`

---

## File Map (what lives where)

```
frontend/
  pages/            File-based routes (index, about, projects, resume, contact)
  components/       Vue components — domain-organized (layout/, ui/, home/, etc.)
  composables/      useContactForm, useDyslexicFont
  content/          projects.json, experience.json, skills.json  ← ALL page data
  assets/css/       main.css — design tokens + global styles
  app.config.ts     Public constants (author, social links) — NO secrets here
  nuxt.config.ts    Modules, runtimeConfig, routeRules (dev proxy)

backend/
  app/main.py       create_app() — registers CORSMiddleware + routers
  app/config.py     Settings (pydantic-settings) — reads from .env
  app/routers/      contact.py (POST /api/contact), health.py (GET /api/health)
  app/schemas/      Pydantic models: ContactRequest, ContactResponse
  app/services/     email.py — send_contact_email() with SMTP/log fallback
  tests/            pytest async tests using httpx.AsyncClient + ASGITransport
```

---

## Key Conventions (quick ref)

| What | Rule |
|------|------|
| New Vue component | Add to correct `components/<domain>/` subdirectory |
| New composable | `composables/use<Name>.ts`, return named exports |
| New backend route | New file in `app/routers/`, register in `create_app()` with `/api` prefix |
| New config field | Add to `Settings` in `app/config.py`, document in KB `backend/utils/config.md` |
| New content field | Update `frontend/content/<file>.json` schema + `codebase/database-schema.md` |
| CSS class | Use `var(--token-name)` — never hardcode hex or pixel values |
| Internal link | `<UiBaseButton :to="/route">` or `<NuxtLink to="/route">` |
| External link | `<UiBaseButton href="https://...">` — adds `target="_blank" rel="noopener noreferrer"` automatically |

---

## Where to Go for More

| Need | KB File |
|------|---------|
| Full component props/emits | `frontend/components.md` |
| CSS variable list | `frontend/design-tokens.md` |
| API routes detail | `codebase/api-endpoints.md` |
| Data flow traces | `codebase/data-flow-maps.md` |
| Backend module detail | `backend/index.md` |
| Test patterns | `backend/testing.md` |
| Naming conventions | `codebase/conventions.md` |
| Why these decisions were made | `decisions/2026-04-22-initial-architecture.md` |
