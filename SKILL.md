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

## ⚡ IMPORTANT: Superpowers Plugin

**Always use the superpowers plugin when driving Claude Code.**

The superpowers plugin enhances Claude Code's capabilities for code generation, debugging, and development workflows.

### Usage
When invoking Claude Code, ensure superpowers is enabled:
```bash
scripts/claude_prompt.sh --with-superpowers "your prompt here"
```

All development work in this workspace should use the superpowers plugin for optimal results.

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

## GitHub Codespaces Integration

### Overview
GitHub Codespaces provides cloud-based development environments that allow you to:
- Develop in a cloud-hosted Docker container
- Access from browser, VS Code, or GitHub CLI
- Collaborate with reproducible environments
- Deploy applications with public port forwarding

### Creating a Codespace

**From a repository:**
```bash
# Using GitHub CLI
gh codespace create --repo hangoutlin-wq/REPO_NAME

# Or via web interface: https://github.com/codespaces
```

**From a template:**
```bash
gh codespace create --template TEMPLATE_NAME
```

### Dev Container Configuration

Add `.devcontainer/devcontainer.json` to your repository for custom environments:

**Basic example:**
```json
{
  "name": "My Dev Container",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "lts"
    }
  },
  "portsAttributes": {
    "3000": {
      "label": "App Port",
      "onAutoForward": "notify"
    }
  }
}
```

**Custom Dockerfile:**
```json
{
  "build": {
    "dockerfile": "Dockerfile"
  },
  "customizations": {
    "vscode": {
      "extensions": ["dbaeumer.vscode-eslint"]
    }
  }
}
```

### Port Forwarding for Public Access

To make your application publicly accessible from a codespace:

1. **Forward the port:**
   ```bash
   gh codespace ports forward 3000
   ```

2. **Make it public:**
   - In VS Code: Click "Make Public" on the port notification
   - Via CLI:
     ```bash
     gh codespace ports set-visibility 3000:public
     ```

3. **Get the public URL:**
   ```bash
   gh codespace ports list
   ```

4. **Share the URL** - The public URL follows the format:
   ```
   https://<random-words>-<codespace-name>-<port>.app.github.dev
   ```

### Common Dev Container Features

Add tools quickly using features in `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "lts"
    },
    "ghcr.io/devcontainers/features/python:1": {
      "version": "3.11"
    },
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  }
}
```

### Rebuilding Dev Container

After modifying `.devcontainer/devcontainer.json`:

**In VS Code:**
- Command Palette → "Codespaces: Rebuild Container"

**Via GitHub CLI:**
```bash
gh codespace rebuild
```

### Managing Codespaces

**List all codespaces:**
```bash
gh codespace list
```

**Delete a codespace:**
```bash
gh codespace delete CODESPACE_NAME
```

**Stop a codespace:**
```bash
gh codespace stop CODESPACE_NAME
```

### Billing and Limits

- Personal accounts include free tier (check current limits on GitHub)
- Compute and storage billed monthly
- Set spending limits to control costs
- Organization-managed codespaces available for teams

### Best Practices

1. **Commit dev container configs** - Ensure reproducibility for all users
2. **Use prebuilts** - Speed up codespace creation for large projects
3. **Personalize with dotfiles** - Maintain shell preferences across codespaces
4. **Clean up idle codespaces** - Avoid unnecessary charges
5. **Test locally when possible** - Use codespaces for cloud-specific testing

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

### Codespace creation fails
- Check dev container configuration syntax
- Verify image is accessible
- Check organization policies if using org repo
- Review creation logs for specific errors

### Port forwarding not working
- Ensure application is listening on 0.0.0.0, not localhost
- Check firewall settings within codespace
- Verify port visibility settings (public/private)

## Deployment Workflow

### GitHub Codespaces Workflow

When deploying to Codespaces for production or testing:

1. **Create codespace** with appropriate dev container
2. **Build and run** the application
3. **Forward required ports**
4. **Set visibility to public** for external access
5. **Share public URL** with stakeholders
6. **Clean up** codespace when done (unless running production)

### Vercel Automated Deployment Workflow

