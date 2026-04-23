---
title: "ADR: Initial Architecture"
aliases:
  - Initial Architecture Decision
  - Tech Stack ADR
tags:
  - adr
  - decision
  - architecture
type: decision
status: accepted
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../codebase/architecture]]"
  - "[[../backend/index]]"
  - "[[../frontend/index]]"
---

# ADR: Initial Architecture — 2026-04-22

---

## Context

A professional portfolio site is needed for Chris Lytle — Software Developer, Sales Engineer, Startup Builder. Requirements:

- Static-first: page content does not change at runtime; no CMS needed
- Contact form: one write action that sends an email
- Accessibility: OpenDyslexic font toggle required
- Developer-owned: no third-party page builder, full code control
- Deployable cheaply: static host for frontend + small API host for backend

---

## Decision

**Frontend:** Nuxt 3 (Vue 3 + TypeScript) with file-based routing and static JSON content.  
**Backend:** FastAPI (Python) for the contact API.  
**Styling:** Custom CSS with CSS variables; no framework.  
**Content:** Static JSON files in `frontend/content/`; no database.

---

## Rationale

| Option | Why chosen / rejected |
|--------|----------------------|
| Nuxt 3 over Next.js | Vue 3 Composition API aligns with developer preference; Nuxt auto-import and `useState` reduce boilerplate; SSG + SPA hybrid trivial to configure |
| Nuxt 3 over plain Vite/Vue | File-based routing, head management, color-mode module, and SSG support out of the box — justified for a multi-page site |
| FastAPI over Express/Node | Python is the developer's primary backend language; Pydantic provides zero-boilerplate request validation; minimal surface area matches a two-endpoint API |
| FastAPI over serverless functions | Keeps the full backend in one deployable unit; easier to test with `httpx.AsyncClient` + `ASGITransport` |
| Static JSON over a CMS | Content changes infrequently; a CMS adds operational overhead and cost for no benefit at this scale |
| Static JSON over a database | No relational data, no querying, no migrations — JSON files are the correct tool |
| Custom CSS over Tailwind / Bootstrap | Full control of design tokens; no utility-class sprawl; CSS variables make theming (dark/light) trivial |
| Separate frontend + backend deploy | Static hosting (Vercel/Netlify) is free for static sites; the backend can run on a small Render/Railway/Fly.io instance — splitting them minimizes cost and aligns with the scale of the project |

---

## Implementation

| Area | File(s) |
|------|---------|
| App factory | `backend/app/main.py` |
| Settings | `backend/app/config.py` |
| Contact API | `backend/app/routers/contact.py`, `backend/app/services/email.py` |
| Frontend entry | `frontend/app.vue`, `frontend/nuxt.config.ts` |
| Design tokens | `frontend/assets/css/main.css` |
| Public constants | `frontend/app.config.ts` |
| Content | `frontend/content/projects.json`, `experience.json`, `skills.json` |

---

## Consequences

- **Positive:** Low operational cost, full code ownership, fast static page loads, simple backend test suite
- **Positive:** Each layer can evolve independently — backend can be replaced without touching the frontend
- **Negative:** Adding authenticated admin features requires designing an auth layer from scratch (see [[../codebase/authentication\|Authentication]])
- **Negative:** Content updates require a code deploy — acceptable for personal site, reconsidered if update frequency increases
