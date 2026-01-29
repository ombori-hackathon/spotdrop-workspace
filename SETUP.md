# SpotDrop Setup Guide

## Prerequisites

- Docker Desktop
- Python 3.11
- Node.js 18+
- Xcode 15+ (for macOS app)

## 1. Start Infrastructure

```bash
cd /Users/bodda/Desktop/spot-drop
docker-compose up -d
```

This starts PostgreSQL and MinIO.

## 2. Backend Setup

```bash
cd spotdrop-backend

# Create virtual environment
/opt/homebrew/bin/python3.11 -m venv .venv

# Activate venv
source .venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -e ".[dev]"
pip install email-validator

# Copy and configure environment file
cp .env.example .env
# Edit .env with your database and MinIO credentials

# Run migrations
alembic upgrade head

# Start server
uvicorn src.main:app --reload --port 8000
```

**API available at:** http://localhost:8000/docs

## 3. Web Setup

```bash
cd spotdrop-web

# Install dependencies
npm install

# Copy and configure environment file
cp .env.example .env
# Edit .env and add your Mapbox public token

# Start dev server
npm run dev
```

**Web app available at:** http://localhost:5173

## 4. macOS Setup

1. Open Xcode project:
   ```bash
   open spotdrop-macos/SpotDrop/SpotDrop.xcodeproj
   ```

2. In Xcode, add the Swift source files to the project:
   - Right-click "SpotDrop" folder → Add Files to "SpotDrop"
   - Select the `Core`, `Features`, and `UI` folders
   - Ensure "Create groups" is selected
   - Click Add

3. Build and run with `Cmd+R`

### Network Access (Sandbox)

The macOS app is sandboxed and can't access localhost by default. You need to enable network access:

1. In Xcode, select the SpotDrop project in the navigator (top item)
2. Select the SpotDrop target
3. Go to Signing & Capabilities tab
4. Find App Sandbox section
5. Check **Outgoing Connections (Client)**

Or alternatively, remove the sandbox for development:

1. Same location (Signing & Capabilities)
2. Click the X on App Sandbox to remove it

## Running Tests

### Backend
```bash
cd spotdrop-backend
source .venv/bin/activate
pytest tests/ -v
```

### Web
```bash
cd spotdrop-web
npm run test
```

### macOS
```bash
cd spotdrop-macos/SpotDrop
xcodebuild test -scheme SpotDrop -destination 'platform=macOS'
```

## Services

| Service | URL |
|---------|-----|
| Backend API | http://localhost:8000 |
| API Docs | http://localhost:8000/docs |
| Web App | http://localhost:5173 |
| MinIO Console | http://localhost:9001 |

## Stopping Services

```bash
# Stop Docker containers
cd /Users/bodda/Desktop/spot-drop
docker-compose down

# Stop backend (Ctrl+C in terminal)
# Stop web (Ctrl+C in terminal)
```
