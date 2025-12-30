# Security

## Secrets
- Store QBO, Twilio, and LLM secrets in a managed secret store.
- Do not commit `.env` or credentials.

## Webhook verification
- Validate QBO Intuit signature on every request.
- Validate Twilio signature for inbound SMS callbacks.

## PII
- Store minimal PII (phone + name).
- Set retention policy for message bodies.
- Mask phone numbers in logs where possible.

## Access
- Limit Node-RED admin access with strong auth.
- Restrict DB access to internal network.
