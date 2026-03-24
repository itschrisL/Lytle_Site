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
