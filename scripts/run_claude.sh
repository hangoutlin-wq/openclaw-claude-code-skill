#!/bin/bash
# Wrapper script to run Claude Code with proper configuration
# Usage: scripts/run_claude.sh [options] [prompt]

CLAUDE_CODE_BIN="/usr/lib/node_modules/@anthropic-ai/claude-code/cli.js"

if [ ! -f "$CLAUDE_CODE_BIN" ]; then
    echo "Error: Claude Code not found at $CLAUDE_CODE_BIN"
    exit 1
fi

# Check if we're in a trusted directory (workspace)
WORKSPACE="${WORKSPACE:-$(pwd)}"

# Run Claude Code with node
node "$CLAUDE_CODE_BIN" "$@"
