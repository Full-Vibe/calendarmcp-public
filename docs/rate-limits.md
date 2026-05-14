# Rate limits

**60 requests per minute, per API key.**

Above that, you get HTTP `429 Too Many Requests` with a `Retry-After` header (seconds).

## What counts as a request

Every MCP tool call counts as one request, regardless of how many underlying Google API calls it triggers. `batch_update_events` updating 50 events is **one** request from your client's perspective. We fan out to Google under the hood; you only pay one tick of your quota.

## Burst tolerance

We allow short bursts above 60/min by leaking the quota across a 5-second window. Typical agent workflows (interactive prompts) won't trip the limit at all.

## Why a limit at all

- Stop runaway agents from hammering Google's API and getting your account temporarily blocked there.
- Stop accidental tight loops.
- Keep the service responsive for everyone.

## Raising the limit

The Pro tier (coming soon) raises the limit to 600/min. Enterprise is custom. Email hello@calendarmcp.ai if you need more capacity today.

## Google's own quota

CalendarMCP routes through Google Calendar API, which has its own quota (per-account, set by Google). Hitting Google's quota returns a `google_api_error` response with the underlying detail. Almost no one hits this; Google's limits are generous.

## Retry guidance

On `429`:

```
1. Read the Retry-After header
2. Sleep that many seconds (or fewer if you want to test)
3. Retry the same call
```

On `5xx`:

```
1. Exponential backoff: 1s, 2s, 4s, 8s
2. Cap at 3 retries
3. Surface a clear error to the user
```

## Monitoring

The dashboard shows `lastUsedAt` per key and per connection — useful for spotting stale or abused keys.
