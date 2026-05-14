# Contributing

This repository is public docs, manifest files, and client configs for the hosted CalendarMCP service. We welcome PRs for:

- New client config examples (e.g. you got CalendarMCP working with a client we haven't listed. Drop a config into `examples/`).
- Doc clarifications, typo fixes, additional examples.
- Translations of `README.md` or docs (file in `docs/<lang>/`).
- New entries to `mcp.json` or `server.json` (if the upstream spec evolves).

## What we don't accept

- Service source code (the service is closed-source).
- Anything that requires server-side changes (file an issue instead).

## Code of conduct

Be a normal human. Don't be a jerk. We reserve the right to close PRs and ban users who can't manage that.

## Filing issues

| What | Where |
|------|-------|
| Bug in the hosted service | GitHub Issues here, or email hello@calendarmcp.ai |
| Feature request | GitHub Issues here |
| Security issue | security@calendarmcp.ai (please don't open a public issue) |
| Question about your account | hello@calendarmcp.ai (we need to see your account, can't help in a public issue) |

## Style

- Markdown: use `prettier` defaults. Long lines OK; line wrapping is the reader's job.
- JSON: 2-space indent, trailing newline.
- Examples should use `YOUR_CALENDARMCP_API_KEY` as the placeholder.
