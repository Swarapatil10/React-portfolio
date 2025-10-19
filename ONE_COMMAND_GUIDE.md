# 🚀 One-Command Installation Guide

This file contains single-command solutions for setting up the Portfolio Website on your local machine.

---

## 📋 Prerequisites Installation

### Install All Prerequisites (macOS with Homebrew)

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all prerequisites in one command
brew install node yarn mongodb-community python@3.11 && brew services start mongodb-community
```

### Install All Prerequisites (Ubuntu/Debian Linux)

```bash
# Update and install everything in one command
sudo apt update && sudo apt install -y nodejs npm python3 python3-pip python3-venv mongodb && sudo npm install -g yarn && sudo systemctl start mongodb && sudo systemctl enable mongodb
```

### Install All Prerequisites (Windows with Chocolatey)

```powershell
# Install Chocolatey (if not installed) - Run as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install all prerequisites
choco install -y nodejs yarn python mongodb
```

---

## ⚡ Complete Setup + Start (One Command)

### For Unix/Linux/macOS:

**Copy and paste this ENTIRE command into your terminal:**

```bash
cd backend && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && cd ../frontend && yarn install && cd .. && mkdir -p data/db logs && (mongod --dbpath ./data/db --fork --logpath ./data/mongodb.log 2>/dev/null || brew services start mongodb-community 2>/dev/null || sudo systemctl start mongod 2>/dev/null) && cd backend && source venv/bin/activate && nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 & echo $! > ../logs/backend.pid && cd ../frontend && nohup yarn start > ../logs/frontend.log 2>&1 & echo $! > ../logs/frontend.pid && cd .. && sleep 5 && echo "✅ Setup Complete!" && echo "Frontend: http://localhost:3000" && echo "Backend: http://localhost:8001" && echo "API Docs: http://localhost:8001/docs"
```

**Or use the provided script (Recommended):**

```bash
chmod +x quick_start.sh && ./quick_start.sh
```

### For Windows (PowerShell):

```powershell
# Run in project root directory
.\start_local.ps1
```

### For Windows (CMD):

```cmd
start_local.bat
```

---

## 📦 Install Dependencies Only

### Backend Only:

```bash
cd backend && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt
```

**Windows:**
```cmd
cd backend && python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt
```

### Frontend Only:

```bash
cd frontend && yarn install
```

---

## 🏃 Start Services Only (Assuming Dependencies Installed)

### Start All Services (Unix/Linux/macOS):

```bash
(mongod --dbpath ./data/db --fork --logpath ./data/mongodb.log 2>/dev/null || brew services start mongodb-community 2>/dev/null || sudo systemctl start mongod 2>/dev/null) && cd backend && source venv/bin/activate && nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 & echo $! > ../logs/backend.pid && cd ../frontend && nohup yarn start > ../logs/frontend.log 2>&1 & echo $! > ../logs/frontend.pid && cd .. && echo "✅ All services started!"
```

### Start Individual Services:

**MongoDB:**
```bash
# macOS
brew services start mongodb-community

# Linux
sudo systemctl start mongod

