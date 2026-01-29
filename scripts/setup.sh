#!/bin/bash
set -e

echo "=== SpotDrop Setup ==="

# Check prerequisites
command -v docker >/dev/null 2>&1 || { echo "Docker is required but not installed. Aborting." >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "Python 3 is required but not installed. Aborting." >&2; exit 1; }
command -v node >/dev/null 2>&1 || { echo "Node.js is required but not installed. Aborting." >&2; exit 1; }

# Initialize submodules
echo "Initializing submodules..."
git submodule update --init --recursive

# Start Docker services
echo "Starting Docker services..."
docker-compose up -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 5

# Setup backend
echo "Setting up backend..."
cd spotdrop-backend
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Created .env from .env.example - please update with your values"
fi
python3 -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
alembic upgrade head
deactivate
cd ..

# Setup web
echo "Setting up web..."
cd spotdrop-web
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Created .env from .env.example - please add your Mapbox token"
fi
npm install
cd ..

echo ""
echo "=== Setup Complete ==="
echo ""
echo "To start development:"
echo ""
echo "  Backend:  cd spotdrop-backend && source .venv/bin/activate && uvicorn src.main:app --reload"
echo "  Web:      cd spotdrop-web && npm run dev"
echo "  macOS:    open spotdrop-macos/SpotDrop.xcodeproj"
echo ""
echo "Services:"
echo "  API Docs:      http://localhost:8000/docs"
echo "  Web App:       http://localhost:5173"
echo "  MinIO Console: http://localhost:9001"