**Overview:**
Vercel provides automatic deployments for connected Git repositories. Every push triggers a build and deployment.

**Automatic Deployment Process:**
```
1. Develop code
   ↓
2. Commit and push to GitHub
   ↓
3. Vercel detects new commit
   ↓
4. Automatic build and deployment
   ↓
5. Deployments available via unique URLs
```

**Supported Git Providers:**
- ✅ GitHub
- ✅ GitLab
- ✅ Bitbucket
- ✅ Azure DevOps

**Deployment Environments:**
- **Preview Deployments**: Created for every push to non-production branches
- **Production Deployments**: Created when merging to the production branch
- **Production Branch**: Default is `master` (can be customized)

**Automatic Deployment Setup:**

1. **Connect Git Repository to Vercel**
   - Visit https://vercel.com/new
   - Select repository from your Git account
   - Configure project settings (framework, build command, etc.)

2. **Configure Production Branch**
   - Default: `master` branch
   - Can be changed in Project Settings → Environments

3. **Automatic Trigger**
   - Every commit to production branch → Production Deployment
   - Every push to other branches → Preview Deployment
   - Every Pull Request → Preview Deployment with testing URL

**Deployed Project Example:**

- **English Vocabulary Learning App** (3-6 years old)
  - Repository: hangoutlin-wq/english-vocab-app
  - Production URL: https://english-vocab-app-alpha.vercel.app/
  - Framework: Next.js 14 + TypeScript + Tailwind CSS
  - Features: Flashcards, Quiz mode, Progress tracking, Gamification

**Deployment Commands:**

- **Via Git (Automatic):** Just push to GitHub
  ```bash
  git add .
  git commit -m "Feature description"
  git push origin master
  ```

- **Via Vercel CLI** (Manual deployment):
  ```bash
  # Install CLI
  npm i -g vercel

  # First deployment (links project)
  vercel

  # Subsequent deployments
  vercel --prod
  ```

- **Via Vercel Dashboard** (Manual trigger):
  - Project → Deployments → Create Deployment
  - Select commit or branch
  - Trigger build

**Preview vs Production:**

| Environment | Trigger | URL Format | Purpose |
|-------------|---------|-------------|----------|
| Preview | Push to non-master branch | `<project>-<random>.vercel.app` | Testing before production |
| Production | Merge to master branch | Custom domain or `<project>-alpha.vercel.app` | Live user-facing site |

**Best Practices:**

1. **Use Preview Deployments for Testing**
   - Create feature branches
   - Test changes via preview URL
   - Merge to master only when ready

2. **Enable Custom Domains (Optional)**
   - Add custom domain in Vercel Dashboard
   - Assign to Production Deployment
   - Update DNS settings

3. **Monitor Deployments**
   - View build logs in Vercel Dashboard
   - Check deployment status
   - Use rollback if needed

4. **Environment Variables**
   - Configure in Vercel Dashboard → Settings → Environment Variables
   - Different values for Preview vs Production

**Deployment Checklist:**

- ✅ Git repository connected to Vercel
- ✅ Production branch configured (master)
- ✅ Framework preset correct (Next.js)
- ✅ Build command correct (`npm run build`)
- ✅ Output directory correct (`.next`)
- ✅ Environment variables configured (if needed)

**Deployment Documentation:**
- Full docs: https://vercel.com/docs
- Git integration: https://vercel.com/docs/git
- Deployments overview: https://vercel.com/docs/deployments

## Resources

### scripts/
- `run_claude.sh` - Full Claude Code wrapper
- `claude_prompt.sh` - Non-interactive prompt (print mode)
- `claude_continue.sh` - Continue previous conversation

All scripts automatically use the configured Claude Code binary at `/usr/lib/node_modules/@anthropic-ai/claude-code/cli.js`.

### GitHub Codespaces Docs
- [Overview](https://docs.github.com/en/codespaces/overview)
- [Dev Containers](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces)
- [Port Forwarding](https://docs.github.com/en/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace)
- [GitHub CLI for Codespaces](https://docs.github.com/en/codespaces/developing-in-codespaces/using-github-codespaces-with-github-cli)
