# Swara Patil - Personal Portfolio Website

A modern, professional portfolio website built with React (frontend) and FastAPI (backend), showcasing skills, projects, education, certifications, and more.

## 🌟 Features

- **Responsive Design**: Fully responsive layout that works seamlessly on desktop, tablet, and mobile devices
- **Modern UI/UX**: Clean, professional design with blue background and orange accent colors
- **Multiple Sections**:
  - Home with animated hero section
  - Skills showcase with icons
  - Featured projects with descriptions and links
  - Education timeline
  - Professional certifications
  - Hobbies and interests
  - About me section
  - Contact form
- **Smooth Navigation**: Sticky header with smooth scroll to sections
- **Interactive Elements**: Hover effects, animations, and transitions
- **Social Links**: GitHub, LinkedIn, and Email integration

## 🛠️ Tech Stack

### Frontend
- React 19.0.0
- React Router DOM 7.5.1
- Lucide React (for icons)
- Axios (for API calls)
- Tailwind CSS
- shadcn/ui components

### Backend
- FastAPI 0.110.1
- Motor (MongoDB async driver)
- Python 3.x
- MongoDB

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- **Node.js** (v18 or higher) - [Download Node.js](https://nodejs.org/)
- **Yarn** (v1.22 or higher) - Install via: `npm install -g yarn`
- **Python** (v3.10 or higher) - [Download Python](https://www.python.org/downloads/)
- **MongoDB** (v4.0 or higher) - [Download MongoDB](https://www.mongodb.com/try/download/community)
- **pip** (Python package manager) - Usually comes with Python

### Verify Installation

```bash
# Check Node.js version
node --version

# Check Yarn version
yarn --version

# Check Python version
python --version
# or
python3 --version

# Check MongoDB is running
mongod --version
```

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone <your-repository-url>

# Navigate to the project directory
cd portfolio-website
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create a virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Create .env file for backend
touch .env
```

**Configure Backend `.env` file:**

Open `backend/.env` and add:

```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
```

### Step 3: Start MongoDB

Make sure MongoDB is running on your local machine:

```bash
# On macOS (if installed via Homebrew)
brew services start mongodb-community

# On Linux
sudo systemctl start mongod

# On Windows
# MongoDB should start automatically if installed as a service
# Or run: mongod --dbpath <path-to-data-directory>
```

### Step 4: Frontend Setup

```bash
# Navigate to frontend directory (from project root)
cd frontend

# Install dependencies using Yarn
yarn install

# Create .env file for frontend
touch .env
```

**Configure Frontend `.env` file:**

Open `frontend/.env` and add:

```env
REACT_APP_BACKEND_URL=http://localhost:8001
```

## 🏃‍♂️ Running the Application

### Start Backend Server

```bash
# From the backend directory
cd backend

# Make sure virtual environment is activated
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Start FastAPI server
uvicorn server:app --reload --host 0.0.0.0 --port 8001
```

The backend will start at: `http://localhost:8001`

### Start Frontend Development Server

Open a new terminal window/tab:

```bash
# From the frontend directory
cd frontend

# Start React development server
yarn start
```

The frontend will automatically open at: `http://localhost:3000`

## 📂 Project Structure

```
portfolio-website/
├── frontend/                 # React frontend application
│   ├── public/              # Public assets
│   │   └── index.html       # HTML template
│   ├── src/
│   │   ├── components/      # React components
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
│   │   ├── App.js           # Main App component
│   │   ├── App.css          # Global styles
│   │   └── index.css        # Tailwind imports
│   ├── package.json         # Frontend dependencies
│   └── .env                 # Frontend environment variables
│
├── backend/                 # FastAPI backend application
│   ├── server.py           # Main FastAPI application
│   ├── requirements.txt    # Python dependencies
│   └── .env                # Backend environment variables
│
└── README.md               # This file
```

## 🔧 Available Scripts

### Frontend Scripts

```bash
# Start development server
yarn start

# Build for production
yarn build

# Run tests
yarn test
```

### Backend Scripts

```bash
# Start development server with auto-reload
uvicorn server:app --reload --host 0.0.0.0 --port 8001

# Run linting
black .
isort .
flake8 .

# Run tests
pytest
```

## 🌐 API Endpoints

The backend provides the following API endpoints:

- `GET /api/` - Health check endpoint
- `POST /api/status` - Create status check
- `GET /api/status` - Get all status checks

## 🎨 Customization

### Changing Colors

Edit the CSS variables in `frontend/src/App.css` and `frontend/src/index.css`:

```css
/* Example: Change primary color */
background: linear-gradient(135deg, #your-color-1 0%, #your-color-2 100%);
```

### Adding New Sections

1. Create a new component in `frontend/src/components/`
2. Import and add it to `App.js`
3. Add navigation link in `Header.jsx`

### Modifying Content

Edit the respective component files:
- Personal info: `Home.jsx`
- Skills: `Skills.jsx`
- Projects: `Projects.jsx`
- Education: `Education.jsx`
- etc.

## 🐛 Troubleshooting

### Port Already in Use

If you get a port already in use error:

```bash
# For frontend (port 3000)
lsof -ti:3000 | xargs kill -9

# For backend (port 8001)
lsof -ti:8001 | xargs kill -9
```

### MongoDB Connection Issues

Make sure MongoDB is running:

```bash
# Check MongoDB status
# macOS:
brew services list | grep mongodb

# Linux:
sudo systemctl status mongod
```

### Module Not Found Errors

```bash
# Frontend
cd frontend
rm -rf node_modules yarn.lock
yarn install

# Backend
cd backend
pip install --upgrade -r requirements.txt
```

## 📦 Building for Production

### Frontend Production Build

```bash
cd frontend
yarn build
```

This creates an optimized production build in the `build/` directory.

### Backend Production Deployment

```bash
cd backend
uvicorn server:app --host 0.0.0.0 --port 8001 --workers 4
```

## 📝 Environment Variables

### Frontend (.env)

```env
REACT_APP_BACKEND_URL=http://localhost:8001
```

### Backend (.env)

```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=portfolio_db
```

## 🤝 Contributing

Feel free to fork this project and customize it for your own portfolio!

## 📧 Contact

- **Email**: patilswara4410@gmail.com
- **LinkedIn**: [Swara Patil](https://www.linkedin.com/in/swara-patil10/)
- **GitHub**: [Swarapatil10](https://github.com/Swarapatil10)

## 📄 License

This project is open source and available for personal use.

---

**Made with ❤️ by Swara Patil**
