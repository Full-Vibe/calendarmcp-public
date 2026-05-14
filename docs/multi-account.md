# Multi-account, one API key

A CalendarMCP API key is **account-scoped**, not calendar-scoped. Connect any number of Google accounts under it. Calls that omit `calendarId` fan out across every enabled calendar in parallel and return merged, time-sorted results.

## Why this matters

Most people have at least two calendars (work + personal). Founders typically have three or more (personal, work, side project, partner's, family). Existing MCP servers force you to mint a separate key per account and write per-account routing in your agent prompt. CalendarMCP collapses that.

## How to add accounts

Dashboard → **Connections → Add account**. Pick OAuth (for normal accounts) or Service-account sharing (for Google Advanced Protection users or org-policy-locked accounts). Repeat for each account.

The dashboard shows per-connection health: ✅ healthy, ⚠️ token expired (one-click reconnect), ❌ revoked (must reconnect).

## How fan-out works

`list_events` (and `find_free_time`) without `calendarId`:

1. Resolve every calendar the key has Read on, across every connection.
2. Fire one Google API call per connection, in parallel.
3. Merge results, sort by start time.
4. Return labelled with `calendarId` and (optionally) a friendly `connectionLabel` so you know which account each event came from.

`create_event` and other write tools require an explicit `calendarId` — we won't guess which account to put an event on.

## Example prompts

```
"What do I have next Tuesday afternoon across all my calendars?"
"Find a 30-minute window next week when both my work and personal calendars are free."
"List every conflict between my work calendar and my partner's shared family calendar this month."
"Show me everything I have between now and the World Cup final."
```

## Multi-account + per-calendar permissions

The Read/Write matrix on the dashboard works on the union: every calendar from every connection is a row. Uncheck Write on your partner's shared family calendar if you want the agent to read-only there but full-access on your own. Uncheck Read on your archived 2024 work calendar to keep it out of fan-out queries.

## Tip: connection labels

Set a friendly label per connection ("Personal", "Work", "Cofounder"). Tools include it in responses, which makes agent reasoning cleaner. Especially useful when two connections both expose a `primary` calendar.
