#!/usr/bin/env bash
# ██╗  ██╗   ██╗████████╗██╗     ███████╗
# ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
# ██║   ╚████╔╝    ██║   ██║     █████╗
# ██║    ╚██╔╝     ██║   ██║     ██╔══╝
# ███████╗██║      ██║   ███████╗███████╗
# ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
#
# start_dev.sh — fires up the full dev environment with hot reload.
# Frontend: http://localhost:3000   (Nuxt HMR — edits appear in ~1 sec)
# Backend:  http://localhost:8000   (uvicorn --reload — restarts on .py changes)

set -euo pipefail

COMPOSE_FILE="docker-compose.dev.yml"
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log()  { echo -e "${BLUE}[dev]${NC} $*"; }
ok()   { echo -e "${GREEN}[ok]${NC}  $*"; }
warn() { echo -e "${YELLOW}[warn]${NC} $*"; }
err()  { echo -e "${RED}[err]${NC}  $*" >&2; }

# ── Preflight checks ─────────────────────────────────────────────────────────

log "Running preflight checks..."

# 1. Docker daemon
if ! docker info &>/dev/null; then
  err "Docker is not running. Start Docker Desktop and try again."
  exit 1
fi
ok "Docker is running."

# 2. docker compose (v2)
if ! docker compose version &>/dev/null; then
  err "'docker compose' (v2) not found. Update Docker Desktop or install the compose plugin."
  exit 1
fi
ok "docker compose v2 available."

# 3. backend/.env — copy from .env.example if missing (SMTP fields are optional for local dev)
if [[ ! -f backend/.env ]]; then
  if [[ -f backend/.env.example ]]; then
    warn "backend/.env not found — copying from .env.example (SMTP is optional for local dev)."
    cp backend/.env.example backend/.env
    ok "backend/.env created."
  else
    err "backend/.env and backend/.env.example are both missing. Cannot start backend."
    exit 1
  fi
else
  ok "backend/.env found."
fi

# ── Parse flags ───────────────────────────────────────────────────────────────

BUILD_FLAG=""
DETACH_FLAG=""

for arg in "$@"; do
  case "$arg" in
    --build|-b) BUILD_FLAG="--build" ;;
    --detach|-d) DETACH_FLAG="--detach" ;;
    --help|-h)
      echo ""
      echo "  Usage: ./start_dev.sh [options]"
      echo ""
      echo "  Options:"
      echo "    --build,  -b   Force rebuild of Docker images"
      echo "    --detach, -d   Run containers in the background (no log stream)"
      echo "    --help,   -h   Show this help message"
      echo ""
      exit 0
      ;;
  esac
done

# ── Start ─────────────────────────────────────────────────────────────────────

echo ""
log "Starting dev environment..."
echo ""
echo "  Frontend →  http://localhost:3000"
echo "  Backend  →  http://localhost:8000"
echo ""
echo "  Press Ctrl+C to stop (or 'docker compose -f $COMPOSE_FILE down' if detached)."
echo ""

# shellcheck disable=SC2086
docker compose -f "$COMPOSE_FILE" up $BUILD_FLAG $DETACH_FLAG

# ── Detached mode summary ─────────────────────────────────────────────────────

if [[ -n "$DETACH_FLAG" ]]; then
  echo ""
  ok "Containers started in the background."
  echo ""
  echo "  Useful commands:"
  echo "    docker compose -f $COMPOSE_FILE logs -f          # stream all logs"
  echo "    docker compose -f $COMPOSE_FILE logs -f frontend # stream frontend only"
  echo "    docker compose -f $COMPOSE_FILE logs -f backend  # stream backend only"
  echo "    docker compose -f $COMPOSE_FILE down             # stop everything"
  echo ""
fi
