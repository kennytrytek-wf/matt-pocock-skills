# Issue tracker: GitLab

Issues and PRDs as GitLab issues. Use [`glab`](https://gitlab.com/gitlab-org/cli).

## Conventions

• **Create:** `glab issue create --title "..." --description "..."` (heredoc; `--description -` for editor)
• **Read:** `glab issue view <number> --comments` (`-F json` for machine-readable)
• **List:** `glab issue list -F json` with `--label`
• **Comment:** `glab issue note <number> --message "..."` (GitLab: notes)
• **Labels:** `glab issue update <number> --label "..."` / `--unlabel "..."`
• **Close:** `glab issue note <number> --message "..."` first (no closing comment on close), then `glab issue close <number>`
• **Merge requests:** `glab mr create/view/note` — same shape as `gh pr` with `mr` + `note`/`--message`

Infer repo from `git remote -v` — `glab` auto-detects.

## When a skill says "publish to the issue tracker"

Create a GitLab issue.

## When a skill says "fetch the relevant ticket"

Run `glab issue view <number> --comments`.
