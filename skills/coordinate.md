# Coordinate Skill

Coordinate operations across multiple SpotDrop repositories.

## Usage

```
/coordinate <operation>
```

## Operations

### sync
Synchronize all submodules to their latest commits:
```bash
git submodule update --remote --merge
```

### status
Check status of all repositories:
```bash
echo "=== Workspace ===" && git status
echo "=== Backend ===" && cd spotdrop-backend && git status && cd ..
echo "=== Web ===" && cd spotdrop-web && git status && cd ..
echo "=== macOS ===" && cd spotdrop-macos && git status && cd ..
```

### branch <name>
Create a feature branch in all repos:
```bash
git checkout -b <name>
cd spotdrop-backend && git checkout -b <name> && cd ..
cd spotdrop-web && git checkout -b <name> && cd ..
cd spotdrop-macos && git checkout -b <name> && cd ..
```

### test
Run tests in all repos:
```bash
cd spotdrop-backend && pytest tests/ -v && cd ..
cd spotdrop-web && npm test && cd ..
cd spotdrop-macos && xcodebuild test -scheme SpotDrop -destination 'platform=macOS' && cd ..
```

## Examples

```
/coordinate sync
/coordinate status
/coordinate branch feat/new-feature
/coordinate test
```
