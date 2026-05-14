# calendarmcp-public

Public docs + manifest + client configs for the hosted [CalendarMCP](https://calendarmcp.ai) service.

## Purpose

This repo is the **public face** of the CalendarMCP product. It exists so:

- Glama, Smithery, PulseMCP, mcp.so, and the official MCP registry can auto-discover the server
- Users get a familiar GitHub URL to land on, browse client configs, and file issues
- The repo accumulates stars and GitHub-driven SEO for "calendar mcp" / "google calendar mcp" queries
- We claim the canonical MCP registry namespace `io.calendarmcp/calendarmcp`

## What lives here

| Path | Purpose |
|------|---------|
| `README.md` | Marketing-grade landing for GitHub viewers |
| `server.json` | Official MCP registry manifest (publish via `mcp publish`) |
| `mcp.json` | Glama/Smithery/mcp.so manifest |
| `.well-known/mcp-server.json` | Discovery stub |
| `examples/` | Copy-paste client configs (Claude Desktop, Claude Code, Cursor, OpenClaw, Continue, Windsurf, Goose, n8n) |
| `docs/` | Human-readable docs: tools, auth, GAP, multi-account, rate limits, changelog |
| `LICENSE` | MIT — applies to this repo's docs/examples only |
| `CONTRIBUTING.md` | What PRs we accept |

## What does NOT live here

- Application source code (private repo: `Full-Vibe/calendarmcp`)
- Secrets, env vars, API keys, Supabase keys
- Internal SQL, internal API specs, customer data
- Any closed-source product logic

## Domains
- **calendarmcp.ai** (the service this repo describes; lives in `Full-Vibe/calendarmcp`)
- **github.com/Full-Vibe/calendarmcp-public** (this repo)

## Stack
None at runtime. Pure docs + JSON manifests.

## Maintenance
- Keep examples in sync with the private repo's actual integration page content. When `Full-Vibe/calendarmcp/src/app/integrations/<client>/page.tsx` changes its config snippet, copy the change here.
- Keep `docs/changelog.md` in sync with `calendarmcp.ai/changelog` (which is generated from the private repo's `src/app/changelog/page.tsx`).
- `mcp.json` and `server.json` should reflect the live tool surface from `https://calendarmcp.ai/api/docs`.
- Run quarterly secret scans before any major release.

## Agent maintenance ownership

Owned by the **CMO cycle** and **Product Execution** heartbeat tasks. Whenever those tasks touch the private `Full-Vibe/calendarmcp` repo (new integration page, new tool, changelog entry), they MUST mirror relevant changes here.

See `memory/heartbeat-tasks/cmo-cycle.md` and `memory/heartbeat-tasks/product-execution.md` for the standing rule.

## Visibility
**Public** on GitHub. Verified no secrets at creation (2026-05-14).
