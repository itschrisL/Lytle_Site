# Project Guidelines

## Architecture

Monorepo with two independent services:

- **`frontend/`** — Nuxt 3 (Vue 3) app with file-based routing, TypeScript, custom CSS
- **`backend/`** — FastAPI (Python 3.14) API service with Pydantic validation

The frontend is the primary user-facing layer. The backend is intentionally small — it handles the contact form (`POST /api/contact`) and a health check (`GET /api/health`). All page content lives as static JSON in `frontend/content/`, not in a database.

## Build and Test

### Frontend

```bash
cd frontend
npm install        # also runs nuxt prepare via postinstall
npm run dev        # http://localhost:3000
npm run build      # production build
npm run generate   # static site generation
```

Requires **Node 20** (see `frontend/.nvmrc`).

### Backend

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate   # Windows
pip install -r requirements.txt
cp .env.example .env     # SMTP optional — logs messages when unconfigured
uvicorn app.main:app --reload  # http://localhost:8000
pytest                   # 3 async tests (asyncio backend)
```

Requires **Python 3.14** (see `backend/Dockerfile`).

## Conventions

### Frontend

- **Components** are organized by domain: `layout/`, `ui/`, `home/`, `projects/`, `resume/`, `contact/`. Use these subdirectories — Nuxt auto-imports with path-prefixed names (e.g., `<UiBaseButton>`, `<LayoutAppHeader>`).
- **UI primitives** (`ui/BaseButton`, `ui/BaseCard`, `ui/SectionHeading`, `ui/SocialLinks`) are reusable across pages. `BaseButton` is polymorphic — it renders as `<NuxtLink>`, `<a>`, or `<button>` depending on props.
- **Content data** lives in `frontend/content/` as JSON files (`projects.json`, `experience.json`, `skills.json`). Import directly in components — no CMS or API calls needed.
- **Styling** uses custom CSS with design tokens as CSS variables in `frontend/assets/css/main.css`. No CSS framework. Key variables: `--color-primary`, `--color-bg`, `--color-surface`, `--color-text`, `--color-text-muted`, `--color-border`, `--max-width`, `--radius`.
- **Composables** follow `use*` naming in `frontend/composables/`. `useContactForm` manages form state and the API call.
- **API base URL** is configured via `runtimeConfig.public.apiBase` (env: `NUXT_PUBLIC_API_BASE`, default: `http://localhost:8000`).

### Backend

- **Factory pattern**: `create_app()` in `app/main.py` builds the FastAPI instance. All routers use the `/api` prefix.
- **Router → Schema → Service** flow: routers validate via Pydantic schemas in `app/schemas/`, then delegate to services in `app/services/`.
- **Config** uses `pydantic-settings` reading from `.env`. Never hardcode secrets.
- **Email service** gracefully degrades: logs to stdout when SMTP is unconfigured, so local dev works without a mail server.
- **Tests** use `httpx.AsyncClient` with `ASGITransport` against the app directly — no live server needed. Tests are asyncio-only (configured in `tests/conftest.py`).

## Pitfalls

- The frontend **will not start** on Node < 18. The `.nvmrc` specifies 20.
- Backend `.env` is gitignored. Copy `.env.example` first; SMTP fields are optional for local dev.
- When adding new API endpoints, register routers in `app/main.py` and add the `/api` prefix to stay consistent.
- Nuxt auto-import means you don't need explicit `import` statements for components or composables within the `components/` and `composables/` directories.

# Deployment

- The project is designed for static hosting of the frontend (e.g., Netlify, Vercel) and a separate deployment for the backend (e.g., Heroku, AWS). The backend API URL should be configured in the frontend's `runtimeConfig` for production.


# Copilot Instructions

```md
---
description: This file provides guidelines and conventions for contributing to the project.

applyTo: **/*.md, **/*.ts, **/*.js, **/*.py
---
When contributing to the project, please adhere to the established architecture and coding conventions outlined in this document. For frontend contributions, follow the component organization and styling guidelines. For backend contributions, maintain the factory pattern and service structure. Always ensure that your code is compatible with the specified Node and Python versions, and that you run tests before submitting a pull request.

When adding new features or making changes, consider the impact on both the frontend and backend. For example, if you add a new API endpoint in the backend, make sure to update the frontend to consume that endpoint appropriately. Additionally, ensure that any new code is well-documented and follows the existing code style for consistency across the project.

When adding new features always consider the user experience and performance implications. For frontend changes, test across different screen sizes to ensure responsiveness. For backend changes, consider the load and scalability of your API endpoints. Always aim for clean, maintainable code that adheres to the project's architectural principles.

Always create unit tests for new backend functionality and run existing tests to ensure nothing is broken. For frontend changes, consider adding component tests or end-to-end tests if applicable. Use descriptive commit messages that clearly explain the purpose of your changes, and reference any related issues or pull requests when applicable.

When in doubt, refer back to the project's documentation and existing codebase for guidance on how to structure your contributions. If you have questions or need clarification on any aspect of the project, don't hesitate to reach out to the maintainers or open an issue for discussion.

When creating new project files, add the contents of the ascii_art/chris_lytle_memo_12.txt file as a comment at the top of the file. This serves as a fun easter egg and a reminder of the project's origins.

Whenever possible check if the current task is in the TODO.md file and if so, mark it as completed. If the task is not in the TODO.md file, consider whether it should be added there for better project tracking.

Whenever possible for big tasks break the task down into smaller subtasks and add those subtasks to the TODO.md file. This helps with project management and ensures that all necessary steps are tracked and completed.  Then ask if I want to add these subtasks to the github project board for better visibility and tracking of progress.

When creating unimportant comments in code files, try adding a funny comment referencing the code that is being commented on. This can add a bit of levity to the codebase and make it more enjoyable to work with. Just be sure that the comment is still informative and relevant to the code it is referencing.
```
