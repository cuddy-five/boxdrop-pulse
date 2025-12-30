# Data model

## Tables (initial)
- customers
  - id (uuid)
  - qbo_customer_id (text, unique)
  - phone_e164 (text)
  - display_name (text)
  - created_at (timestamptz)

- events
  - id (uuid)
  - qbo_entity_type (text)
  - qbo_entity_id (text)
  - realm_id (text)
  - event_time (timestamptz)
  - payload (jsonb)
  - status (text)
  - processed_at (timestamptz)

- sessions
  - id (uuid)
  - customer_id (uuid)
  - qbo_payment_id (text)
  - qbo_invoice_id (text)
  - rating (int)
  - review_requested (bool)
  - complaint_summary (text)
  - status (text)
  - created_at (timestamptz)
  - updated_at (timestamptz)

- sms_messages
  - id (uuid)
  - session_id (uuid)
  - direction (text)
  - body (text)
  - twilio_message_sid (text)
  - created_at (timestamptz)

- opt_outs
  - phone_e164 (text, unique)
  - source (text)
  - created_at (timestamptz)

- dedupe_keys
  - key (text, primary key)
  - created_at (timestamptz)

## Notes
- Use dedupe_keys to prevent double-processing of webhook events.
- Store minimal PII; avoid free-text unless needed for complaint context.
