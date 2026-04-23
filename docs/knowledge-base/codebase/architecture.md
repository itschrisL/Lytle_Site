---
title: Architecture
aliases:
  - System Design
  - Overview
tags:
  - architecture
  - codebase
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[api-endpoints]]"
  - "[[data-flow-maps]]"
  - "[[../backend/index]]"
  - "[[../frontend/index]]"
---

# Architecture

System design overview for the Lytle Site monorepo.

---

## Components

| Component | Technology | Responsibility |
|-----------|-----------|----------------|
| Frontend | Nuxt 3 (Vue 3) + TypeScript | Static site, file-based routing, UI, contact form |
| Backend | FastAPI (Python 3.14) | REST API — contact form intake and health check only |
| Content | Static JSON in `frontend/content/` | Projects, experience, skills — no CMS, no DB |
| Styling | Custom CSS + CSS variables | Design tokens in `assets/css/main.css`; no framework |
| App Config | `frontend/app.config.ts` | Public constants (author, social links) — auto-imported everywhere |
| Runtime Config | `nuxt.config.ts` `runtimeConfig` | `apiBase` env var (`NUXT_PUBLIC_API_BASE`) injected at build time |

---

## ASCII Data-Flow Diagram

```
User Browser
     │
     │  GET /page  (static render, no round-trip to backend)
     ▼
┌──────────────────────────────────────────────┐
│               Nuxt 3 Frontend                │
│                                              │
│  pages/*.vue ──► JSON content files          │
│  (projects, experience, skills rendered      │
│   entirely from frontend/content/*.json)     │
│                                              │
│  ContactForm.vue                             │
│    └─ useContactForm()                       │
│         └─ $fetch POST /api/contact          │
└───────────────────┬──────────────────────────┘
                    │  POST /api/contact
                    │  { name, email, message }
                    ▼
┌──────────────────────────────────────────────┐
│               FastAPI Backend                │
│                                              │
│  CORSMiddleware                              │
│    └─ contact router                         │
│         └─ submit_contact()                  │
│              └─ ContactRequest (Pydantic)    │
│                   └─ send_contact_email()    │
│                        │                    │
│               smtp_host set?                 │
│               YES → SMTP send               │
│               NO  → logger.info (stdout)    │
└───────────────────┬──────────────────────────┘
                    │  200 { "message": "Message sent successfully." }
                    ▼
         useContactForm sets success = true
         UI displays "Thanks! I'll be in touch soon."
```

---

## Key Constraints

| Constraint | Detail |
|-----------|--------|
| No database | All page content is static JSON; backend holds zero persistent state |
| No authentication | All routes are public — rate limiting is an open TODO (see [[api-endpoints]]) |
| Decoupled deploy | Frontend and backend deploy independently to separate hosts |
| API proxy in dev | Nuxt `routeRules` proxies `/api/**` to `localhost:8000` so no CORS issues locally |
| CORS | `allowed_origins` in [[../backend/utils/config\|Settings]]; **must** include production frontend domain before launch |
| SMTP optional | Backend logs to stdout when `smtp_host` is empty — local dev works without a mail server |

---

## Directory Map

```
Lytle_Site/
├── frontend/
│   ├── app.config.ts       Public constants (social, author, site)
│   ├── nuxt.config.ts      Modules, runtimeConfig, routeRules, head
│   ├── assets/css/main.css Design tokens (CSS variables)
│   ├── components/         Domain-organized Vue components
│   ├── composables/        useContactForm, useDyslexicFont
│   ├── content/            projects.json, experience.json, skills.json
│   └── pages/              File-based routing
├── backend/
│   ├── app/main.py         Factory: create_app() registers middleware + routers
│   ├── app/config.py       pydantic-settings Settings singleton
│   ├── app/routers/        contact.py, health.py
│   ├── app/schemas/        Pydantic request/response models
│   └── app/services/       email.py — only service layer
└── docs/knowledge-base/    ← you are here
```

---

## Open Questions / Decisions

- [ ] Hosting provider for frontend (Vercel / Netlify)
- [ ] Hosting provider for backend (Render / Railway / Fly.io)
- [ ] Rate limiting implementation for `POST /api/contact`
- [ ] Analytics provider (Plausible / Umami / GA)
