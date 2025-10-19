# Portfolio Website - Local Setup Launcher (Windows PowerShell)

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  🚀 Portfolio Website - Local Setup Launcher" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Function to print colored messages
function Print-Message {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Check prerequisites
Print-Message "📋 Checking prerequisites..." "Blue"

$allGood = $true

# Check Node.js
if (Get-Command node -ErrorAction SilentlyContinue) {
    $nodeVersion = node --version
    Print-Message "✅ Node.js: $nodeVersion" "Green"
} else {
    Print-Message "❌ Node.js not found. Please install Node.js v18+" "Red"
    $allGood = $false
}

# Check Yarn
if (Get-Command yarn -ErrorAction SilentlyContinue) {
    $yarnVersion = yarn --version
    Print-Message "✅ Yarn: v$yarnVersion" "Green"
} else {
    Print-Message "❌ Yarn not found. Install with: npm install -g yarn" "Red"
    $allGood = $false
}

# Check Python
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonVersion = python --version
    Print-Message "✅ Python: $pythonVersion" "Green"
} else {
    Print-Message "❌ Python not found. Please install Python 3.10+" "Red"
    $allGood = $false
}

# Check MongoDB
if (Get-Command mongod -ErrorAction SilentlyContinue) {
    Print-Message "✅ MongoDB: Found" "Green"
} else {
    Print-Message "⚠️  MongoDB not found in PATH" "Yellow"
}

Write-Host ""

if (-not $allGood) {
    Print-Message "❌ Please install missing prerequisites before continuing." "Red"
    Print-Message "   See LOCAL_SETUP_README.md for installation instructions." "Yellow"
    exit 1
}

# Create necessary directories
Print-Message "📁 Creating necessary directories..." "Blue"
New-Item -ItemType Directory -Force -Path "data\db" | Out-Null
New-Item -ItemType Directory -Force -Path "logs" | Out-Null
Print-Message "✅ Directories created" "Green"
Write-Host ""

# Setup backend
Print-Message "🐍 Setting up Backend..." "Blue"
Set-Location backend

# Check if virtual environment exists
if (-not (Test-Path "venv")) {
    Print-Message "Creating Python virtual environment..." "Yellow"
    python -m venv venv
}

# Activate virtual environment and install dependencies
Print-Message "Installing Python dependencies..." "Yellow"
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt --quiet

# Create .env if it doesn't exist
if (-not (Test-Path ".env")) {
    Print-Message "Creating backend .env file..." "Yellow"
    @"
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
CORS_ORIGINS=*
"@ | Out-File -FilePath ".env" -Encoding utf8
}

Print-Message "✅ Backend setup complete" "Green"
Set-Location ..
Write-Host ""

# Setup frontend
Print-Message "⚛️  Setting up Frontend..." "Blue"
Set-Location frontend

# Install dependencies
if (-not (Test-Path "node_modules")) {
    Print-Message "Installing Node.js dependencies..." "Yellow"
    yarn install
} else {
    Print-Message "Dependencies already installed" "Green"
}

# Create .env if it doesn't exist
if (-not (Test-Path ".env")) {
    Print-Message "Creating frontend .env file..." "Yellow"
    @"
REACT_APP_BACKEND_URL=http://localhost:8001
"@ | Out-File -FilePath ".env" -Encoding utf8
}

Print-Message "✅ Frontend setup complete" "Green"
Set-Location ..
Write-Host ""

# Start MongoDB
Print-Message "🍃 Starting MongoDB..." "Blue"
Print-Message "   Please ensure MongoDB service is running" "Yellow"
Print-Message "   Check Windows Services or start manually" "Yellow"
Write-Host ""

# Start backend
Print-Message "🚀 Starting Backend Server..." "Blue"
Set-Location backend
.\venv\Scripts\Activate.ps1

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; .\venv\Scripts\Activate.ps1; uvicorn server:app --reload --host 0.0.0.0 --port 8001" -WindowStyle Minimized
Print-Message "✅ Backend starting..." "Green"
Print-Message "   URL: http://localhost:8001" "Blue"
Print-Message "   API Docs: http://localhost:8001/docs" "Blue"

Set-Location ..
Write-Host ""

# Start frontend
Print-Message "⚛️  Starting Frontend Server..." "Blue"
Set-Location frontend

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; yarn start" -WindowStyle Minimized
Print-Message "✅ Frontend starting..." "Green"
Print-Message "   URL: http://localhost:3000" "Blue"

Set-Location ..
Write-Host ""

# Wait for services
Print-Message "⏳ Waiting for services to start..." "Yellow"
Start-Sleep -Seconds 5
Write-Host ""

# Print final status
Write-Host "==================================================" -ForegroundColor Cyan
Print-Message "🎉 All services started successfully!" "Green"
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Print-Message "📱 Frontend:  http://localhost:3000" "Blue"
Print-Message "🔧 Backend:   http://localhost:8001" "Blue"
Print-Message "📚 API Docs:  http://localhost:8001/docs" "Blue"
Write-Host ""
Print-Message "ℹ️  Services are running in minimized PowerShell windows" "Yellow"
Print-Message "   Close those windows to stop the services" "Yellow"
Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
