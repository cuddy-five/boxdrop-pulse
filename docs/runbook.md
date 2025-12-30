# Runbook

## Local dev
- Start stack with `infra/docker-compose.yml`.
- Open Node-RED and import flows from `flows/`.
- Use ngrok (or similar) for webhook URLs.

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
