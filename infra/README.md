# Infra

Local development stack using Docker Compose.

## Services
- Node-RED: `http://localhost:1880`
- ngrok inspector: `http://localhost:4040`
- Postgres: `localhost:5432`
- Redis: `localhost:6379`

## Volumes
- Node-RED uses a named volume `nodered_data` to avoid host permission issues.
- Postgres and Redis use local bind mounts under `infra/`.

## Common commands
```bash
docker compose --env-file .env -f infra/docker-compose.yml up -d

docker compose -f infra/docker-compose.yml down
```
