#!/usr/bin/env bash
# Add CalendarMCP to Claude Code.
# Get your API key at https://calendarmcp.ai

claude mcp add calendar https://calendarmcp.ai/api/mcp \
  --transport http \
  --header "Authorization: Bearer YOUR_CALENDARMCP_API_KEY"

# Verify it loaded
claude mcp list
