# Client Configs

Copy-paste configs for every MCP client that supports CalendarMCP.

Get your API key first: [calendarmcp.ai](https://calendarmcp.ai) → sign in with Google → dashboard.

## Configs

| Client | File | Setup guide |
|--------|------|-------------|
| Claude Desktop | [claude-desktop.json](./claude-desktop.json) | [calendarmcp.ai/integrations/claude-desktop](https://calendarmcp.ai/integrations/claude-desktop) |
| Claude Code | [claude-code.sh](./claude-code.sh) | [calendarmcp.ai/integrations/claude-code](https://calendarmcp.ai/integrations/claude-code) |
| Cursor | [cursor.json](./cursor.json) | [calendarmcp.ai/integrations/cursor](https://calendarmcp.ai/integrations/cursor) |
| OpenClaw | [openclaw.json](./openclaw.json) | [calendarmcp.ai/integrations/openclaw](https://calendarmcp.ai/integrations/openclaw) |
| Continue | [continue.json](./continue.json) | — |
| Windsurf | [windsurf.json](./windsurf.json) | — |
| Goose | [goose.yaml](./goose.yaml) | — |
| n8n | [n8n.md](./n8n.md) | — |

If your client isn't listed, the canonical info you need is:

- **Endpoint:** `https://calendarmcp.ai/api/mcp`
- **Transport:** Streamable HTTP
- **Auth:** `Authorization: Bearer <YOUR_API_KEY>`
- **No additional config required.**
