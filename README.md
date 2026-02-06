# Claude Code Skill for OpenClaw

This skill enables seamless integration with Claude Code within the OpenClaw framework, providing AI-powered code development capabilities.

## Description

Claude Code is an AI-powered coding assistant that can build features, debug issues, and navigate codebases. This skill makes it easy to use Claude Code within OpenClaw for automated development workflows.

## Installation

### Via ClawHub
```bash
clawhub install claude-code
```

### Manual Installation
1. Download the `.skill` file
2. Install it in your OpenClaw workspace

## Usage

### Quick Start
```bash
# Non-interactive development (recommended for automation)
claude-prompt "Create a REST API with Flask"

# Continue previous conversation
claude-continue

# Full interactive mode
claude-run [options] [prompt]
```

### Common Workflows

#### Build a Feature
```bash
claude-prompt "Add user authentication with JWT tokens"
claude-continue "Also add password reset functionality"
```

#### Debug Issues
```bash
claude-prompt "The API returns 500 error when POSTing to /api/users"
claude-continue "Fix the bug you found"
```

#### Navigate Codebase
```bash
claude-prompt "Explain how the authentication flow works"
```

## Features

- **Build features from descriptions** - Describe what you want in plain English
- **Debug and fix issues** - Analyze code and implement fixes
- **Navigate codebases** - Understand project structure and relationships
- **File system access** - Read, edit, and create files
- **Multi-tool support** - Bash, Edit, Read, and more

## Requirements

- Node.js (for Claude Code)
- OpenClaw framework
- Claude Code installed via npm: `npm install -g @anthropic-ai/claude-code`

## Configuration

Claude Code reads configuration from:
- `~/.claude/settings.json` - API keys and model settings
- `~/.claude.json` - User preferences
- `.claude/settings.json` - Project-specific settings

## Skills Included

- `run_claude.sh` - Full Claude Code wrapper with all options
- `claude_prompt.sh` - Non-interactive prompt for automation
- `claude_continue.sh` - Resume previous conversations

## License

MIT License - See LICENSE file for details

## Contributing

Contributions welcome! Please feel free to submit a Pull Request.

## Support

For issues or questions, please open an issue on this repository.
