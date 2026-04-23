---
title: Frontend Index
aliases:
  - Nuxt Hub
  - Frontend Overview
tags:
  - frontend
  - index
  - nuxt
type: index
status: active
created: 2026-04-22
updated: 2026-04-23
related:
  - "[[../codebase/architecture]]"
  - "[[stores]]"
  - "[[components]]"
---

# Frontend Index

Nuxt 3 (Vue 3 + TypeScript) app hub. Entry point: `frontend/app.vue`.

---

## Routing

File-based routing via `frontend/pages/`. Nuxt auto-generates routes from the file tree.

| Route | File | Notes |
|-------|------|-------|
| `/` | `pages/index.vue` | Hero + FeaturedProjects sections |
| `/about` | `pages/about.vue` | Background and professional story |
| `/projects` | `pages/projects/index.vue` | Full project gallery |
| `/projects/:slug` | `pages/projects/[slug].vue` | Dynamic route — slug matched against `projects.json` |
| `/resume` | `pages/resume.vue` | ExperienceTimeline + SkillsGrid + download button |
| `/contact` | `pages/contact.vue` | ContactForm component |
| `/blog` | `pages/blog/index.vue` | Article listing — date, tags, summary cards |
| `/blog/:slug` | `pages/blog/[slug].vue` | Dynamic route — slug matched against `articles.json`; 404 guard via `createError` |

**404 handling:** `[slug].vue` calls `createError({ statusCode: 404 })` when slug is not found in the JSON data.

---

## Composables

See [[stores\|Composables / State]] for full detail.

| Composable | File | Purpose |
|-----------|------|---------|
| `useContactForm` | `composables/useContactForm.ts` | Form state, API call, loading/error/success |
| `useDyslexicFont` | `composables/useDyslexicFont.ts` | OpenDyslexic font toggle with localStorage persistence |

---

## Key Components

See [[components\|Components]] for full props/emits inventory.

| Domain | Notable Components |
|--------|------------------|
| `layout/` | `AppHeader`, `AppFooter` |
| `ui/` | `BaseButton`, `BaseCard`, `ThemeToggle`, `DyslexicToggle`, `SocialLinks`, `SectionHeading` |
| `home/` | `HeroSection`, `FeaturedProjects` |
| `projects/` | `ProjectCard`, `ProjectDetail` |
| `resume/` | `ExperienceTimeline`, `SkillsGrid`, `DownloadResume` |
| `contact/` | `ContactForm` |

---

## Modules

| Module | Config key | Purpose |
|--------|-----------|---------|
| `@nuxtjs/color-mode` | `colorMode` | Dark/light mode — default dark, class suffix `-mode` |

---

## Runtime Config

| Key | Env Var | Default | Usage |
|-----|---------|---------|-------|
| `public.apiBase` | `NUXT_PUBLIC_API_BASE` | `http://localhost:8000` | Base URL prepended to all backend API calls in `useContactForm` |

---

## App Config (`app.config.ts`)

Public constants auto-imported everywhere via `useAppConfig()`. **Never put secrets here** — it is bundled into the client.

| Key | Value |
|-----|-------|
| `author.name` | `Chris Lytle` |
| `author.email` | `chris97lytle@gmail.com` |
| `social.github` | `https://github.com/itschrisL` |
| `social.linkedin` | `https://www.linkedin.com/in/christopherslytle/` |
| `social.email` | `chris97lytle@gmail.com` |

---

## Dev Proxy

`nuxt.config.ts` `routeRules` proxies `/api/**` to `localhost:8000` in development so the browser never makes a cross-origin request during local dev. This means CORS issues only surface when both services are on different origins (i.e., production).
