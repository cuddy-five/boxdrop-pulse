# Node-RED data

This directory is kept for local dev convenience.

- Node-RED uses the named volume `nodered_data` for persistence.
- `data/` is ignored by git and can be used if switching back to bind mounts.
- Import flows from `flows/` into the Node-RED UI.
