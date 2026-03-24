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

## Getting Started

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
