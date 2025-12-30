# Node-RED flows

Import these JSON files into Node-RED (Menu -> Import).

## Files
- `inbound-webhook.json`: QBO webhook receiver + enqueue
- `worker-flow.json`: fetch QBO data + send SMS
- `sms-handler.json`: parse inbound SMS + branch

These are placeholders; replace comment nodes with real flows.

## Minimal manual flow (smoke test)
Build this in the Node-RED UI before wiring full logic:
- `http in` POST `/webhooks/qbo` -> `debug`
- `http in` -> `function` -> `http response`
- Function body:
  ```js
  msg.statusCode = 200;
  msg.payload = "ok";
  return msg;
  ```
