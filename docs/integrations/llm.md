# LLM summary

## Purpose
Summarize low ratings into a short owner alert: issue type, sentiment, and any urgent callback needs.

## Inputs
- Customer rating (numeric)
- Free-text response
- Customer name + phone
- Invoice/payment context

## Output format (example)
- Summary: "Late delivery, mattress damaged on arrival"
- Severity: High
- Action: "Call customer today"

## Safety
- Redact phone numbers from prompt where possible.
- Do not log full prompt in plain text.
- Fallback to raw message if model is unavailable.
