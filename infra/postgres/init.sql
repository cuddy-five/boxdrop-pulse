CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS customers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  qbo_customer_id text UNIQUE,
  phone_e164 text,
  display_name text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  qbo_entity_type text NOT NULL,
  qbo_entity_id text NOT NULL,
  realm_id text NOT NULL,
  event_time timestamptz,
  payload jsonb,
  status text DEFAULT 'received',
  processed_at timestamptz
);

CREATE TABLE IF NOT EXISTS sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id uuid REFERENCES customers(id),
  qbo_payment_id text,
  qbo_invoice_id text,
  rating int,
  review_requested boolean DEFAULT false,
  complaint_summary text,
  status text DEFAULT 'open',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS sms_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid REFERENCES sessions(id),
  direction text NOT NULL,
  body text,
  twilio_message_sid text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS opt_outs (
  phone_e164 text PRIMARY KEY,
  source text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS dedupe_keys (
  key text PRIMARY KEY,
  created_at timestamptz DEFAULT now()
);
