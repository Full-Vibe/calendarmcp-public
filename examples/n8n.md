# n8n + CalendarMCP

Use the **MCP Client** node (n8n 1.x or later with MCP support).

## Setup

1. Add an **MCP Client** credential:
   - **Transport:** HTTP
   - **URL:** `https://calendarmcp.ai/api/mcp`
   - **Header:** `Authorization: Bearer YOUR_CALENDARMCP_API_KEY`

2. In your workflow, add an **MCP Client** node, select your credential, then pick a tool from the dropdown (`list_events`, `create_event`, etc.).

## Example: morning briefing

```
Trigger (Cron, weekdays 7am)
  ↓
MCP Client: list_events
  timeMin: {{ $now.toISO() }}
  timeMax: {{ $now.plus({days: 1}).toISO() }}
  ↓
OpenAI: summarize the day
  ↓
Send (Slack / email)
```

## Example: batch reschedule

```
Webhook (POST /reschedule-fridays)
  ↓
MCP Client: list_events (search="Friday team")
  ↓
Code: build batch payload (shift each event +7 days)
  ↓
MCP Client: batch_update_events
  events: {{ $json.payload }}
```
