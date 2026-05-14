# Google Advanced Protection + CalendarMCP

If you have Google Advanced Protection (GAP) turned on, **third-party OAuth into your calendar is blocked by Google policy.** That breaks almost every "connect Claude to Google Calendar" tutorial out there. CalendarMCP supports a service-account sharing flow that does work for GAP users. We believe we're the only hosted MCP that does.

## What GAP is

Google's strongest account security tier. Designed for journalists, activists, executives, IT admins, anyone who can be targeted. It enforces hardware security keys for sign-in and blocks third-party app access to Gmail and Calendar.

## Why OAuth breaks

When you click "Sign in with Google" to authorize a non-Google app to access your calendar, Google checks your account. If GAP is on, Google denies the request and shows a generic error. There's no opt-in toggle for individual apps.

## The service-account flow

A **service account** is a Google identity that belongs to a Google Cloud project, not a person. You can share a Google Calendar with a service account just like you'd share it with a coworker. GAP does not block that — sharing is a normal calendar feature.

CalendarMCP runs a service account on your behalf:

1. Sign in to CalendarMCP with **any non-GAP Google account** (a backup personal account works, or a Google Workspace account where GAP isn't enforced on the user).
2. From the dashboard, switch to **Service-account flow** and copy the service-account email (looks like `cmcp-<id>@calendarmcp.iam.gserviceaccount.com`).
3. In your GAP-protected Google Calendar, go to **Settings → Share with specific people** and add that service-account email with the access level you want (See all event details = Read; Make changes to events = Write).
4. Back in the CalendarMCP dashboard, click **Verify** on the calendar. Done.

Your API key now reads (and optionally writes) the GAP-protected calendar through the service account, no OAuth required.

## What it can do

| Tool | Works on SA-shared calendar? |
|------|------------------------------|
| `list_events` | ✅ |
| `get_event` | ✅ |
| `create_event` (no attendees) | ✅ |
| `create_event` with attendees | ❌ (Google blocks SA-driven invites) |
| `update_event` | ✅ |
| `update_event` attendees field | ❌ |
| `delete_event` | ✅ |
| `manage_attendees` | ❌ |
| `find_free_time` | ✅ |

If you need to dispatch invites, connect the same Google account a second time via OAuth on a non-GAP account, and use that connection for `create_event`/`manage_attendees`. Multi-account-one-key means both connections sit on the same API key, and the agent can pick the right one based on whether attendees are involved.

## Why a service account is fine for GAP

GAP blocks third-party OAuth because OAuth can leak. A service account is different: there's no OAuth flow, no refresh token to phish, no user-visible "Grant access" button. You explicitly share specific calendars with a specific identity, and you can revoke any time from the calendar's share settings.

## Setup time

About 2 minutes per calendar. Most of it is clicking through Google's share dialog.
