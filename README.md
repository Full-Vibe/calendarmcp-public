# CalendarMCP

> **The hosted Google Calendar MCP server.** Connect any AI agent to your Google Calendar in about two minutes. No self-hosting, no Docker, no `credentials.json`.

[![Website](https://img.shields.io/badge/Website-calendarmcp.ai-blue)](https://calendarmcp.ai)
[![Docs](https://img.shields.io/badge/Docs-calendarmcp.ai/docs-blue)](https://calendarmcp.ai/docs)
[![Status](https://img.shields.io/badge/Status-Live-brightgreen)](https://calendarmcp.ai)

## What this is

CalendarMCP is a hosted Model Context Protocol (MCP) server for Google Calendar. Connect your Google account once, get an API key, and any MCP-compatible client (Claude Desktop, Claude Code, Claude.ai, Cursor, OpenClaw, Continue, Cline, Windsurf, Goose, Zed, ChatGPT custom GPTs, n8n, etc.) can read and write your calendar.

This repo is the public docs, manifest, and client examples for the service. **The hosted service is not open source.** If you want a self-hosted alternative, the most popular OSS option is [nspady/google-calendar-mcp](https://github.com/nspady/google-calendar-mcp) and we recommend it for users who want OAuth tokens to never leave their machine.

## What CalendarMCP gives you that self-hosted MCPs do not

- **Zero setup.** One Google OAuth click. No `credentials.json`, no Google Cloud Console, no Docker.
- **HTTP transport.** Works with Claude.ai, Claude Code, Cursor, and any hosted MCP client. Self-hosted stdio MCPs only work with Claude Desktop.
- **Batch operations.** `batch_update_events` updates up to 50 events in one concurrent call. Renaming a recurring meeting across a year is one prompt, not 50 clicks.
- **Multi-account, one key.** Connect any number of Google accounts (mix OAuth and service-account-shared calendars) under a single API key. Reading fans out across all of them, results merged and sorted.
- **Google Advanced Protection support.** The only hosted MCP that works for GAP users (via service-account sharing — OAuth is blocked for those accounts).
- **Per-calendar Read/Write matrix.** Tighten what each agent can touch from the dashboard without minting new keys.

## Quick start

1. Visit [calendarmcp.ai](https://calendarmcp.ai), sign in with Google, and copy your API key.
2. Add the MCP server to your client of choice. Configs below.
3. Talk to your agent: _"What do I have on Tuesday?"_

## Client configs

Drop these into the right config file for your MCP client.

### Claude Desktop

`~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or `%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "calendar": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-fetch",
        "https://calendarmcp.ai/api/mcp"
      ],
      "env": {
        "MCP_AUTH_HEADER": "Authorization: Bearer YOUR_CALENDARMCP_API_KEY"
      }
    }
  }
}
```

See [examples/claude-desktop.json](./examples/claude-desktop.json) and our [Claude Desktop integration guide](https://calendarmcp.ai/integrations/claude-desktop).

### Claude Code

```bash
claude mcp add calendar https://calendarmcp.ai/api/mcp \
  --transport http \
  --header "Authorization: Bearer YOUR_CALENDARMCP_API_KEY"
```

See [examples/claude-code.sh](./examples/claude-code.sh) and our [Claude Code integration guide](https://calendarmcp.ai/integrations/claude-code).

### Cursor

`~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "calendar": {
      "url": "https://calendarmcp.ai/api/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_CALENDARMCP_API_KEY"
      }
    }
  }
}
```

See [examples/cursor.json](./examples/cursor.json) and our [Cursor integration guide](https://calendarmcp.ai/integrations/cursor).

### OpenClaw

In your `openclaw.json`:

```json
{
  "plugins": {
    "entries": {
      "mcp-calendarmcp": {
        "enabled": true,
        "config": {
          "url": "https://calendarmcp.ai/api/mcp",
          "authHeader": "Bearer YOUR_CALENDARMCP_API_KEY"
        }
      }
    }
  }
}
```

See [examples/openclaw.json](./examples/openclaw.json) and our [OpenClaw integration guide](https://calendarmcp.ai/integrations/openclaw).

### Other clients

See [examples/](./examples/) for Continue, Windsurf, Goose, n8n, and more.

## Tools

CalendarMCP exposes 10 tools. The full machine-readable schema lives at [https://calendarmcp.ai/api/docs](https://calendarmcp.ai/api/docs).

| Tool | Description |
|------|-------------|
| `list_events` | List events across one or all connected calendars in a time range. Auto-paginates up to 2500 results. |
| `get_event` | Full details of one event. |
| `create_event` | Create an event. Supports attendees, location, reminders, recurrence, all-day. |
| `update_event` | Partial update of an existing event. |
| `delete_event` | Delete an event. |
| `quick_add_event` | Create from natural language ("Lunch with Sam Friday 1pm"). |
| `list_calendars` | List every calendar the API key can see, with per-calendar R/W permissions. |
| `find_free_time` | Free/busy query across one or more calendars. The right thing to call before `create_event` to prevent double-booking. |
| `manage_attendees` | Add or remove attendees from an event. |
| `batch_update_events` | Update up to 50 events in one concurrent call. |

Full reference: [docs/tools.md](./docs/tools.md).

## Authentication

API keys are issued from the dashboard at [calendarmcp.ai/dashboard](https://calendarmcp.ai/dashboard). One key can hold any number of connected Google accounts. Per-calendar R/W scopes are enforced server-side.

Rate limit: **60 requests/minute per key.** Free tier; pay-as-you-go pricing for higher limits coming soon.

See [docs/authentication.md](./docs/authentication.md).

## Google Advanced Protection

If you have Google Advanced Protection enabled, OAuth into third-party calendar apps is blocked by Google policy. CalendarMCP supports a service-account sharing flow that works for GAP users. We're the only hosted MCP we know of that supports this.

See [docs/google-advanced-protection.md](./docs/google-advanced-protection.md).

## Roadmap

- ✅ Google Calendar (live)
- ⏳ Microsoft Outlook Calendar ([waitlist](https://calendarmcp.ai/outlook))
- ⏳ iCloud Calendar ([waitlist](https://calendarmcp.ai/icloud))
- ⏳ CalDAV (any provider)

## Pricing

Free tier with generous limits. Paid plans land soon for power users.

See [calendarmcp.ai/pricing](https://calendarmcp.ai/pricing).

## Comparison

| Feature | CalendarMCP | nspady (OSS) | Composio | Zapier MCP |
|---------|-------------|--------------|----------|------------|
| Hosted | ✅ | ❌ | ✅ | ✅ |
| HTTP transport | ✅ | ❌ (stdio only) | ✅ | ✅ |
| Setup time | 2 min | 25 min | 10 min | 5 min |
| Batch update events | ✅ | ❌ | ❌ | ❌ |
| Multi-account, one key | ✅ | ❌ | ❌ | ❌ |
| Google Advanced Protection | ✅ | ❌ | ❌ | ❌ |
| Per-calendar R/W matrix | ✅ | ❌ | ❌ | ❌ |
| Open source | ❌ | ✅ | partial | ❌ |
| Tokens on your machine | ❌ | ✅ | ❌ | ❌ |

Honest read: pick nspady if you only use Claude Desktop and want zero third parties. Pick CalendarMCP for everything else.

## Contributing

This repo is docs and examples. PRs welcome for:

- New client config examples
- Doc improvements and clarifications
- Translations

Service issues (bugs, feature requests for the hosted product) → [GitHub Issues](https://github.com/Full-Vibe/calendarmcp-public/issues).

## License

Examples and docs in this repo: **MIT** (see [LICENSE](./LICENSE)).

The hosted service is not open source.

## Links

- [calendarmcp.ai](https://calendarmcp.ai) — the service
- [Docs](https://calendarmcp.ai/docs)
- [Blog](https://calendarmcp.ai/blog)
- [Changelog](https://calendarmcp.ai/changelog)
- [Integrations](https://calendarmcp.ai/integrations)
- [Use cases](https://calendarmcp.ai/use-cases)
