#!/bin/bash

# One-Command Installation and Launch Script
# Run this script with: curl -sSL <url> | bash
# Or download and run: ./quick_start.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║  🚀 Portfolio Website - Quick Start Installer  ║"
echo "╔════════════════════════════════════════════════╗"
echo ""

# Function to print colored messages
print_msg() {
    echo -e "${2}${1}${NC}"
}

# Check if running as root (not recommended)
if [ "$EUID" -eq 0 ]; then 
    print_msg "⚠️  Warning: Running as root. This is not recommended." "$YELLOW"
    echo ""
fi

# Step 1: Check prerequisites
print_msg "Step 1/6: Checking prerequisites..." "$CYAN"
sleep 1

MISSING_DEPS=()

if ! command -v node &> /dev/null; then
    MISSING_DEPS+=("Node.js (v18+)")
fi

if ! command -v yarn &> /dev/null; then
    MISSING_DEPS+=("Yarn")
fi

if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    MISSING_DEPS+=("Python (v3.10+)")
fi

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    print_msg "❌ Missing prerequisites:" "$RED"
    for dep in "${MISSING_DEPS[@]}"; do
        echo "   - $dep"
    done
    echo ""
    print_msg "Please install the missing software and try again." "$YELLOW"
    print_msg "See LOCAL_SETUP_README.md for installation instructions." "$BLUE"
    exit 1
fi

print_msg "✅ All prerequisites found!" "$GREEN"
echo ""
sleep 1

# Step 2: Create directories
print_msg "Step 2/6: Creating project directories..." "$CYAN"
mkdir -p data/db logs
print_msg "✅ Directories created" "$GREEN"
echo ""
sleep 1

# Step 3: Setup Backend
print_msg "Step 3/6: Setting up Backend..." "$CYAN"
cd backend || exit 1

# Create virtual environment
if [ ! -d "venv" ]; then
    print_msg "   Creating Python virtual environment..." "$BLUE"
    python3 -m venv venv || python -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install Python dependencies
print_msg "   Installing Python packages (this may take a moment)..." "$BLUE"
pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet

if [ $? -eq 0 ]; then
    print_msg "✅ Backend setup complete" "$GREEN"
else
    print_msg "❌ Backend setup failed" "$RED"
    exit 1
fi

# Create .env if not exists
if [ ! -f ".env" ]; then
    cat > .env << 'EOF'
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
CORS_ORIGINS=*
EOF
fi

cd ..
echo ""
sleep 1

# Step 4: Setup Frontend
print_msg "Step 4/6: Setting up Frontend..." "$CYAN"
cd frontend || exit 1

# Install Node dependencies
print_msg "   Installing Node.js packages (this may take a moment)..." "$BLUE"
yarn install --silent

if [ $? -eq 0 ]; then
    print_msg "✅ Frontend setup complete" "$GREEN"
else
    print_msg "❌ Frontend setup failed" "$RED"
    exit 1
fi

# Create .env if not exists
if [ ! -f ".env" ]; then
    cat > .env << 'EOF'
REACT_APP_BACKEND_URL=http://localhost:8001
EOF
fi

cd ..
echo ""
sleep 1

# Step 5: Start MongoDB
print_msg "Step 5/6: Starting MongoDB..." "$CYAN"

# Try different methods
MONGO_STARTED=false

# Try Homebrew (macOS)
if command -v brew &> /dev/null; then
    brew services start mongodb-community &> /dev/null && MONGO_STARTED=true
fi

# Try systemd (Linux)
if [ "$MONGO_STARTED" = false ] && command -v systemctl &> /dev/null; then
    sudo systemctl start mongod &> /dev/null && MONGO_STARTED=true
fi

# Try manual start
if [ "$MONGO_STARTED" = false ]; then
    mongod --dbpath ./data/db --fork --logpath ./data/mongodb.log &> /dev/null && MONGO_STARTED=true
fi

if [ "$MONGO_STARTED" = true ]; then
    print_msg "✅ MongoDB started" "$GREEN"
else
    print_msg "⚠️  Could not start MongoDB automatically" "$YELLOW"
    print_msg "   Please start MongoDB manually in another terminal" "$YELLOW"
fi
echo ""
sleep 1

# Step 6: Start services
print_msg "Step 6/6: Starting application services..." "$CYAN"

# Start Backend
cd backend || exit 1
source venv/bin/activate
print_msg "   Starting backend on port 8001..." "$BLUE"
nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > ../logs/backend.pid
cd ..

sleep 2

# Start Frontend
cd frontend || exit 1
print_msg "   Starting frontend on port 3000..." "$BLUE"
nohup yarn start > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > ../logs/frontend.pid
cd ..

print_msg "✅ Services started" "$GREEN"
echo ""
sleep 2

# Wait for services to initialize
print_msg "⏳ Initializing services..." "$YELLOW"
sleep 5

# Final message
clear
echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║          🎉 Installation Complete! 🎉          ║"
echo "╚════════════════════════════════════════════════╝"
echo ""
print_msg "Your portfolio website is now running!" "$GREEN"
echo ""
print_msg "📱 Application URLs:" "$CYAN"
print_msg "   Frontend:  http://localhost:3000" "$BLUE"
print_msg "   Backend:   http://localhost:8001" "$BLUE"
print_msg "   API Docs:  http://localhost:8001/docs" "$BLUE"
echo ""
print_msg "📋 Process Information:" "$CYAN"
print_msg "   Backend PID:  $BACKEND_PID" "$BLUE"
print_msg "   Frontend PID: $FRONTEND_PID" "$BLUE"
echo ""
print_msg "📝 View Logs:" "$CYAN"
print_msg "   Backend:  tail -f logs/backend.log" "$BLUE"
print_msg "   Frontend: tail -f logs/frontend.log" "$BLUE"
echo ""
print_msg "🛑 Stop Services:" "$CYAN"
print_msg "   Run: ./stop_local.sh" "$BLUE"
print_msg "   Or:  kill $BACKEND_PID $FRONTEND_PID" "$BLUE"
echo ""
print_msg "💡 Tip: Your browser should open automatically!" "$YELLOW"
echo ""
echo "════════════════════════════════════════════════"
echo ""

# Try to open browser
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000 &> /dev/null
elif command -v open &> /dev/null; then
    open http://localhost:3000 &> /dev/null
fi
