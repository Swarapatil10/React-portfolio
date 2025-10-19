#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored message
print_message() {
    echo -e "${2}${1}${NC}"
}

# Print header
print_header() {
    echo ""
    echo "=================================================="
    echo "  🚀 Portfolio Website - Local Setup Launcher"
    echo "=================================================="
    echo ""
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    print_message "📋 Checking prerequisites..." "$BLUE"
    
    local all_good=true
    
    # Check Node.js
    if command_exists node; then
        NODE_VERSION=$(node --version)
        print_message "✅ Node.js: $NODE_VERSION" "$GREEN"
    else
        print_message "❌ Node.js not found. Please install Node.js v18+" "$RED"
        all_good=false
    fi
    
    # Check Yarn
    if command_exists yarn; then
        YARN_VERSION=$(yarn --version)
        print_message "✅ Yarn: v$YARN_VERSION" "$GREEN"
    else
        print_message "❌ Yarn not found. Install with: npm install -g yarn" "$RED"
        all_good=false
    fi
    
    # Check Python
    if command_exists python3; then
        PYTHON_VERSION=$(python3 --version)
        print_message "✅ Python: $PYTHON_VERSION" "$GREEN"
    elif command_exists python; then
        PYTHON_VERSION=$(python --version)
        print_message "✅ Python: $PYTHON_VERSION" "$GREEN"
    else
        print_message "❌ Python not found. Please install Python 3.10+" "$RED"
        all_good=false
    fi
    
    # Check MongoDB
    if command_exists mongod; then
        MONGO_VERSION=$(mongod --version | head -n 1)
        print_message "✅ MongoDB: $MONGO_VERSION" "$GREEN"
    else
        print_message "⚠️  MongoDB not found in PATH. Attempting to start anyway..." "$YELLOW"
    fi
    
    echo ""
    
    if [ "$all_good" = false ]; then
        print_message "❌ Please install missing prerequisites before continuing." "$RED"
        print_message "   See LOCAL_SETUP_README.md for installation instructions." "$YELLOW"
        exit 1
    fi
}

# Create necessary directories
create_directories() {
    print_message "📁 Creating necessary directories..." "$BLUE"
    mkdir -p data/db
    mkdir -p logs
    print_message "✅ Directories created" "$GREEN"
    echo ""
}

# Setup backend
setup_backend() {
    print_message "🐍 Setting up Backend..." "$BLUE"
    
    cd backend || exit 1
    
    # Check if virtual environment exists
    if [ ! -d "venv" ]; then
        print_message "Creating Python virtual environment..." "$YELLOW"
        python3 -m venv venv
    fi
    
    # Activate virtual environment
    source venv/bin/activate
    
    # Install dependencies
    print_message "Installing Python dependencies..." "$YELLOW"
    pip install -r requirements.txt --quiet
    
    # Check if .env exists
    if [ ! -f ".env" ]; then
        print_message "Creating backend .env file..." "$YELLOW"
        cat > .env << EOF
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
CORS_ORIGINS=*
EOF
    fi
    
    print_message "✅ Backend setup complete" "$GREEN"
    cd ..
    echo ""
}

# Setup frontend
setup_frontend() {
    print_message "⚛️  Setting up Frontend..." "$BLUE"
    
    cd frontend || exit 1
    
    # Install dependencies
    if [ ! -d "node_modules" ]; then
        print_message "Installing Node.js dependencies..." "$YELLOW"
        yarn install
    else
        print_message "Dependencies already installed" "$GREEN"
    fi
    
    # Check if .env exists
    if [ ! -f ".env" ]; then
        print_message "Creating frontend .env file..." "$YELLOW"
        cat > .env << EOF
REACT_APP_BACKEND_URL=http://localhost:8001
EOF
    fi
    
    print_message "✅ Frontend setup complete" "$GREEN"
    cd ..
    echo ""
}

# Start MongoDB
start_mongodb() {
    print_message "🍃 Starting MongoDB..." "$BLUE"
    
    # Try different methods to start MongoDB
    if command_exists brew; then
        # macOS with Homebrew
        brew services start mongodb-community >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_message "✅ MongoDB started via Homebrew" "$GREEN"
            echo ""
            return
        fi
    fi
    
    if command_exists systemctl; then
        # Linux with systemd
        sudo systemctl start mongod >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_message "✅ MongoDB started via systemd" "$GREEN"
            echo ""
            return
        fi
    fi
    
    # Manual start
    if [ -d "data/db" ]; then
        mongod --dbpath ./data/db --fork --logpath ./data/mongodb.log >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_message "✅ MongoDB started manually" "$GREEN"
            echo ""
            return
        fi
    fi
    
    print_message "⚠️  Could not start MongoDB automatically" "$YELLOW"
    print_message "   Please start MongoDB manually before continuing" "$YELLOW"
    echo ""
}

# Start backend
start_backend() {
    print_message "🚀 Starting Backend Server..." "$BLUE"
    
    cd backend || exit 1
    source venv/bin/activate
    
    # Start backend in background
    nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 &
    BACKEND_PID=$!
    echo $BACKEND_PID > ../logs/backend.pid
    
    print_message "✅ Backend started (PID: $BACKEND_PID)" "$GREEN"
    print_message "   Log: logs/backend.log" "$BLUE"
    print_message "   URL: http://localhost:8001" "$BLUE"
    print_message "   API Docs: http://localhost:8001/docs" "$BLUE"
    
    cd ..
    echo ""
}

# Start frontend
start_frontend() {
    print_message "⚛️  Starting Frontend Server..." "$BLUE"
    
    cd frontend || exit 1
    
    # Start frontend in background
    nohup yarn start > ../logs/frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo $FRONTEND_PID > ../logs/frontend.pid
    
    print_message "✅ Frontend started (PID: $FRONTEND_PID)" "$GREEN"
    print_message "   Log: logs/frontend.log" "$BLUE"
    print_message "   URL: http://localhost:3000" "$BLUE"
    
    cd ..
    echo ""
}

# Wait for services to start
wait_for_services() {
    print_message "⏳ Waiting for services to start..." "$YELLOW"
    sleep 5
    echo ""
}

# Print final status
print_status() {
    echo "=================================================="
    print_message "🎉 All services started successfully!" "$GREEN"
    echo "=================================================="
    echo ""
    print_message "📱 Frontend:  http://localhost:3000" "$BLUE"
    print_message "🔧 Backend:   http://localhost:8001" "$BLUE"
    print_message "📚 API Docs:  http://localhost:8001/docs" "$BLUE"
    echo ""
    print_message "📋 Process IDs:" "$YELLOW"
    if [ -f "logs/backend.pid" ]; then
        BACKEND_PID=$(cat logs/backend.pid)
        print_message "   Backend:  $BACKEND_PID" "$BLUE"
    fi
    if [ -f "logs/frontend.pid" ]; then
        FRONTEND_PID=$(cat logs/frontend.pid)
        print_message "   Frontend: $FRONTEND_PID" "$BLUE"
    fi
    echo ""
    print_message "📝 Logs:" "$YELLOW"
    print_message "   Backend:  tail -f logs/backend.log" "$BLUE"
    print_message "   Frontend: tail -f logs/frontend.log" "$BLUE"
    echo ""
    print_message "🛑 To stop all services, run: ./stop_local.sh" "$YELLOW"
    echo ""
    echo "=================================================="
}

# Main execution
main() {
    print_header
    check_prerequisites
    create_directories
    setup_backend
    setup_frontend
    start_mongodb
    start_backend
    start_frontend
    wait_for_services
    print_status
}

# Run main function
main
