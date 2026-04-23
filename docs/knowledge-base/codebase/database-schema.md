---
title: Database Schema
aliases:
  - Data Schema
  - Content Schema
  - Static Data
tags:
  - schema
  - data
  - codebase
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[architecture]]"
  - "[[../frontend/components]]"
---

# Database Schema

There is no database. All persistent content is stored as **static JSON files** in `frontend/content/` and imported directly into Vue components at build time. No ORM, no driver, no migrations.

---

## Content Files

| File | Consumed By | Description |
|------|-------------|-------------|
| `frontend/content/projects.json` | `FeaturedProjects.vue`, `ProjectCard.vue`, `[slug].vue` | Project portfolio entries |
| `frontend/content/experience.json` | `ExperienceTimeline.vue` | Work history entries |
| `frontend/content/skills.json` | `SkillsGrid.vue` | Skill categories with item arrays |

---

## `projects.json` — Project Shape

| Field | Type | Required | Notes |
|-------|------|:--------:|-------|
| `slug` | `string` | ✓ | URL segment — used by `/projects/[slug].vue` for route matching |
| `title` | `string` | ✓ | Display name |
| `description` | `string` | ✓ | Short summary shown on card and detail page |
| `stack` | `string[]` | ✓ | Tech tags rendered as pills |
| `image` | `string` | — | Path to preview image; falls back to `/og-image.png` |
| `featured` | `boolean` | — | `true` to appear in home page `FeaturedProjects` (max 3 shown) |
| `liveUrl` | `string` | — | External link to live deployment |
| `repoUrl` | `string` | — | External link to source repo |
| `role` | `string` | — | Developer's role narrative; shown on detail page |
| `outcome` | `string` | — | Outcome narrative; shown on detail page |

**Constraint:** `slug` must be unique across all entries — `[slug].vue` uses `Array.find()` and returns 404 if not found.

---

## `experience.json` — Experience Shape

| Field | Type | Required | Notes |
|-------|------|:--------:|-------|
| `title` | `string` | ✓ | Job title |
| `company` | `string` | ✓ | Employer name |
| `period` | `string` | ✓ | Display string e.g. `"Jan 2022 – Present"` |
| `description` | `string` | ✓ | Role summary; rendered in timeline |

---

## `skills.json` — Skills Shape

Array of category objects:

| Field | Type | Required | Notes |
|-------|------|:--------:|-------|
| `category` | `string` | ✓ | Group heading e.g. `"Languages"` |
| `items` | `string[]` | ✓ | Individual skill names rendered as pill tags |

---

## Backend Runtime Data

The backend holds **no persistent state**. The only data that flows through it is the contact-form payload, which is immediately forwarded via SMTP (or logged) and never stored. See [[../backend/utils/email\|email.py]].
