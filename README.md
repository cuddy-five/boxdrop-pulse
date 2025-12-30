
# Boxdrop CS

Customer feedback automation for Boxdrop Mattress. When a customer purchase updates in QuickBooks Online (QBO), the system asks for a 1-10 SMS rating, routes positive feedback to a Google review request, and escalates negative feedback to the owner with an LLM summary. Data is logged for auditing, opt-outs, and dedupe.

## Goals
- Respond to QBO purchase events quickly and reliably.
- Collect a simple 1-10 customer experience rating over SMS.
- Route high scores to a review request and low scores to owner follow-up.
- Maintain compliance (opt-out handling, PII minimization).
- Keep an auditable trail of events, messages, and outcomes.

## Architecture (high level)
- QBO webhook -> Node-RED webhook receiver -> Redis queue
- Node-RED worker fetches QBO data, writes to Postgres
- Twilio sends/receives SMS
- LLM summarizes complaints for owner alerts

See `docs/architecture.md` and `docs/event-flow.md` for details.

## Repo layout
- `docs/` product, architecture, and integration notes
- `flows/` Node-RED flow stubs
- `infra/` local dev infra (docker compose)
- `.env.example` environment variables

## Quick start (local)
1) Copy `.env.example` to `.env` and fill in values.
2) Start services:

```bash
docker compose --env-file .env -f infra/docker-compose.yml up -d
```

3) Open Node-RED at `http://localhost:1880` and import flows from `flows/`.
4) Configure webhook URLs in QBO and Twilio using your tunnel (ngrok or similar).

## Notes
- QBO webhooks should respond fast (ack immediately, process async).
- SMS opt-out must be honored for compliance.
- Review gating may violate platform policies; see `docs/integrations/google-reviews.md`.

## Next
Start with `docs/requirements.md` and `docs/decisions.md` to finalize scope.
>>>>>>> a1e00eb (choose the local README.md and .gitignore over web-side)
