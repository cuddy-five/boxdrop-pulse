# Twilio

## Outbound
- Use a single branded sender number or Messaging Service.
- Log message SID for audit and status callbacks.

## Inbound
- Validate Twilio signature on inbound webhooks.
- Parse rating numbers and handle keywords: STOP, STOPALL, UNSUBSCRIBE.

## Status callbacks
- Capture delivery status and error codes.
- Retry on transient failures; alert owner on hard failures.