# Manual (all platforms)
mongod --dbpath ./data/db
```

**Backend:**
```bash
cd backend && source venv/bin/activate && uvicorn server:app --reload --host 0.0.0.0 --port 8001
```

**Frontend:**
```bash
cd frontend && yarn start
```

---

## 🛑 Stop All Services (One Command)

### Unix/Linux/macOS:

```bash
kill $(cat logs/backend.pid) $(cat logs/frontend.pid) 2>/dev/null; brew services stop mongodb-community 2>/dev/null || sudo systemctl stop mongod 2>/dev/null; rm logs/*.pid 2>/dev/null; echo "✅ All services stopped"
```

**Or use the script:**
```bash
./stop_local.sh
```

---

## 🔧 Complete Reset and Reinstall (One Command)

### Clean Everything and Start Fresh:

```bash
# ⚠️ WARNING: This will delete node_modules, venv, and reinstall everything
rm -rf frontend/node_modules backend/venv logs/*.log && cd backend && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && cd ../frontend && yarn install && cd .. && echo "✅ Reset complete! Run ./start_local.sh to start"
```

---

## 🧪 Test Everything (One Command)

### Quick Health Check:

```bash
curl -s http://localhost:8001/api/ && curl -s -o /dev/null -w "Frontend: %{http_code}\n" http://localhost:3000 && echo "✅ All services responding"
```

---

## 📊 View Status and Logs (One Command)

### Check All Services:

```bash
echo "=== Service Status ===" && ps aux | grep -E 'uvicorn|react-scripts|mongod' | grep -v grep && echo -e "\n=== Recent Backend Logs ===" && tail -5 logs/backend.log && echo -e "\n=== Recent Frontend Logs ===" && tail -5 logs/frontend.log
```

---

## 🎯 Common One-Liner Commands

### Install Everything:
```bash
./quick_start.sh
```

### Start Services:
```bash
./start_local.sh
```

### Stop Services:
```bash
./stop_local.sh
```

### View Backend Logs:
```bash
tail -f logs/backend.log
```

### View Frontend Logs:
```bash
tail -f logs/frontend.log
```

### Restart Backend:
```bash
kill $(cat logs/backend.pid) && cd backend && source venv/bin/activate && nohup uvicorn server:app --reload --host 0.0.0.0 --port 8001 > ../logs/backend.log 2>&1 & echo $! > ../logs/backend.pid && cd ..
```

### Restart Frontend:
```bash
kill $(cat logs/frontend.pid) && cd frontend && nohup yarn start > ../logs/frontend.log 2>&1 & echo $! > ../logs/frontend.pid && cd ..
```

---

## 🐛 Troubleshooting One-Liners

### Kill Process on Port 3000:
```bash
lsof -ti:3000 | xargs kill -9 2>/dev/null || echo "Port 3000 is free"
```

### Kill Process on Port 8001:
```bash
lsof -ti:8001 | xargs kill -9 2>/dev/null || echo "Port 8001 is free"
```

### Check MongoDB Status:
```bash
mongosh --eval "db.adminCommand('ping')" 2>/dev/null && echo "✅ MongoDB is running" || echo "❌ MongoDB is not running"
```

### Clear All Caches:
```bash
rm -rf frontend/node_modules/.cache backend/__pycache__ backend/**/__pycache__ && echo "✅ Caches cleared"
```

---

## 📌 Quick Reference Table

| Action | Command |
|--------|---------|
| **Quick Start** | `./quick_start.sh` |
| **Standard Start** | `./start_local.sh` |
| **Stop All** | `./stop_local.sh` |
| **Install Backend** | `cd backend && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt` |
| **Install Frontend** | `cd frontend && yarn install` |
| **Start Backend** | `cd backend && source venv/bin/activate && uvicorn server:app --reload --host 0.0.0.0 --port 8001` |
| **Start Frontend** | `cd frontend && yarn start` |
| **Test API** | `curl http://localhost:8001/api/` |
| **View Logs** | `tail -f logs/backend.log logs/frontend.log` |

---

## 🎉 The Ultimate One-Command Setup

**For the absolute quickest start on Unix/Linux/macOS:**

```bash
chmod +x quick_start.sh && ./quick_start.sh
```

**This single command will:**
- ✅ Check all prerequisites
- ✅ Create necessary directories
- ✅ Set up Python virtual environment
- ✅ Install all Python dependencies
- ✅ Install all Node.js dependencies
- ✅ Configure environment files
- ✅ Start MongoDB
- ✅ Start Backend (FastAPI)
- ✅ Start Frontend (React)
- ✅ Display all URLs and PIDs
- ✅ Open browser automatically

**Total time: ~2-3 minutes** (depending on internet speed)

---

## 💡 Pro Tips

1. **Bookmark these URLs:**
   - Frontend: http://localhost:3000
   - Backend: http://localhost:8001
   - API Docs: http://localhost:8001/docs

2. **Add aliases to your shell:**
   ```bash
   # Add to ~/.bashrc or ~/.zshrc
   alias portfolio-start='cd /path/to/portfolio && ./start_local.sh'
   alias portfolio-stop='cd /path/to/portfolio && ./stop_local.sh'
   alias portfolio-logs='cd /path/to/portfolio && tail -f logs/backend.log logs/frontend.log'
   ```

3. **Quick status check:**
   ```bash
   # Add this function to your shell
   portfolio-status() {
       echo "Backend: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:8001/api/)"
       echo "Frontend: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:3000)"
   }
   ```

---

**Remember:** All these commands assume you're in the project root directory!

**Need Help?** Check `LOCAL_SETUP_README.md` for detailed documentation.
