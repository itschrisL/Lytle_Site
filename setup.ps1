#Requires -Version 5.1
<#
  ██╗  ██╗   ██╗████████╗██╗     ███████╗
  ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
  ██║   ╚████╔╝    ██║   ██║     █████╗
  ██║    ╚██╔╝     ██║   ██║     ██╔══╝
  ███████╗██║      ██║   ███████╗███████╗
  ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝

  Lytle_Site — Cross-platform setup script (Windows PowerShell)
  Checks prerequisites, installs dependencies, starts dev services.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Resolve project root ────────────────────────────────────────────────────
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptDir

# ── Helper functions ─────────────────────────────────────────────────────────
function Write-Info    { param([string]$Msg) Write-Host "i $Msg" -ForegroundColor Cyan }
function Write-Ok      { param([string]$Msg) Write-Host "✔ $Msg" -ForegroundColor Green }
function Write-Warn    { param([string]$Msg) Write-Host "⚠ $Msg" -ForegroundColor Yellow }
function Write-Err     { param([string]$Msg) Write-Host "✖ $Msg" -ForegroundColor Red }

function Test-Command {
    param([string]$Name)
    $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Compare-Version {
    # Returns $true if $Actual >= $Required (dot-separated)
    param([string]$Actual, [string]$Required)
    $a = [version]$Actual
    $r = [version]$Required
    return $a -ge $r
}

function Write-InstallHint {
    param([string]$Tool)
    switch ($Tool) {
        "node"   { Write-Host "  winget install OpenJS.NodeJS.LTS   (or use nvm-windows)" -ForegroundColor Yellow }
        "python" { Write-Host "  winget install Python.Python.3.14  (or python.org)" -ForegroundColor Yellow }
        "docker" { Write-Host "  Install Docker Desktop: https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow }
    }
}

# ── Banner ───────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "  ██╗  ██╗   ██╗████████╗██╗     ███████╗" -ForegroundColor Cyan
Write-Host "  ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝" -ForegroundColor Cyan
Write-Host "  ██║   ╚████╔╝    ██║   ██║     █████╗  " -ForegroundColor Cyan
Write-Host "  ██║    ╚██╔╝     ██║   ██║     ██╔══╝  " -ForegroundColor Cyan
Write-Host "  ███████╗██║      ██║   ███████╗███████╗" -ForegroundColor Cyan
Write-Host "  ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Lytle_Site Setup  —  Detected OS: Windows" -ForegroundColor White
Write-Host ""

# ── Mode selection ───────────────────────────────────────────────────────────
Write-Host "  How would you like to set up the project?"
Write-Host ""
Write-Host "    [1] Local development  (Node + Python)"
Write-Host "    [2] Docker Compose"
Write-Host ""
$Mode = Read-Host "  Enter choice [1/2]"
Write-Host ""

if ($Mode -notin @("1", "2")) {
    Write-Err "Invalid choice. Please run the script again and enter 1 or 2."
    exit 1
}

# ═════════════════════════════════════════════════════════════════════════════
# Docker Compose path
# ═════════════════════════════════════════════════════════════════════════════
if ($Mode -eq "2") {
    Write-Info "Setting up with Docker Compose..."

    if (-not (Test-Command "docker")) {
        Write-Err "Docker is not installed."
        Write-InstallHint "docker"
        exit 1
    }

    try {
        docker compose version | Out-Null
    } catch {
        Write-Err "'docker compose' plugin not found."
        Write-InstallHint "docker"
        exit 1
    }
    Write-Ok "Docker and Docker Compose found."

    # Ensure backend .env exists
    if (-not (Test-Path "backend\.env")) {
        Copy-Item "backend\.env.example" "backend\.env"
        Write-Ok "Created backend\.env from .env.example"
    } else {
        Write-Info "backend\.env already exists — skipping."
    }

    Write-Host ""
    Write-Info "Starting services with Docker Compose..."
    docker compose up --build
    exit 0
}

# ═════════════════════════════════════════════════════════════════════════════
# Local development path
# ═════════════════════════════════════════════════════════════════════════════
Write-Info "Setting up for local development..."
Write-Host ""

# ── Check Node.js ────────────────────────────────────────────────────────────
$RequiredNodeMajor = 20
if (Test-Path "frontend\.nvmrc") {
    $RequiredNodeMajor = [int](Get-Content "frontend\.nvmrc" -Raw).Trim()
}

if (-not (Test-Command "node")) {
    Write-Err "Node.js is not installed."
    Write-InstallHint "node"
    exit 1
}

$NodeVersion = (node --version) -replace '^v', ''
$NodeMajor = [int]($NodeVersion.Split('.')[0])
if ($NodeMajor -lt $RequiredNodeMajor) {
    Write-Err "Node.js v$NodeVersion found, but v${RequiredNodeMajor}+ is required."
    Write-InstallHint "node"
    exit 1
}
Write-Ok "Node.js v$NodeVersion (>= $RequiredNodeMajor) ✓"

# ── Check Python ─────────────────────────────────────────────────────────────
$RequiredPython = "3.14"
$PythonCmd = $null

foreach ($cmd in @("python", "python3")) {
    if (Test-Command $cmd) {
        $PythonCmd = $cmd
        break
    }
}

if (-not $PythonCmd) {
    Write-Err "Python is not installed."
    Write-InstallHint "python"
    exit 1
}

$PythonVersionRaw = & $PythonCmd --version 2>&1
$PythonVersion = ($PythonVersionRaw -split ' ')[1]
if (-not (Compare-Version $PythonVersion $RequiredPython)) {
    Write-Err "Python $PythonVersion found, but ${RequiredPython}+ is required."
    Write-InstallHint "python"
    exit 1
}
Write-Ok "Python $PythonVersion (>= $RequiredPython) ✓"

# ── Backend setup ────────────────────────────────────────────────────────────
Write-Host ""
Write-Info "Setting up backend..."

Push-Location "backend"

if (-not (Test-Path ".venv")) {
    Write-Info "Creating Python virtual environment..."
    & $PythonCmd -m venv .venv
    Write-Ok "Virtual environment created at backend\.venv"
} else {
    Write-Info "Virtual environment already exists — skipping creation."
}

# Activate venv
& .\.venv\Scripts\Activate.ps1

Write-Info "Installing Python dependencies..."
pip install -q -r requirements.txt
Write-Ok "Backend dependencies installed."

if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Ok "Created backend\.env from .env.example"
} else {
    Write-Info "backend\.env already exists — skipping."
}

deactivate
Pop-Location

# ── Frontend setup ───────────────────────────────────────────────────────────
Write-Host ""
Write-Info "Setting up frontend..."

Push-Location "frontend"
Write-Info "Installing Node dependencies..."
npm install
Write-Ok "Frontend dependencies installed."
Pop-Location

# ── Start services ───────────────────────────────────────────────────────────
Write-Host ""
Write-Host "✔ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "  Starting development servers..."
Write-Host "    Frontend → http://localhost:3000"
Write-Host "    Backend  → http://localhost:8000"
Write-Host ""
Write-Host "  Press Ctrl+C to stop both servers."
Write-Host ""

$BackendJob = $null

try {
    # Start backend in a background job
    $BackendJob = Start-Job -ScriptBlock {
        param($Dir, $PyCmd)
        Set-Location $Dir
        & .\.venv\Scripts\Activate.ps1
        uvicorn app.main:app --reload
    } -ArgumentList (Join-Path $ScriptDir "backend"), $PythonCmd

    # Start frontend in foreground
    Push-Location (Join-Path $ScriptDir "frontend")
    npm run dev
} finally {
    Write-Host ""
    Write-Info "Shutting down..."
    if ($BackendJob) {
        Stop-Job -Job $BackendJob -ErrorAction SilentlyContinue
        Remove-Job -Job $BackendJob -Force -ErrorAction SilentlyContinue
        Write-Ok "Backend stopped."
    }
    Pop-Location -ErrorAction SilentlyContinue
}
