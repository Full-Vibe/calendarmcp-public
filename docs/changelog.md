# Changelog

Authoritative version: [calendarmcp.ai/changelog](https://calendarmcp.ai/changelog).

This mirror is kept in sync, mostly.

## 2026-05

- **May 19:** Blog: "Connecting Google Calendar to OpenClaw" (step-by-step plugin config guide, multi-account setup, troubleshooting).
- **May 16:** Blog: "Connecting Google Calendar to Cursor (the real way)" (exact .cursor/mcp.json config, HTTP transport).
- **May 14:** Added `/integrations` directory with setup guides for 14 MCP clients. Per-client deep-dive pages: Claude Desktop, Claude Code, Cursor, OpenClaw. `/changelog`, `/showcase` gallery, and Outlook/iCloud waitlist landing pages added. Sitemap and footer updated.
- **May 1-13:** Five trickle-scheduled blog posts covering CalendarMCP workflows: AI executive assistant, batch event updates, CalendarMCP vs Composio, CalendarMCP vs self-hosted, best calendar MCP servers 2026.
- Trickle-publish bug fix on blog (future-dated posts now resolve at their publish date).
- Full AI bot allowlist added to robots.ts (GPTBot, ChatGPT-User, OAI-SearchBot, ClaudeBot, anthropic-ai, PerplexityBot, Bingbot, Meta-ExternalAgent, Applebot, Applebot-Extended, DuckAssistBot, CCBot, Bytespider).
- FAQPage + Organization + SoftwareApplication JSON-LD schema added to site-wide layout.

## 2026-04

- **Multi-connection one-key.** One API key now holds any number of Google accounts (OAuth + service-account-shared mix). `list_events` fans out across every enabled calendar in parallel.
- **Per-calendar Read/Write matrix.** Tighten what each key can touch from the dashboard without minting new keys.
- **Per-connection health pill + Reconnect.** Dashboard surfaces healthy / revoked / error per connection, with one-click Reconnect on the OAuth path.
- **Auth hardening.** Removed the singleton fallback. Every request requires a `cmcp_*` key. Setup is token-gated.
- **Test-connection button.** Run a live Google probe per connection from the dashboard.
- **Last-used timestamp per key.** Spot stale or abused keys.
- **Per-key rate limit.** 60 req/min/key on the MCP endpoint.
- **CI + deploy smoke tests.** `pnpm lint && tsc && vitest` on every push, plus a GitHub Action that curls production after each Vercel deploy.

## 2026-03

- **Resend SMTP migration.** Magic-link emails now flow through Resend on port 587 (STARTTLS) for reliability.

## 2026-02

- **Google Advanced Protection support.** Service-account sharing flow that works for GAP accounts (where third-party OAuth is blocked by Google policy).
- Initial public launch.
