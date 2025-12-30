# QuickBooks Online (QBO)

## Webhooks
- Subscribe to Payment, Invoice, or SalesReceipt changes (Sales Receipt for now).
- Validate `intuit-signature` header using the webhook verification token.
- Acknowledge fast; do not block on downstream work.
- Use `https://<ngrok-id>.ngrok.app/webhooks/qbo` or `https://<ngrok-id>.ngrok-free.dev/webhooks/qbo` during local dev.

## OAuth
- Use OAuth2 authorization code flow.
- Store refresh tokens securely.
- Rotate access tokens automatically.

## Data fetch
- Payment -> Invoice -> Customer
- Capture: customer name, phone, invoice id, payment id, amount, date

## Rate limits
- Use backoff + retry on 429.
- Cache customer lookups in Postgres.

## Optional updates
- Write last rating + last contact date to a custom field.
