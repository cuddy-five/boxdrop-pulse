# Event flow

## 1) QBO webhook
1. QBO sends webhook: entity name + id + realmId.
2. Node-RED verifies Intuit signature.
3. Write event log + dedupe key, enqueue job.
4. Respond 200 OK immediately.

## 2) Worker processing
1. Pull job from Redis.
2. Fetch Payment + Invoice + Customer from QBO API.
3. Create session in Postgres.
4. Send SMS: "How was your experience 1-10?"

## 3) Inbound SMS
1. Twilio posts inbound message webhook.
2. Parse numeric rating or free-text.
3. If rating >= threshold, send review request link.
4. If rating < threshold, alert owner with LLM summary.
5. Update session + logs; optionally update QBO.

## 4) Owner follow-up
1. Owner receives SMS summary and link to session detail.
2. Staff can add notes and close the loop.
