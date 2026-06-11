---
name: git-guardrails-claude-code
description: Set up Claude Code hooks to block dangerous git commands before they execute. Use when user wants to prevent destructive git operations, add git safety hooks, or block git push/reset in Claude Code.
---

PreToolUse hook intercepts + blocks dangerous git commands before Claude executes them.

## Blocked commands

- `git push` (all variants including `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

Blocked → message: no authority to access these commands.

## Steps

### 1. Ask scope

**This project only** (`.claude/settings.json`) or **all projects** (`~/.claude/settings.json`)?

### 2. Copy hook script

Bundled: [scripts/block-dangerous-git.sh](./scripts/block-dangerous-git.sh)

Copy to:

- **Project**: `.claude/hooks/block-dangerous-git.sh`
- **Global**: `~/.claude/hooks/block-dangerous-git.sh`

`chmod +x`

### 3. Add hook to settings

**Project** (`.claude/settings.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

**Global** (`~/.claude/settings.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

Settings file exists → merge into `hooks.PreToolUse` array — don't overwrite other settings.

### 4. Ask about customization

Add/remove patterns from blocked list? Edit copied script.

### 5. Verify

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

Exit code 2 + BLOCKED message to stderr.
