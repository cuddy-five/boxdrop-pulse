# Runbook

## Background
The owner’s vision is to automatically text customers after a purchase, collect a 1–10 experience rating, and then route follow‑up based on the score. Low scores trigger an owner alert with an AI‑summarized issue, while high scores send a follow‑up asking for a Google review (or similar).

## Current status (last known)
- Docker services are running: Node-RED, ngrok, Postgres, Redis.
- ngrok tunnel is configured with an authtoken; public URL is obtained via `http://localhost:4040`.
- Node-RED minimal webhook flow responds `200 OK` with `ok` on `/webhooks/qbo`.
- Intuit sandbox app exists but is still being wired to the webhook URL.

## Environment facts
- Compose file: `infra/docker-compose.yml`.
- Node-RED UI: `http://localhost:1880`.
- ngrok inspector: `http://localhost:4040`.
- Node-RED uses a named volume `nodered_data` (avoids host permission issues).

## Local dev
- Start stack with `infra/docker-compose.yml`.
- Open Node-RED and import flows from `flows/`.
- Use ngrok (or similar) for webhook URLs.

### Minimal webhook smoke test
1) Ensure `NGROK_AUTHTOKEN` is set in `.env`.
2) Start services:
   ```bash
   docker compose --env-file .env -f infra/docker-compose.yml up -d
   ```
3) Build a minimal Node-RED flow:
   - `http in` POST `/webhooks/qbo` -> `debug`
   - `http in` -> `function` -> `http response`
   - Function body:
     ```js
     msg.statusCode = 200;
     msg.payload = "ok";
     return msg;
     ```
4) Verify locally:
   ```bash
   curl -i http://localhost:1880/webhooks/qbo \
     -H 'Content-Type: application/json' \
     -d '{"ping":"test"}'
   ```
5) Open `http://localhost:4040` and copy the public ngrok URL.
6) In Intuit Developer, set Webhooks URL to `{NGROK_URL}/webhooks/qbo`.
   - Example: `https://<id>.ngrok-free.dev/webhooks/qbo`

## Known issues and fixes
- If ngrok exits with ERR_NGROK_4018, set `NGROK_AUTHTOKEN` in `.env` and restart ngrok.
- If Node-RED cannot write to `/data`, ensure the compose file uses the `nodered_data` named volume.

## Webhooks
- QBO webhook URL: `{BASE_URL}/webhooks/qbo`.
- Twilio inbound URL: `{BASE_URL}/webhooks/twilio/inbound`.
- Twilio status callback: `{BASE_URL}/webhooks/twilio/status`.

## Failure modes
- QBO webhook signature invalid -> log and return 401.
- QBO rate limit -> retry with backoff.
- SMS send failure -> log and alert owner.
- LLM failure -> send raw customer text to owner.

## Manual actions
- Add phone to opt_outs if requested by customer.
- Requeue failed jobs by event id.
- Update QBO customer notes with latest rating.

## Session notes (update each work session)
- Date: 2025-12-30
- What was done: Brought up local stack, fixed Node-RED persistence by switching to named volume, configured ngrok authtoken, created minimal Node-RED webhook flow.
- What worked: `POST /webhooks/qbo` returns `200 OK` with `ok`; Node-RED UI reachable; ngrok tunnel active.
- What is blocked: Intuit sandbox webhook wiring still in progress.
- Next step: Set Intuit webhook URL to the current ngrok URL and confirm requests land in Debug.
- Current ngrok URL: https://jayse-windburned-lexicographically.ngrok-free.dev

## Next steps (short list)
- Connect Intuit webhook to the ngrok URL and verify POSTs land in Node-RED Debug.
- Add Intuit signature validation to the webhook flow.
- Implement a real enqueue + worker flow (Redis + Postgres logging).
- Wire Twilio inbound/outbound handlers.
