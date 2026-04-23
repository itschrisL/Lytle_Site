# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.2.0-alpha.1] - 2026-04-23

### Added
- Rate limiting on `POST /api/contact` — 5 requests/minute per IP via `slowapi`; IP resolved from `X-Forwarded-For` header with fallback to socket host (`app/limiter.py`)
- Blog section — `/blog` listing page and `/blog/:slug` detail pages powered by static `frontend/content/articles.json`
- Three placeholder articles: *Building My Portfolio Site with Nuxt 3 and FastAPI*, *From Sales Engineering to Software Development*, *Five Things Startup Life Taught Me About Shipping Software*
- **Blog** nav link in `AppHeader` (between Projects and Resume)
- Per-page `useSeoMeta` with `og:title`, `og:description`, `og:image`, `og:type`, `twitter:card`, and `twitter:title`/`twitter:description` on all pages — replaces generic global meta tags

### Changed
- All frontend pages upgraded from `useHead` to `useSeoMeta` for proper per-page Open Graph and Twitter Card support
- `projects/[slug].vue` SEO meta now includes per-project `og:image` (falls back to `/og-image.png`)
- Backend `requirements.txt` — added `slowapi>=0.1.9`

### Tests
- Added `test_contact_rate_limited` — verifies 5 successive requests succeed and the 6th returns 429

---

## [0.1.0-alpha.1] - 2026-03-23

### Added
- Nuxt 3 frontend with file-based routing and custom CSS design system
- Home page with hero section and featured projects
- About page with professional background
- Projects gallery with individual project detail pages
- Resume page with experience timeline, skills grid, and PDF download
- Contact page with form submission
- FastAPI backend with contact form endpoint (`POST /api/contact`)
- Health check endpoint (`GET /api/health`)
- Email service with graceful degradation (logs when SMTP unconfigured)
- Static content system using JSON files (projects, experience, skills)
- Reusable UI components (BaseButton, BaseCard, SectionHeading, SocialLinks)
- Docker Compose for local orchestration
- Backend test suite with async httpx tests
