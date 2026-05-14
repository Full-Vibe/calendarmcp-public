# CalendarMCP Tool Reference

Full machine-readable schema lives at [calendarmcp.ai/api/docs](https://calendarmcp.ai/api/docs).

This is the human-readable summary. Bookmark the JSON schema if you're building an agent.

## Calendar conventions

- **Timed events:** use `startDateTime` and `endDateTime` (ISO 8601). Example: `"2026-05-14T18:00:00-07:00"`.
- **All-day events:** use `startDate` and `endDate` (`YYYY-MM-DD`). The end date is **exclusive** in Google's API. A 2-day event Mon-Tue is `start: "2026-05-18", end: "2026-05-20"`.
- **Never mix `date` and `dateTime` on the same event.**
- **Color IDs:** integers 1-11. See [Google's color reference](https://developers.google.com/calendar/api/v3/reference/colors/get).
- **Search caveat:** text search (the `q` / `query` param) does not work on non-primary calendars due to a Google Calendar API limitation. Use `list_events` and filter client-side instead.

## Multi-account behavior

One API key can hold multiple Google accounts (OAuth or service-account-shared). When you call a tool that omits `calendarId`, it fans out across every enabled calendar the key can read, in parallel, and merges results sorted by start time.

## Per-calendar permissions

Each API key has a Read/Write grant per calendar. Reading tools require Read; writing tools require Write. Denied calendars return a structured `PermissionError`. Use `list_calendars` to discover what the key can do at runtime.

## Tools

### `list_events`

List events from one or more calendars in a time range. Auto-paginates up to 2500 results.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `calendarId` | string | no | Calendar ID. Omit to fan out across every enabled calendar. |
| `timeMin` | string (ISO 8601) | no | Start of range. |
| `timeMax` | string (ISO 8601) | no | End of range. |
| `maxResults` | number | no | 1-2500. Default 10. |
| `q` | string | no | Text search (primary calendars only). |
| `singleEvents` | boolean | no | Expand recurring events into single instances. Default `true`. |

**Permission:** Read on the target calendar.

### `get_event`

Get full details of one event.

| Parameter | Type | Required |
|-----------|------|----------|
| `calendarId` | string | yes |
| `eventId` | string | yes |

**Permission:** Read.

### `create_event`

Create an event. Use either `startDateTime`/`endDateTime` (timed) OR `startDate`/`endDate` (all-day) — never both.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `calendarId` | string | yes | |
| `summary` | string | yes | Event title. |
| `startDateTime` | string | one of date pairs | ISO 8601, for timed events. |
| `endDateTime` | string | one of date pairs | |
| `startDate` | string | one of date pairs | `YYYY-MM-DD`, for all-day. |
| `endDate` | string | one of date pairs | Exclusive. |
| `description` | string | no | |
| `location` | string | no | |
| `attendees` | array | no | `[{ email, optional? }]`. |
| `reminders` | object | no | `{ overrides: [{ method: "popup"|"email", minutes }] }`. |
| `recurrence` | array | no | RRULE strings. |
| `colorId` | string | no | 1-11. |

**Permission:** Write.

### `update_event`

Partial update. Pass only the fields you want to change.

Same parameter shape as `create_event`, plus `eventId`. All event fields are optional.

**Permission:** Write.

### `delete_event`

| Parameter | Type | Required |
|-----------|------|----------|
| `calendarId` | string | yes |
| `eventId` | string | yes |

**Permission:** Write.

### `quick_add_event`

Create an event from natural language.

| Parameter | Type | Required |
|-----------|------|----------|
| `calendarId` | string | yes |
| `text` | string | yes |

Example `text`: `"Lunch with Sam at Mission Chinese Friday 1pm"`.

**Permission:** Write.

### `list_calendars`

List every calendar the API key can see, with per-calendar R/W flags. Always safe to call.

No parameters.

**Permission:** none (always allowed).

### `find_free_time`

Free/busy across one or more calendars. The right tool to call before `create_event`.

| Parameter | Type | Required |
|-----------|------|----------|
| `calendarIds` | array of strings | no (defaults to all readable) |
| `timeMin` | string (ISO 8601) | yes |
| `timeMax` | string (ISO 8601) | yes |

Returns busy blocks per calendar. Compute free time = window minus busy.

**Permission:** Read on each calendar.

### `manage_attendees`

Add or remove attendees from an existing event.

| Parameter | Type | Required |
|-----------|------|----------|
| `calendarId` | string | yes |
| `eventId` | string | yes |
| `add` | array of `{email}` | no |
| `remove` | array of `email` | no |

**Limitation:** service-account-connected calendars cannot dispatch invites (Google blocks this). Use an OAuth-connected account for attendee management.

**Permission:** Write.

### `batch_update_events`

Update up to 50 events in one concurrent call.

| Parameter | Type | Required |
|-----------|------|----------|
| `updates` | array (max 50) | yes |

Each item: `{ calendarId, eventId, ...patch }`. Returns per-item success/failure.

**Permission:** Write on every target calendar.

## Error shape

Every error is structured JSON:

```json
{
  "error": "permission_denied",
  "message": "API key has Read but not Write on calendar 'primary'",
  "details": { ... }
}
```

Common error codes: `unauthorized`, `permission_denied`, `not_found`, `rate_limited`, `invalid_argument`, `google_api_error`.
