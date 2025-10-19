# 🚀 Local Development Setup Guide

A comprehensive guide to run the Swara Patil Portfolio Website on your local machine.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Start (One Command)](#quick-start-one-command)
3. [Detailed Setup Instructions](#detailed-setup-instructions)
4. [Project Structure](#project-structure)
5. [Running Individual Services](#running-individual-services)
6. [Troubleshooting](#troubleshooting)
7. [Environment Configuration](#environment-configuration)

---

## 🔧 Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Software

| Software | Version | Download Link | Verification Command |
|----------|---------|---------------|---------------------|
| **Node.js** | v18.0.0 or higher | [Download](https://nodejs.org/) | `node --version` |
| **Yarn** | v1.22.0 or higher | [Install Guide](https://classic.yarnpkg.com/en/docs/install) | `yarn --version` |
| **Python** | v3.10 or higher | [Download](https://www.python.org/downloads/) | `python --version` or `python3 --version` |
| **pip** | Latest | Usually comes with Python | `pip --version` or `pip3 --version` |
| **MongoDB** | v4.0 or higher | [Download](https://www.mongodb.com/try/download/community) | `mongod --version` |
| **Git** | Latest | [Download](https://git-scm.com/downloads) | `git --version` |

### Install Yarn (if not already installed)

```bash
# Using npm (comes with Node.js)
npm install -g yarn

# Verify installation
yarn --version
```

### Verify All Prerequisites

Run these commands to ensure everything is installed correctly:

```bash
# Check Node.js
node --version  # Should output v18.x.x or higher

# Check Yarn
yarn --version  # Should output 1.22.x or higher

# Check Python
python --version  # or python3 --version
# Should output Python 3.10.x or higher

# Check pip
pip --version  # or pip3 --version

# Check MongoDB
mongod --version
```

---

## ⚡ Quick Start (One Command)

### For Unix/Linux/macOS:

**Option 1: Copy and paste this complete setup script:**

```bash
# Clone repository (if you haven't already)
# git clone <your-repository-url> && cd portfolio-website

# Run complete setup and start script
cd backend && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && cd ../frontend && yarn install && cd .. && echo "Starting MongoDB..." && (mongod --dbpath ./data/db --fork --logpath ./data/mongodb.log 2>/dev/null || brew services start mongodb-community 2>/dev/null || sudo systemctl start mongod 2>/dev/null) && echo "Starting Backend..." && cd backend && source venv/bin/activate && nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 & echo $! > ../logs/backend.pid && cd ../frontend && echo "Starting Frontend..." && nohup yarn start > ../logs/frontend.log 2>&1 & echo $! > ../logs/frontend.pid && cd .. && echo "✅ All services started!" && echo "Frontend: http://localhost:3000" && echo "Backend: http://localhost:8001" && echo "API Docs: http://localhost:8001/docs"
```

**Option 2: Use the provided start script (Recommended):**

```bash
# Make the script executable
chmod +x start_local.sh

# Run the script
./start_local.sh
```

### For Windows (PowerShell):

```powershell
# Run this PowerShell script
.\start_local.ps1
```

Or use the batch file:

```cmd
start_local.bat
```

---

## 📖 Detailed Setup Instructions

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone <your-repository-url>

# Navigate to project directory
cd portfolio-website
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create a Python virtual environment
python3 -m venv venv

# Activate virtual environment
# For macOS/Linux:
source venv/bin/activate
# For Windows:
# venv\Scripts\activate

# Install all Python dependencies
pip install -r requirements.txt

# Create .env file
touch .env  # For Windows: type nul > .env

# Configure backend .env file (see Environment Configuration section)
```

**Configure `backend/.env`:**

```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
CORS_ORIGINS=*
```

### Step 3: Frontend Setup

```bash
# Navigate to frontend directory from project root
cd ../frontend

# Install all Node.js dependencies using Yarn
yarn install

# Create .env file
touch .env  # For Windows: type nul > .env

# Configure frontend .env file
```

**Configure `frontend/.env`:**

```env
REACT_APP_BACKEND_URL=http://localhost:8001
```

### Step 4: Start MongoDB

**macOS (Homebrew):**
```bash
brew services start mongodb-community
```

**Linux (systemd):**
```bash
sudo systemctl start mongod
sudo systemctl enable mongod  # Enable on boot
```

**Windows:**
```bash
# If installed as service, MongoDB starts automatically
# Or run manually:
mongod --dbpath C:\data\db
```

**Manual Start (All Platforms):**
```bash
# Create data directory first
mkdir -p ./data/db

# Start MongoDB
mongod --dbpath ./data/db
```

**Verify MongoDB is running:**
```bash
# Check connection
mongosh  # or mongo (older versions)
# You should see MongoDB shell prompt
```

### Step 5: Start Backend Server

```bash
# From backend directory
cd backend

# Activate virtual environment (if not already activated)
source venv/bin/activate  # macOS/Linux
# venv\Scripts\activate  # Windows

# Start FastAPI server
uvicorn server:app --reload --host 0.0.0.0 --port 8001
```

**You should see:**
```
INFO:     Uvicorn running on http://0.0.0.0:8001 (Press CTRL+C to quit)
INFO:     Started reloader process [xxxxx] using WatchFiles
INFO:     Started server process [xxxxx]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

**Backend URLs:**
- API Base: `http://localhost:8001/api/`
- API Documentation (Swagger): `http://localhost:8001/docs`
- Alternative API Docs (ReDoc): `http://localhost:8001/redoc`

### Step 6: Start Frontend Development Server

**Open a new terminal window/tab:**

```bash
# From frontend directory
cd frontend

# Start React development server
yarn start
```

**You should see:**
```
Compiled successfully!

You can now view frontend in the browser.

  Local:            http://localhost:3000
  On Your Network:  http://192.168.x.x:3000
```

**Frontend will automatically open in your browser at:**
- `http://localhost:3000`

---

## 📂 Project Structure

```
portfolio-website/
├── backend/                      # FastAPI Backend
│   ├── server.py                # Main FastAPI application
│   ├── requirements.txt         # Python dependencies
│   ├── .env                     # Backend environment variables
│   └── venv/                    # Python virtual environment (created during setup)
│
├── frontend/                     # React Frontend
│   ├── src/
│   │   ├── components/          # React components
│   │   │   ├── Header.jsx
│   │   │   ├── Home.jsx
│   │   │   ├── Skills.jsx
│   │   │   ├── Projects.jsx
│   │   │   ├── Education.jsx
│   │   │   ├── Certifications.jsx
│   │   │   ├── Hobbies.jsx
│   │   │   ├── About.jsx
│   │   │   ├── Contact.jsx
│   │   │   └── Footer.jsx
│   │   ├── App.js              # Main application component
│   │   ├── App.css             # Global styles
│   │   ├── index.js            # Application entry point
│   │   └── index.css           # Tailwind CSS imports
│   ├── public/
│   │   └── index.html          # HTML template
│   ├── package.json            # Node.js dependencies
│   ├── .env                    # Frontend environment variables
│   └── node_modules/           # Node.js modules (created during setup)
│
├── data/                        # MongoDB data directory (created during setup)
│   └── db/
│
├── logs/                        # Application logs (created during runtime)
│   ├── backend.log
│   ├── frontend.log
│   ├── backend.pid
│   └── frontend.pid
│
├── README.md                    # Original project documentation
├── LOCAL_SETUP_README.md        # This file - Local setup guide
├── start_local.sh              # Quick start script for Unix/Linux/macOS
├── start_local.ps1             # Quick start script for Windows PowerShell
├── start_local.bat             # Quick start script for Windows CMD
└── stop_local.sh               # Stop all services script
```

---

## 🔄 Running Individual Services

### Start Backend Only

```bash
cd backend
source venv/bin/activate  # macOS/Linux
# venv\Scripts\activate  # Windows
uvicorn server:app --reload --host 0.0.0.0 --port 8001
```

### Start Frontend Only

```bash
cd frontend
yarn start
```

### Start MongoDB Only

```bash
# macOS (Homebrew)
brew services start mongodb-community

# Linux
sudo systemctl start mongod

# Manual
mongod --dbpath ./data/db
```

---

## 🛑 Stopping Services

### Stop All Services (Unix/Linux/macOS)

**Using stop script:**
```bash
chmod +x stop_local.sh
./stop_local.sh
```

**Manual stop:**
```bash
# Stop backend
kill $(cat logs/backend.pid) 2>/dev/null

# Stop frontend
kill $(cat logs/frontend.pid) 2>/dev/null

# Stop MongoDB
# macOS:
brew services stop mongodb-community
# Linux:
sudo systemctl stop mongod
```

### Stop Individual Services

**Backend/Frontend:**
- Press `Ctrl+C` in the terminal where the service is running

**MongoDB:**
```bash
# macOS
brew services stop mongodb-community

# Linux
sudo systemctl stop mongod

# Manual
mongosh admin --eval "db.shutdownServer()"
```

---

## 🐛 Troubleshooting

### Port Already in Use

**Problem:** Port 3000, 8001, or 27017 is already in use.

**Solution:**

```bash
# Find and kill process using port 3000 (Frontend)
# macOS/Linux:
lsof -ti:3000 | xargs kill -9
# Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Find and kill process using port 8001 (Backend)
# macOS/Linux:
lsof -ti:8001 | xargs kill -9
# Windows:
netstat -ano | findstr :8001
taskkill /PID <PID> /F

# Find and kill process using port 27017 (MongoDB)
# macOS/Linux:
lsof -ti:27017 | xargs kill -9
# Windows:
netstat -ano | findstr :27017
taskkill /PID <PID> /F
```

### MongoDB Connection Failed

**Problem:** Backend can't connect to MongoDB.

**Solutions:**

1. **Verify MongoDB is running:**
   ```bash
   # Check status
   # macOS:
   brew services list | grep mongodb
   # Linux:
   sudo systemctl status mongod
   ```

2. **Check MongoDB connection:**
   ```bash
   mongosh
   # If this fails, MongoDB is not running
   ```

3. **Check MONGO_URL in backend/.env:**
   ```env
   MONGO_URL=mongodb://localhost:27017
   ```

4. **Start MongoDB:**
   ```bash
   # macOS:
   brew services start mongodb-community
   # Linux:
   sudo systemctl start mongod
   # Manual:
   mongod --dbpath ./data/db
   ```

### Module Not Found Errors

**Backend:**
```bash
cd backend
source venv/bin/activate
pip install --upgrade -r requirements.txt
```

**Frontend:**
```bash
cd frontend
rm -rf node_modules yarn.lock
yarn install
```

### Python Virtual Environment Issues

**Problem:** Virtual environment not activating or commands not found.

**Solution:**

```bash
# Remove old virtual environment
rm -rf backend/venv

# Create new virtual environment
cd backend
python3 -m venv venv

# Activate it
source venv/bin/activate  # macOS/Linux
# venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt
```

### Frontend Not Loading

**Problem:** Frontend shows blank page or errors.

**Solutions:**

1. **Clear cache and restart:**
   ```bash
   cd frontend
   rm -rf node_modules/.cache
   yarn start
   ```

2. **Check environment variables:**
   ```bash
   # Ensure frontend/.env has:
   REACT_APP_BACKEND_URL=http://localhost:8001
   ```

3. **Check browser console for errors** (F12 in most browsers)

### CORS Errors

**Problem:** Frontend can't communicate with backend due to CORS.

**Solution:**

Ensure `backend/.env` has:
```env
CORS_ORIGINS=*
```

Or specify allowed origins:
```env
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
```

### API Not Working

**Problem:** API endpoints return 404 or don't work.

**Solutions:**

1. **Check backend is running:**
   - Visit: `http://localhost:8001/api/`
   - Should return: `{"message": "Hello World"}`

2. **Check API documentation:**
   - Visit: `http://localhost:8001/docs`
   - Test endpoints directly

3. **Check backend logs:**
   ```bash
   tail -f logs/backend.log
   # or if running in terminal, check the terminal output
   ```

### Database Issues

**Problem:** Data not persisting or database errors.

**Solutions:**

1. **Check database name:**
   ```bash
   # In backend/.env:
   DB_NAME=portfolio_db
   ```

2. **Connect to MongoDB and verify:**
   ```bash
   mongosh
   > show dbs
   > use portfolio_db
   > show collections
   ```

3. **Reset database (if needed):**
   ```bash
   mongosh
   > use portfolio_db
   > db.dropDatabase()
   ```

---

## ⚙️ Environment Configuration

### Backend Environment Variables (`backend/.env`)

```env
# MongoDB Connection URL
MONGO_URL=mongodb://localhost:27017

# Database Name
DB_NAME=portfolio_db

# CORS Configuration
# Use * for development, specify origins for production
CORS_ORIGINS=*
# CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
```

### Frontend Environment Variables (`frontend/.env`)

```env
# Backend API URL
REACT_APP_BACKEND_URL=http://localhost:8001
```

---

## 🧪 Testing the Application

### Test Backend API

**1. Health Check:**
```bash
curl http://localhost:8001/api/
# Expected: {"message":"Hello World"}
```

**2. Create Status Check:**
```bash
curl -X POST http://localhost:8001/api/status \
  -H "Content-Type: application/json" \
  -d '{"client_name":"Test User"}'
```

**3. Get Status Checks:**
```bash
curl http://localhost:8001/api/status
```

**4. Interactive API Documentation:**
- Open: `http://localhost:8001/docs`
- Test all endpoints interactively

### Test Frontend

1. Open browser: `http://localhost:3000`
2. Navigate through all sections:
   - Home
   - Skills
   - Projects
   - Education
   - Certifications
   - Hobbies
   - About
   - Contact
3. Test contact form submission
4. Verify responsive design (resize browser window)

---

## 📦 Dependencies Overview

### Backend Dependencies (requirements.txt)

- **fastapi** - Modern web framework
- **uvicorn** - ASGI server
- **motor** - Async MongoDB driver
- **pymongo** - MongoDB driver
- **pydantic** - Data validation
- **python-dotenv** - Environment variable management
- **bcrypt** - Password hashing
- **pyjwt** - JWT token handling
- **pytest** - Testing framework
- **black**, **isort**, **flake8** - Code formatting and linting

### Frontend Dependencies (package.json)

- **react** (v19.0.0) - UI library
- **react-router-dom** - Routing
- **axios** - HTTP client
- **lucide-react** - Icons
- **tailwindcss** - CSS framework
- **@radix-ui/** - UI components
- **shadcn/ui** - Component library

---

## 🚀 Production Build

### Build Frontend for Production

```bash
cd frontend
yarn build
```

This creates an optimized production build in `frontend/build/`.

### Run Backend in Production Mode

```bash
cd backend
source venv/bin/activate
uvicorn server:app --host 0.0.0.0 --port 8001 --workers 4
```

---

## 📞 Support & Contact

If you encounter any issues:

1. Check the [Troubleshooting](#troubleshooting) section
2. Review the error logs in the terminal
3. Contact:
   - **Email**: patilswara4410@gmail.com
   - **LinkedIn**: [Swara Patil](https://www.linkedin.com/in/swara-patil10/)
   - **GitHub**: [Swarapatil10](https://github.com/Swarapatil10)

---

## 📄 Additional Resources

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Node.js Documentation](https://nodejs.org/docs/)
- [Python Documentation](https://docs.python.org/3/)

---

## ✅ Quick Checklist

Before starting development, ensure:

- [ ] Node.js (v18+) installed
- [ ] Yarn (v1.22+) installed
- [ ] Python (v3.10+) installed
- [ ] MongoDB (v4.0+) installed and running
- [ ] Backend dependencies installed (`pip install -r requirements.txt`)
- [ ] Frontend dependencies installed (`yarn install`)
- [ ] Backend `.env` file configured
- [ ] Frontend `.env` file configured
- [ ] MongoDB service running
- [ ] Backend running on port 8001
- [ ] Frontend running on port 3000

---

**Happy Coding! 🎉**

Made with ❤️ by Swara Patil
