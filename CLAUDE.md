# SpotDrop Workspace

> **CRITICAL: YOU CANNOT MAKE DESTRUCTIVE CHANGES TO THE LOCAL CODEBASE. This includes: git reset --hard, git clean -f, git checkout . on uncommitted work, deleting files/directories without explicit user permission, force pushing, or any operation that could result in loss of local work.**

Location-based spot sharing platform with three components.

## Architecture

```
spotdrop-workspace/
├── spotdrop-backend/    # Python FastAPI REST API
├── spotdrop-web/        # React + Vite + Mapbox web app
└── spotdrop-macos/      # Native SwiftUI macOS app
```

## MANDATORY: Structure Compliance

**All new features MUST follow the established structure in each submodule. Reference the CLAUDE.md in each submodule for detailed requirements.**

### Backend Structure (spotdrop-backend)
```
src/
├── api/routes/     # Thin route handlers (one file per resource)
├── services/       # Business logic (one file per domain)
├── models/         # SQLAlchemy ORM (one file per entity)
├── schemas/        # Pydantic validation (*Create, *Update, *Response)
├── core/           # Config, security, exceptions
└── db/             # Database session
```

### Web Structure (spotdrop-web)
```
src/
├── components/
│   ├── ui/         # Reusable primitives (Button, Card, Input)
│   ├── auth/       # Authentication components
│   ├── map/        # Map components
│   ├── spots/      # Spot feature components
│   └── layout/     # Layout components (Header, Sidebar)
├── stores/         # Zustand state management
├── lib/            # API client (api.ts)
└── types/          # TypeScript types (index.ts)
```

### macOS Structure (spotdrop-macos)
```
SpotDrop/
├── Core/
│   ├── Network/    # APIClient (singleton)
│   ├── Models/     # Codable data structures
│   └── Storage/    # KeychainManager
├── Features/       # MVVM feature modules
│   ├── Auth/       # LoginView, AuthViewModel
│   └── Spots/      # SpotListView, SpotsViewModel, etc.
└── UI/             # Theme, colors, styles
```

## Quick Start

```bash
# Start infrastructure
docker-compose up -d

# Backend (terminal 1)
cd spotdrop-backend
pip install -e ".[dev]"
alembic upgrade head
uvicorn src.main:app --reload --port 8000

# Web (terminal 2)
cd spotdrop-web
npm install
npm run dev

# macOS - Open in Xcode
open spotdrop-macos/SpotDrop.xcodeproj
```

## Services

| Service | URL | Credentials |
|---------|-----|-------------|
| Backend API | http://localhost:8000 | - |
| API Docs | http://localhost:8000/docs | - |
| Web App | http://localhost:5173 | - |
| PostgreSQL | localhost:5432 | spotdrop / spotdrop_dev_password |
| MinIO Console | http://localhost:9001 | spotdrop / spotdrop_minio_password |
| MinIO API | http://localhost:9000 | spotdrop / spotdrop_minio_password |

## Adding a New Feature (Cross-Repo Checklist)

When adding a feature that spans all repos:

### 1. Backend First
- [ ] Create model in `src/models/<entity>.py`
- [ ] Create schemas in `src/schemas/<resource>.py`
- [ ] Create service in `src/services/<domain>.py`
- [ ] Create routes in `src/api/routes/<resource>.py`
- [ ] Register router in `src/main.py`
- [ ] Create migration: `alembic revision --autogenerate`
- [ ] Write tests in `tests/test_<resource>.py`

### 2. Web Second
- [ ] Add types to `src/types/index.ts`
- [ ] Add API methods to `src/lib/api.ts`
- [ ] Create store in `src/stores/<feature>Store.ts`
- [ ] Create components in `src/components/<feature>/`
- [ ] Write tests in `tests/`

### 3. macOS Third
- [ ] Add models to `Core/Models/Models.swift`
- [ ] Add API methods to `Core/Network/APIClient.swift`
- [ ] Create feature folder `Features/<Feature>/`
- [ ] Create ViewModel `Features/<Feature>/<Feature>ViewModel.swift`
- [ ] Create Views `Features/<Feature>/<Feature>View.swift`
- [ ] Write tests in `SpotDropTests/`

## Submodule Agents

### Backend Agents
- `@backend-architect` - API design, database schema, authentication flow
- `@backend-developer` - FastAPI routes, services, models implementation
- `@backend-debugger` - API debugging, database issues, auth problems
- `@backend-reviewer` - Code review for Python/FastAPI code

### Web Agents
- `@web-architect` - React component architecture, state management
- `@web-developer` - React components, Mapbox integration, API calls
- `@web-debugger` - Frontend debugging, map issues, state problems
- `@web-reviewer` - Code review for React/TypeScript code

### macOS Agents
- `@macos-architect` - SwiftUI architecture, MVVM patterns
- `@macos-developer` - SwiftUI views, ViewModels, API integration
- `@macos-debugger` - macOS app debugging, Keychain issues
- `@macos-reviewer` - Code review for Swift/SwiftUI code

### Cross-Repo Agents
- `@cross-repo-architect` - System-wide architecture decisions
- `@cross-repo-coordinator` - Cross-repo changes and consistency

## Skills

### Backend Skills
- `/backend-build` - Build and install backend dependencies
- `/backend-func-start` - Start backend development server
- `/backend-lint` - Run linting on backend code
- `/backend-test` - Run backend tests

### Web Skills
- `/web-build` - Build web app for production
- `/web-func-start` - Start web development server
- `/web-lint` - Run linting on web code
- `/web-test` - Run web tests

### macOS Skills
- `/macos-build` - Build macOS app
- `/macos-func-start` - Run macOS app in simulator
- `/macos-lint` - Run SwiftLint on macOS code
- `/macos-test` - Run macOS tests

### Workspace Skills
- `/coordinate` - Coordinate cross-repo operations

## Git Workflow

All repos use feature branches. Never push directly to main.

```bash
# Update all submodules
git submodule update --remote --merge

# Work in submodule
cd spotdrop-backend
git checkout -b feat/my-feature
# ... make changes ...
git push -u origin feat/my-feature
```

## Environment Variables

Each submodule has a `.env.example` file. Copy to `.env` and fill in values:

```bash
cp spotdrop-backend/.env.example spotdrop-backend/.env
cp spotdrop-web/.env.example spotdrop-web/.env
```

**Never commit .env files!**
