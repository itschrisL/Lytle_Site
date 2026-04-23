---
title: Conventions
aliases:
  - Naming Conventions
  - Code Style
  - Standards
tags:
  - codebase
  - conventions
  - style
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[architecture]]"
  - "[[../frontend/components]]"
  - "[[../frontend/design-tokens]]"
  - "[[../backend/index]]"
---

# Conventions

Source-of-truth for naming, file placement, and structural patterns. Agents and contributors must follow these to stay consistent with Nuxt auto-import and project structure.

---

## Frontend — Components

| Rule | Detail |
|------|--------|
| **File location** | `frontend/components/<domain>/<Name>.vue` |
| **Auto-import name** | `<DomainName>` — Nuxt prefixes with the folder name |
| **Domain folders** | `layout/`, `ui/`, `home/`, `projects/`, `resume/`, `contact/` — pick the closest match |
| **PascalCase** | File names and component names are always PascalCase |
| **No barrel files** | Don't add `index.ts` in component folders — Nuxt auto-import handles discovery |

Examples:

| File | Used as |
|------|---------|
| `components/ui/BaseButton.vue` | `<UiBaseButton>` |
| `components/layout/AppHeader.vue` | `<LayoutAppHeader>` |
| `components/projects/ProjectCard.vue` | `<ProjectsProjectCard>` |

---

## Frontend — Composables

| Rule | Detail |
|------|--------|
| **Naming** | `use<PascalCase>` — always starts with `use` |
| **File location** | `frontend/composables/use<Name>.ts` |
| **Return style** | Named exports (not a single object) — `return { form, loading, handleSubmit }` |
| **SSR-safe global state** | Use `useState('key', () => initialValue)` — not a module-level `ref` |
| **Local state** | `ref` / `reactive` inside the composable function — recreated per call |

---

## Frontend — Pages & Routing

| Rule | Detail |
|------|--------|
| **File location** | `frontend/pages/<name>.vue` or `frontend/pages/<segment>/[param].vue` |
| **Route generation** | Nuxt generates routes automatically — never manually register routes |
| **Dynamic segments** | Filename `[slug].vue` → `route.params.slug` |
| **404 handling** | Call `createError({ statusCode: 404 })` when a dynamic lookup fails |

---

## Frontend — Styling

| Rule | Detail |
|------|--------|
| **Always use CSS variables** | Reference `var(--token-name)` — never hardcode hex, rgb, or pixel values |
| **Scoped styles** | Use `<style scoped>` in components — no global side effects |
| **No CSS framework** | Do not add Tailwind, Bootstrap, or any utility-class library |
| **Class names** | kebab-case, descriptive, scoped to the component |
| **New tokens** | If a value is reused across components, add it to `main.css` and document in [[../frontend/design-tokens|design-tokens.md]] |

---

## Frontend — Links

| Rule | Detail |
|------|--------|
| **Internal navigation** | `<NuxtLink to="/path">` or `<UiBaseButton :to="/path">` |
| **External links** | `<UiBaseButton href="https://...">` — automatically adds `target="_blank" rel="noopener noreferrer"` |
| **Never** use raw `<a href="/internal">` for in-app navigation |  |

---

## Backend — Routers

| Rule | Detail |
|------|--------|
| **File location** | `backend/app/routers/<resource>.py` |
| **Registration** | Every router must be registered in `create_app()` in `app/main.py` |
| **Prefix** | Always include `/api` prefix: `app.include_router(router, prefix="/api")` |
| **Handler naming** | `snake_case` verb + noun — e.g. `submit_contact`, `get_health` |

---

## Backend — Schemas

| Rule | Detail |
|------|--------|
| **File location** | `backend/app/schemas/<resource>.py` |
| **Naming** | `<Resource>Request` for input, `<Resource>Response` for output |
| **Validation** | All external input validated by Pydantic — never access `request.body()` directly |

---

## Backend — Services

| Rule | Detail |
|------|--------|
| **File location** | `backend/app/services/<name>.py` |
| **Purpose** | Business logic only — no HTTP concerns, no direct FastAPI imports |
| **Error handling** | Raise exceptions that the router catches and converts to `HTTPException` |

---

## Backend — Config

| Rule | Detail |
|------|--------|
| **No hardcoded secrets** | All secrets via `.env` + `pydantic-settings` `Settings` class |
| **Import pattern** | `from app.config import settings` — use the singleton, never instantiate `Settings()` again |

---

## Content Files (Static JSON)

| Rule | Detail |
|------|--------|
| **Location** | `frontend/content/<name>.json` |
| **Slugs** | Lowercase, hyphen-separated, globally unique within a file |
| **Import** | Direct ES import in components — no fetch, no API call |
| **Schema changes** | Update `codebase/database-schema.md` whenever fields are added or removed |
