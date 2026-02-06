---
name: claude-code
description: Interface with Claude Code for code development, debugging, and codebase navigation. Use when needing to build features from natural language descriptions, debug and fix issues, navigate and understand codebases, generate code with file system access, or run complex development tasks requiring multiple tools.
---

# Claude Code

## Quick Start

Use Claude Code for AI-powered code development with full file system access.

**Non-interactive (recommended for OpenClaw):**
```bash
scripts/claude_prompt.sh "your prompt here"
```

**Continue previous conversation:**
```bash
scripts/claude_continue.sh
```

**Full interactive mode:**
```bash
scripts/run_claude.sh [options] [prompt]
```

## Key Capabilities

### 1. Build Features
Describe what you want to build in plain English. Claude Code will:
- Create a plan
- Write the code
- Test and ensure it works

Example:
```bash
scripts/claude_prompt.sh "Create a Python REST API with Flask that has endpoints for users and products"
```

### 2. Debug and Fix Issues
Describe a bug or paste error messages. Claude Code will:
- Analyze the codebase
- Identify the problem
- Implement a fix

Example:
```bash
scripts/claude_prompt.sh "Fix the bug in app.py where the user authentication fails"
```

### 3. Navigate Codebases
Ask anything about your codebase. Claude Code maintains awareness of:
- Entire project structure
- File relationships
- Web searches for up-to-date info
- External data sources via MCP

Example:
```bash
scripts/claude_prompt.sh "Explain how the authentication flow works in this project"
```

## Common Workflows

### Adding a New Feature
```bash
# Step 1: Describe the feature
scripts/claude_prompt.sh "Add user authentication with JWT tokens"

# Step 2: Continue conversation to refine
scripts/claude_continue.sh "Also add password reset functionality"

# Step 3: Continue to test and fix
scripts/claude_continue.sh "Run tests and fix any issues"
```

### Debugging a Problem
```bash
# Step 1: Describe the issue with context
scripts/claude_prompt.sh "The API returns 500 error when POSTing to /api/users"

# Step 2: Continue to apply fix
scripts/claude_continue.sh "Fix the bug you found"

# Step 3: Continue to verify
scripts/claude_continue.sh "Run the tests to confirm the fix works"
```

### Code Review and Refactoring
```bash
scripts/claude_prompt.sh "Review the utils.py file for performance issues and security vulnerabilities"
scripts/claude_continue.sh "Refactor the code you identified as problematic"
```

## Configuration

Claude Code reads configuration from:
- `~/.claude/settings.json` - API keys, model settings
- `~/.claude.json` - User preferences
- `.claude/settings.json` - Project-specific settings

**Current setup:**
- Model: Configured via ANTHROPIC_BASE_URL (supports OpenAI-compatible APIs)
- API Key: Set in `~/.claude/settings.json`
- Tools: Full access to Bash, Edit, Read, and more

## Important Notes

### Directory Safety
Claude Code should only be run in trusted directories. In print mode (`-p`), workspace trust dialog is skipped.

### Session Management
- Sessions are persisted automatically
- Use `--continue` or `-c` to resume recent conversations
- Use `--resume [session-id]` to resume a specific session

### Output Formats
- Default: Interactive terminal output
- `--print` or `-p`: Print and exit (non-interactive)
- `--output-format json`: JSON output for programmatic use
- `--output-format stream-json`: Real-time streaming JSON

### Resource Limits
Set maximum API spend:
```bash
scripts/claude_prompt.sh --max-budget-usd 1.0 "your prompt"
```

## Advanced Usage

### Custom System Prompt
```bash
scripts/run_claude.sh --system-prompt "You are a security-focused code reviewer" "Review this code"
```

### Model Selection
```bash
scripts/run_claude.sh --model claude-sonnet-4-5 "your prompt"
```

### Tool Restrictions
```bash
scripts/run_claude.sh --allowed-tools "Bash(git:*,npm:*),Read" "your prompt"
```

### Custom Agents
```bash
scripts/run_claude.sh --agent '{"name": "reviewer", "description": "Code reviewer", "prompt": "You are a code reviewer"}' "Review this code"
```

## Troubleshooting

### Claude Code not found
Ensure npm package is installed:
```bash
npm ls -g @anthropic-ai/claude-code
```

### API Authentication errors
Check `~/.claude/settings.json` for correct `ANTHROPIC_AUTH_TOKEN` and `ANTHROPIC_BASE_URL`.

### Session not resuming
Use `--resume` with session ID:
```bash
scripts/run_claude.sh --resume <session-id>
```

## Resources

### scripts/
- `run_claude.sh` - Full Claude Code wrapper
- `claude_prompt.sh` - Non-interactive prompt (print mode)
- `claude_continue.sh` - Continue previous conversation

All scripts automatically use the configured Claude Code binary at `/usr/lib/node_modules/@anthropic-ai/claude-code/cli.js`.
