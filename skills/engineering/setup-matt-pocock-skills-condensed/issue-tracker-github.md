# Issue tracker: GitHub

Issues and PRDs as GitHub issues. Use `gh` CLI.

## Conventions

• **Create:** `gh issue create --title "..." --body "..."` (heredoc for multi-line)
• **Read:** `gh issue view <number> --comments` + labels via `jq`
• **List:** `gh issue list --state open --json number,title,body,labels,comments --jq '...'` with `--label`/`--state`
• **Comment:** `gh issue comment <number> --body "..."`
• **Labels:** `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
• **Close:** `gh issue close <number> --comment "..."`

Infer repo from `git remote -v` — `gh` auto-detects in clone.

## When a skill says "publish to the issue tracker"

Create a GitHub issue.

## When a skill says "fetch the relevant ticket"

Run `gh issue view <number> --comments`.
