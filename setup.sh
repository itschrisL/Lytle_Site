#!/usr/bin/env bash
#
# ██╗  ██╗   ██╗████████╗██╗     ███████╗
# ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
# ██║   ╚████╔╝    ██║   ██║     █████╗
# ██║    ╚██╔╝     ██║   ██║     ██╔══╝
# ███████╗██║      ██║   ███████╗███████╗
# ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
#
# Lytle_Site — Cross-platform setup script (macOS / Linux)
# Detects OS, checks prerequisites, installs dependencies, starts dev services.
#
set -euo pipefail

# ── Resolve project root (directory this script lives in) ────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ── OS detection ─────────────────────────────────────────────────────────────
OS="$(uname -s)"
case "$OS" in
    Darwin) OS_LABEL="macOS" ;;
    Linux)  OS_LABEL="Linux" ;;
    *)      OS_LABEL="$OS"   ;;
esac

# ── Helper functions ─────────────────────────────────────────────────────────
info()    { printf "${CYAN}ℹ ${NC}%s\n" "$*"; }
success() { printf "${GREEN}✔ ${NC}%s\n" "$*"; }
warn()    { printf "${YELLOW}⚠ ${NC}%s\n" "$*"; }
error()   { printf "${RED}✖ ${NC}%s\n" "$*" >&2; }

install_hint() {
    # $1 = tool name, prints OS-specific install suggestion
    local tool="$1"
    case "$OS" in
        Darwin)
            case "$tool" in
                node)    echo "  brew install node@20   (or use nvm: nvm install 20)" ;;
                python)  echo "  brew install python@3.14" ;;
                docker)  echo "  brew install --cask docker   (Docker Desktop)" ;;
            esac
            ;;
        Linux)
            case "$tool" in
                node)    echo "  nvm install 20   (https://github.com/nvm-sh/nvm)" ;;
                python)  echo "  sudo apt install python3.14  or build from source" ;;
                docker)  echo "  https://docs.docker.com/engine/install/" ;;
            esac
            ;;
    esac
}

check_command() {
    if ! command -v "$1" &>/dev/null; then
        error "$1 is not installed."
        install_hint "$2"
        return 1
    fi
}

version_gte() {
    # Returns 0 if $1 >= $2 (dot-separated versions)
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

# ── Banner ───────────────────────────────────────────────────────────────────
echo ""
printf "${BOLD}${CYAN}"
echo "  ██╗  ██╗   ██╗████████╗██╗     ███████╗"
echo "  ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝"
echo "  ██║   ╚████╔╝    ██║   ██║     █████╗  "
echo "  ██║    ╚██╔╝     ██║   ██║     ██╔══╝  "
echo "  ███████╗██║      ██║   ███████╗███████╗"
echo "  ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝"
printf "${NC}\n"
printf "${BOLD}  Lytle_Site Setup${NC}  —  Detected OS: ${GREEN}%s${NC}\n\n" "$OS_LABEL"

# ── Mode selection ───────────────────────────────────────────────────────────
echo "  How would you like to set up the project?"
echo ""
echo "    [1] Local development  (Node + Python)"
echo "    [2] Docker Compose"
echo ""
read -rp "  Enter choice [1/2]: " MODE
echo ""

case "$MODE" in
    1) MODE="local"  ;;
    2) MODE="docker" ;;
    *)
        error "Invalid choice. Please run the script again and enter 1 or 2."
        exit 1
        ;;
esac

# ═════════════════════════════════════════════════════════════════════════════
# Docker Compose path
# ═════════════════════════════════════════════════════════════════════════════
if [[ "$MODE" == "docker" ]]; then
    info "Setting up with Docker Compose..."

    # Check Docker
    check_command docker docker || exit 1
    if ! docker compose version &>/dev/null; then
        error "'docker compose' plugin not found."
        install_hint docker
        exit 1
    fi
    success "Docker and Docker Compose found."

    # Ensure backend .env exists
    if [[ ! -f backend/.env ]]; then
        cp backend/.env.example backend/.env
        success "Created backend/.env from .env.example"
    else
        info "backend/.env already exists — skipping."
    fi

    echo ""
    info "Starting services with Docker Compose..."
    docker compose up --build
    exit 0
