@echo off
SETLOCAL EnableDelayedExpansion

REM Portfolio Website - Local Setup Launcher (Windows Batch)

echo.
echo ==================================================
echo   Portfolio Website - Local Setup Launcher
echo ==================================================
echo.

REM Check Node.js
where node >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Node.js found
) else (
    echo [ERROR] Node.js not found. Please install Node.js v18+
    pause
    exit /b 1
)

REM Check Yarn
where yarn >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Yarn found
) else (
    echo [ERROR] Yarn not found. Install with: npm install -g yarn
    pause
    exit /b 1
)

REM Check Python
where python >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Python found
) else (
    echo [ERROR] Python not found. Please install Python 3.10+
    pause
    exit /b 1
)

echo.
echo Creating necessary directories...
if not exist "data\db" mkdir data\db
if not exist "logs" mkdir logs
echo [OK] Directories created
echo.

REM Setup Backend
echo Setting up Backend...
cd backend

if not exist "venv" (
    echo Creating Python virtual environment...
    python -m venv venv
)

echo Installing Python dependencies...
call venv\Scripts\activate.bat
pip install -r requirements.txt --quiet

if not exist ".env" (
    echo Creating backend .env file...
    (
        echo MONGO_URL=mongodb://localhost:27017
        echo DB_NAME=portfolio_db
        echo CORS_ORIGINS=*
    ) > .env
)

echo [OK] Backend setup complete
cd ..
echo.

REM Setup Frontend
echo Setting up Frontend...
cd frontend

if not exist "node_modules" (
    echo Installing Node.js dependencies...
    yarn install
) else (
    echo [OK] Dependencies already installed
)

if not exist ".env" (
    echo Creating frontend .env file...
    (
        echo REACT_APP_BACKEND_URL=http://localhost:8001
    ) > .env
)

echo [OK] Frontend setup complete
cd ..
echo.

REM Start MongoDB
echo Starting MongoDB...
echo Please ensure MongoDB service is running
echo Check Windows Services or start manually
echo.

REM Start Backend
echo Starting Backend Server...
cd backend
start "Portfolio Backend" cmd /k "call venv\Scripts\activate.bat && uvicorn server:app --reload --host 0.0.0.0 --port 8001"
echo [OK] Backend starting...
echo    URL: http://localhost:8001
echo    API Docs: http://localhost:8001/docs
cd ..
echo.

REM Start Frontend
echo Starting Frontend Server...
cd frontend
start "Portfolio Frontend" cmd /k "yarn start"
echo [OK] Frontend starting...
echo    URL: http://localhost:3000
cd ..
echo.

REM Wait for services
echo Waiting for services to start...
timeout /t 5 /nobreak >nul
echo.

REM Print final status
echo ==================================================
echo   All services started successfully!
echo ==================================================
echo.
echo Frontend:  http://localhost:3000
echo Backend:   http://localhost:8001
echo API Docs:  http://localhost:8001/docs
echo.
echo Services are running in separate command windows
echo Close those windows to stop the services
echo.
echo ==================================================
echo.

pause
