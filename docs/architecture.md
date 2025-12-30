# Architecture

## Overview
This system uses Node-RED for orchestration, Redis for a lightweight queue, Postgres for state/logs, Twilio for SMS, and an LLM for complaint summaries. QBO webhooks are acknowledged quickly and processed asynchronously.

## Mermaid
```mermaid
flowchart LR
  QBO["QuickBooks Online"] -->|"Webhook: entity changed (id + realmId)"| NRIN["Node-RED: webhook receiver\nverify Intuit signature\nenqueue job + ACK fast"]
  NRIN -->|"200 OK immediately"| QBO

  NRIN --> RQ[(Redis queue)]
  RQ --> NRW["Node-RED worker flow\nfetch Payment + Invoice + Customer via QBO API"]
  NRW --> QBO
  NRW --> PG[(Postgres: sessions + logs + opt-outs + dedupe)]

  NRW -->|"POST send SMS"| TW["Twilio Messaging API"]
  CUST["Customer phone"] <--> |"SMS"| TW
  TW -->|"Inbound SMS webhook (From + Body)"| NRSMS["Node-RED inbound SMS handler\nparse rating + branch"]
  NRSMS --> PG
  NRSMS -->|"Low score"| OWNER["Owner alert + follow-up task"]
  NRSMS -->|"High score"| TW
```

## Key components
- Webhook receiver: validates Intuit signature, enqueues job, responds fast.
- Worker flow: fetches QBO entities, writes session + logs, triggers SMS.
- SMS handler: parses rating, handles opt-outs, branches to review or owner alert.
- Storage: Postgres for durable state and audit; Redis for queue and dedupe.

## Principles
- Idempotent at every hop.
- Minimal PII in logs.
- Compliance-first SMS handling.
- Observable with structured logs and event IDs.
