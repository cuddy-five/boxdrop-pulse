# Requirements

## Functional
- Receive QBO webhooks for payment/invoice/customer changes.
- Validate Intuit signature and acknowledge quickly.
- Queue jobs for downstream processing (idempotent).
- Fetch Payment + Invoice + Customer details via QBO API.
- Send SMS asking for 1-10 rating.
- Parse inbound SMS for rating or free-text.
- If rating >= threshold: request a public review link.
- If rating < threshold: notify owner with summary + contact info.
- Log all events, messages, and outcomes.
- Respect opt-out keywords and Do Not Contact lists.
- Optionally update QBO customer record with last rating.

## Non-functional
- Webhook ACK within 2 seconds.
- Idempotent processing for duplicate events.
- Store minimal PII and define retention windows.
- Traceability: link message -> session -> QBO entities.
- Retries for transient failures with backoff.
- Clear audit trail for SMS sends and owner alerts.
