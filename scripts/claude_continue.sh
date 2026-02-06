#!/bin/bash
# Continue the most recent Claude Code conversation in the current directory
# Usage: scripts/claude_continue.sh

CLAUDE_CODE_BIN="/usr/lib/node_modules/@anthropic-ai/claude-code/cli.js"

if [ ! -f "$CLAUDE_CODE_BIN" ]; then
    echo "Error: Claude Code not found at $CLAUDE_CODE_BIN"
    exit 1
fi

# Continue the most recent conversation
node "$CLAUDE_CODE_BIN" -c "$@"
