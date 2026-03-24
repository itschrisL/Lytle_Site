# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

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
