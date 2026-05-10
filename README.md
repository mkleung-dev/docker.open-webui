# Open WebUI Docker Setup

This folder runs Open WebUI using Docker Compose.

## What This Provides

- Open WebUI service running on port `3000`
- Persistent application data via Docker volume
- One command interface via `Makefile`
- Optional environment-based customization via `.env`

## Prerequisites

- Docker Engine and Docker Compose plugin installed
- GNU Make installed (`make --version`)

## Quick Start

1. Copy env template (optional but recommended):

```bash
cp .env.example .env
```

2. Start Open WebUI:

```bash
make run
```

3. Open the app:

- http://localhost:3000

## Commands

Run this to see all commands:

```bash
make help
```

Main commands:

- `make setup` : Prepare environment defaults and validate Docker availability
- `make run` : Start container in background
- `make stop` : Stop running container
- `make restart` : Restart container
- `make update` : Pull latest image and recreate container
- `make logs` : Follow logs
- `make status` : Show container status
- `make delete` : Remove container, network, and volume (destructive)

## Configuration

Create `.env` from template and adjust as needed:

```bash
cp .env.example .env
```

Supported variables:

- `CONTAINER_NAME` (default: `open-webui`)
- `IMAGE` (default: `ghcr.io/open-webui/open-webui:main`)
- `HOST_PORT` (default: `3000`)
- `CONTAINER_PORT` (default: `8080`)
- `DATA_VOLUME` (default: `open-webui`)
- `RESTART_POLICY` (default: `unless-stopped`)

## Data Persistence

Open WebUI data is stored in Docker volume `open-webui` by default and mounted into `/app/backend/data`.

## Delete / Reset

To remove everything (including persistent data):

```bash
make delete
```

This operation is destructive and asks for explicit confirmation.

## Troubleshooting

1. Port already in use:

- Change `HOST_PORT` in `.env`, then run `make restart`.

2. Container not starting:

- Check logs with `make logs`.
- Check status with `make status`.

3. Docker permission issue:

- Ensure your user can run Docker commands without sudo.
