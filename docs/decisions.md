# Decisions and open questions

## Open questions
- What QBO entity change should trigger the flow (Payment, Invoice, SalesReceipt)?  **Sales Receipt** for now.
- How to map QBO customer to a verified phone number?  **Hoping QB**
- What is the acceptable response window for rating?  **2 days**
- Should we allow multiple ratings per customer per period?  **Only one**
- What is the policy for review requests (avoid review gating)?  **Request Reviews 4-5 out of 5**

## Decisions (to record)
- Queue: Redis vs. Postgres job table
- Summary model and provider
- Opt-out handling (global vs. per store)
- Data retention window
