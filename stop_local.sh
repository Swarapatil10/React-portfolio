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
echo ""
echo "=================================================="
echo "  🛑 Stopping Portfolio Website Services"
echo "=================================================="
echo ""

# Stop backend
if [ -f "logs/backend.pid" ]; then
    BACKEND_PID=$(cat logs/backend.pid)
    print_message "🔧 Stopping Backend (PID: $BACKEND_PID)..." "$BLUE"
    kill $BACKEND_PID 2>/dev/null
    if [ $? -eq 0 ]; then
        print_message "✅ Backend stopped" "$GREEN"
        rm logs/backend.pid
    else
        print_message "⚠️  Backend process not found" "$YELLOW"
    fi
else
    print_message "⚠️  Backend PID file not found" "$YELLOW"
fi

echo ""

# Stop frontend
if [ -f "logs/frontend.pid" ]; then
    FRONTEND_PID=$(cat logs/frontend.pid)
    print_message "⚛️  Stopping Frontend (PID: $FRONTEND_PID)..." "$BLUE"
    kill $FRONTEND_PID 2>/dev/null
    if [ $? -eq 0 ]; then
        print_message "✅ Frontend stopped" "$GREEN"
        rm logs/frontend.pid
    else
        print_message "⚠️  Frontend process not found" "$YELLOW"
    fi
else
    print_message "⚠️  Frontend PID file not found" "$YELLOW"
fi

echo ""

# Stop MongoDB (optional)
print_message "🍃 MongoDB Status:" "$BLUE"
print_message "   MongoDB is still running. To stop it:" "$YELLOW"
print_message "   macOS:  brew services stop mongodb-community" "$BLUE"
print_message "   Linux:  sudo systemctl stop mongod" "$BLUE"

echo ""
echo "=================================================="
print_message "✅ Services stopped successfully!" "$GREEN"
echo "=================================================="
echo ""

# Additional cleanup
print_message "💡 Tip: To kill all remaining processes:" "$YELLOW"
print_message "   pkill -f 'uvicorn server:app'" "$BLUE"
print_message "   pkill -f 'react-scripts'" "$BLUE"
echo ""
