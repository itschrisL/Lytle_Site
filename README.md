```
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗  
██║    ╚██╔╝     ██║   ██║     ██╔══╝  
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
```

# Lytle_Site

Professional personal website for **Chris Lytle** — Software Developer, Sales Engineer, and Startup Builder.

## Tech Stack

| Layer    | Technology             |
|----------|------------------------|
| Frontend | Nuxt 3 (Vue 3)        |
| Backend  | FastAPI (Python)       |
| Styling  | Custom CSS (Inter font)|

## Project Structure

```
Lytle_Site/
├── frontend/          Nuxt 3 app — pages, components, content, styles
├── backend/           FastAPI service — contact API, health check
├── docker-compose.yml Optional local orchestration
└── .gitignore
```

## Quick Start

The setup script detects your OS, checks prerequisites, installs all dependencies, and starts the dev servers.

**macOS / Linux:**

```bash
./setup.sh
```

**Windows (PowerShell):**

```powershell
.\setup.ps1
```

Both scripts will prompt you to choose between **local development** (Node + Python) and **Docker Compose**.

## Getting Started (Manual)

### Frontend

```bash
cd frontend
npm install
npm run dev        # → http://localhost:3000
```

### Backend

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate        # Windows
# source .venv/bin/activate   # macOS/Linux
pip install -r requirements.txt
cp .env.example .env          # edit with your SMTP settings (optional)
uvicorn app.main:app --reload # → http://localhost:8000
```

### Run Tests (Backend)

```bash
cd backend
pytest
```

## Pages

| Route           | Description                      |
|-----------------|----------------------------------|
| `/`             | Home — hero, featured projects   |
| `/about`        | Background and professional story|
| `/projects`     | Project gallery                  |
| `/projects/:slug` | Individual project detail     |
| `/resume`       | Experience timeline, skills, PDF |
| `/contact`      | Contact form → FastAPI endpoint  |

## API Endpoints

| Method | Path           | Purpose                   |
|--------|----------------|---------------------------|
| GET    | `/api/health`  | Health check               |
| POST   | `/api/contact` | Submit contact form message|

## Customization

- **Content**: Edit JSON files in `frontend/content/` (projects, experience, skills)
- **Social links**: Update `frontend/components/ui/SocialLinks.vue`
- **Resume PDF**: Replace `frontend/public/Chris_Lytle_Resume.pdf`
- **Colors / Design**: Modify CSS variables in `frontend/assets/css/main.css`

## Knowledge Base

A personal PKM / second-brain vault lives at [`docs/knowledge-base/`](docs/knowledge-base/). Open that directory as an Obsidian vault:

1. Open Obsidian → **Open folder as vault** → select `docs/knowledge-base/`
2. A minimal shared `.obsidian` config is committed, so core plugin settings and defaults apply immediately.

**What's versioned:** all markdown notes and the shared `.obsidian/app.json`, `appearance.json`, and `core-plugins.json`.  
**What's ignored:** `workspace.json`, plugin data, and `.trash/` (machine-local state excluded in `.gitignore`).
