#!/bin/bash
# Non-interactive Claude Code prompt for automated workflows
# Usage: scripts/claude_prompt.sh "your prompt here"

CLAUDE_CODE_BIN="/usr/lib/node_modules/@anthropic-ai/claude-code/cli.js"

if [ ! -f "$CLAUDE_CODE_BIN" ]; then
    echo "Error: Claude Code not found at $CLAUDE_CODE_BIN"
    exit 1
fi

if [ -z "$1" ]; then
    echo "Error: No prompt provided"
    echo "Usage: $0 \"your prompt here\""
    exit 1
fi

# Run Claude Code in print mode (non-interactive)
node "$CLAUDE_CODE_BIN" -p --print "$@"
