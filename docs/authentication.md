# Authentication

CalendarMCP uses **API keys** with **per-calendar Read/Write scopes**.

## Getting a key

1. Visit [calendarmcp.ai](https://calendarmcp.ai).
2. Sign in with Google (or, for Google Advanced Protection users, follow the [service-account flow](./google-advanced-protection.md)).
3. Your key appears in the dashboard. Format: `cmcp_<random>`.

## Using a key

Pass on every MCP request as a bearer token:

```
Authorization: Bearer cmcp_<your_key>
```

The CalendarMCP endpoint is `https://calendarmcp.ai/api/mcp`. Most MCP clients let you set the header in their config (see [examples/](../examples/)).

## Multi-account, one key

A single API key can hold any number of Google accounts. Connect more from the dashboard. Both OAuth-connected and service-account-shared calendars sit on the same key. Reading tools fan out across all enabled calendars; writing tools target whatever `calendarId` you specify.

## Per-calendar R/W matrix

The dashboard shows a matrix: rows are calendars, columns are the key, cells are Read / Write checkboxes. New calendars auto-inherit Read+Write. Uncheck to narrow.

Server-side enforcement: every tool call checks the matrix. Denied calls return `PermissionError` with the offending calendar id.

## Rate limits

**60 requests per minute per key.** Above that, you get `429` with `Retry-After`. Free tier; we'll raise this on paid tiers.

## Rotating a key

The dashboard supports key rotation (issue new + invalidate old). For now, keys are single-purpose (one key per account); we'll add multiple keys per account in an upcoming release. Until then, treat the key like a password. Don't commit it to git, don't paste it into a public chat.

## Revoking access

- Disconnect a Google account from the dashboard → all calendars under that account go to `error` status, no tool calls succeed.
- Delete an API key from the dashboard → all clients lose access. Recreate as needed.
- Revoke at Google ([myaccount.google.com/permissions](https://myaccount.google.com/permissions)) → CalendarMCP loses access on the next refresh.

## Security model

- Tokens (OAuth refresh tokens, service-account private keys) live encrypted at rest in our Supabase Postgres instance, scoped to your account.
- API keys are hashed in the database; the plaintext is shown once at creation.
- TLS everywhere. No HTTP fallback.
- CalendarMCP runs on Vercel + Supabase, both with SOC 2 Type II controls in their underlying infra.