fi

# ═════════════════════════════════════════════════════════════════════════════
# Local development path
# ═════════════════════════════════════════════════════════════════════════════
info "Setting up for local development..."
echo ""

# ── Check Node.js ────────────────────────────────────────────────────────────
REQUIRED_NODE_MAJOR=20
if [[ -f frontend/.nvmrc ]]; then
    REQUIRED_NODE_MAJOR=$(cat frontend/.nvmrc | tr -d '[:space:]')
fi

check_command node node || exit 1
NODE_VERSION="$(node --version | sed 's/^v//')"
NODE_MAJOR="${NODE_VERSION%%.*}"
if (( NODE_MAJOR < REQUIRED_NODE_MAJOR )); then
    error "Node.js v${NODE_VERSION} found, but v${REQUIRED_NODE_MAJOR}+ is required."
    install_hint node
    exit 1
fi
success "Node.js v${NODE_VERSION} (>= ${REQUIRED_NODE_MAJOR}) ✓"

# ── Check Python ─────────────────────────────────────────────────────────────
REQUIRED_PYTHON="3.14"
PYTHON_CMD=""
for cmd in python3 python; do
    if command -v "$cmd" &>/dev/null; then
        PYTHON_CMD="$cmd"
        break
    fi
done

if [[ -z "$PYTHON_CMD" ]]; then
    error "Python is not installed."
    install_hint python
    exit 1
fi

PYTHON_VERSION="$($PYTHON_CMD --version 2>&1 | awk '{print $2}')"
if ! version_gte "$PYTHON_VERSION" "$REQUIRED_PYTHON"; then
    error "Python ${PYTHON_VERSION} found, but ${REQUIRED_PYTHON}+ is required."
    install_hint python
    exit 1
fi
success "Python ${PYTHON_VERSION} (>= ${REQUIRED_PYTHON}) ✓"

# ── Backend setup ────────────────────────────────────────────────────────────
echo ""
info "Setting up backend..."

cd "$SCRIPT_DIR/backend"

if [[ ! -d .venv ]]; then
    info "Creating Python virtual environment..."
    "$PYTHON_CMD" -m venv .venv
    success "Virtual environment created at backend/.venv"
else
    info "Virtual environment already exists — skipping creation."
fi

# shellcheck disable=SC1091
source .venv/bin/activate
info "Installing Python dependencies..."
pip install -q -r requirements.txt
success "Backend dependencies installed."

if [[ ! -f .env ]]; then
    cp .env.example .env
    success "Created backend/.env from .env.example"
else
    info "backend/.env already exists — skipping."
fi

deactivate
cd "$SCRIPT_DIR"

# ── Frontend setup ───────────────────────────────────────────────────────────
echo ""
info "Setting up frontend..."

cd "$SCRIPT_DIR/frontend"
info "Installing Node dependencies..."
npm install
success "Frontend dependencies installed."

cd "$SCRIPT_DIR"

# ── Start services ───────────────────────────────────────────────────────────
echo ""
printf "${BOLD}${GREEN}✔ Setup complete!${NC}\n\n"
echo "  Starting development servers..."
echo "    Frontend → http://localhost:3000"
echo "    Backend  → http://localhost:8000"
echo ""
echo "  Press Ctrl+C to stop both servers."
echo ""

BACKEND_PID=""
cleanup() {
    echo ""
    info "Shutting down..."
    if [[ -n "$BACKEND_PID" ]] && kill -0 "$BACKEND_PID" 2>/dev/null; then
        kill "$BACKEND_PID" 2>/dev/null
        wait "$BACKEND_PID" 2>/dev/null || true
        success "Backend stopped."
    fi
}
trap cleanup EXIT INT TERM

# Start backend in background
cd "$SCRIPT_DIR/backend"
# shellcheck disable=SC1091
source .venv/bin/activate
uvicorn app.main:app --reload &
BACKEND_PID=$!
cd "$SCRIPT_DIR"

# Start frontend in foreground
cd "$SCRIPT_DIR/frontend"
npm run dev
