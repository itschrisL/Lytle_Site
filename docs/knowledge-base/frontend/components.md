---
title: Components
aliases:
  - Vue Components
  - Component Reference
tags:
  - frontend
  - components
  - vue
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[index]]"
  - "[[stores]]"
  - "[[../../codebase/data-flow-maps]]"
---

# Components

All components are in `frontend/components/` and auto-imported by Nuxt using path-prefixed names (e.g. `components/ui/BaseButton.vue` → `<UiBaseButton>`).

---

## Layout

### `LayoutAppHeader`

| Aspect | Detail |
|--------|--------|
| File | `components/layout/AppHeader.vue` |
| Props | None |
| Emits | None |
| Renders | Sticky header with logo, nav links, `UiDyslexicToggle`, `UiThemeToggle`, mobile hamburger |
| State | `menuOpen` (local `ref`) — closes on route change via `watch(() => route.path)` |
| Notes | Nav links include `/`, `/about`, `/projects`, `/resume`, `/contact` |

### `LayoutAppFooter`

| Aspect | Detail |
|--------|--------|
| File | `components/layout/AppFooter.vue` |
| Props | None |
| Emits | None |
| Renders | Copyright year (computed) + `UiSocialLinks` |

---

## UI Primitives

### `UiBaseButton`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/BaseButton.vue` |
| Props | `variant?: 'primary'\|'secondary'\|'outline'` (default `primary`), `to?: string` (NuxtLink), `href?: string` (anchor), `block?: boolean` |
| Emits | None |
| Renders | Polymorphic — `<NuxtLink>` when `to` is set, `<a target="_blank" rel="noopener noreferrer">` when `href` is set, `<button>` otherwise |
| Notes | The polymorphic pattern means external links are always safe (`noopener noreferrer`) |

### `UiBaseCard`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/BaseCard.vue` |
| Props | `hoverable?: boolean` |
| Slots | `#image` (optional), default |
| Renders | Styled card container |

### `UiThemeToggle`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/ThemeToggle.vue` |
| Composable | `@nuxtjs/color-mode` (`useColorMode()`) |
| Renders | Sun icon (dark mode) / moon icon (light mode) toggle button |

### `UiDyslexicToggle`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/DyslexicToggle.vue` |
| Composable | [[stores#useDyslexicFont\|useDyslexicFont]] |
| Renders | "A" icon button; active state when dyslexic font is on |

### `UiSocialLinks`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/SocialLinks.vue` |
| App Config | `useAppConfig().social` (GitHub, LinkedIn, email) |
| Renders | Inline SVG icon links for GitHub, LinkedIn, and mailto email |
| Notes | SVGs are inline — zero external dependency |

### `UiSectionHeading`

| Aspect | Detail |
|--------|--------|
| File | `components/ui/SectionHeading.vue` |
| Props | `subtitle?: string` |
| Slots | Default (heading text) |
| Renders | Heading + optional subtitle |

---

## Home

### `HomeHeroSection`

| Aspect | Detail |
|--------|--------|
| File | `components/home/HeroSection.vue` |
| Props | None — all content is hardcoded in template |
| Renders | Name, tagline, description, CTA buttons to `/projects` and `/contact` |

### `HomeFeaturedProjects`

| Aspect | Detail |
|--------|--------|
| File | `components/home/FeaturedProjects.vue` |
| Data | Imports `projects.json`, filters `p.featured === true`, slices to 3 |
| Renders | Grid of up to 3 `ProjectsProjectCard` components + "View All Projects" button |

---

## Projects

### `ProjectsProjectCard`

| Aspect | Detail |
|--------|--------|
| File | `components/projects/ProjectCard.vue` |
| Props | `project: { slug, title, description, image?, stack[] }` |
| Renders | `UiBaseCard` with image, title, description, and stack tags; entire card is a `NuxtLink` to detail page |

### `ProjectsProjectDetail`

| Aspect | Detail |
|--------|--------|
| File | `components/projects/ProjectDetail.vue` |
| Props | `project: { title, slug, description, stack[], image?, liveUrl?, repoUrl?, role?, outcome? }` |
| Renders | Full detail page: header, hero image, role section, outcome section, live/repo buttons |

---

## Resume

### `ResumeExperienceTimeline`

| Aspect | Detail |
|--------|--------|
| File | `components/resume/ExperienceTimeline.vue` |
| Data | Imports `experience.json` directly |
| Renders | Vertical timeline with job title, company, period, and description for each entry |

### `ResumeSkillsGrid`

| Aspect | Detail |
|--------|--------|
| File | `components/resume/SkillsGrid.vue` |
| Data | Imports `skills.json` directly |
| Renders | Grid of skill categories, each with pill-style tag chips |

### `ResumeDownloadResume`

| Aspect | Detail |
|--------|--------|
| File | `components/resume/DownloadResume.vue` |
| Renders | Button linking to `frontend/public/Chris_Lytle_Resume.pdf` |

---

## Contact

### `ContactContactForm`

| Aspect | Detail |
|--------|--------|
| File | `components/contact/ContactForm.vue` |
| Composable | [[stores#useContactForm\|useContactForm]] |
| Renders | Name, email, textarea inputs; error banner; success message; `UiBaseButton` submit |
| Notes | Controlled entirely by `useContactForm` — no local state |

---

## Anti-Patterns

| ❌ Don't | ✅ Do instead |
|---------|-------------|
| `<a href="/about">About</a>` for in-app links | `<UiBaseButton :to="/about">About</UiBaseButton>` or `<NuxtLink to="/about">` |
| `<a href="https://github.com">` for external links | `<UiBaseButton href="https://github.com">` — adds `rel="noopener noreferrer"` automatically |
| Hardcoded colors in `<style scoped>` — `color: #2563eb` | `color: var(--color-primary)` — see [[design-tokens]] |
| `components/MyWidget.vue` at the root components level | Place in the correct domain subfolder — auto-import names break without it |
| Duplicating `UiBaseCard` logic in a new component | Compose — wrap `<UiBaseCard>` instead of re-implementing |
