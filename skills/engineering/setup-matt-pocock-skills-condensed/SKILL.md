---
name: setup-matt-pocock-skills
description: Scaffold ## Agent skills block and docs/agents/ for issue tracker, triage labels, domain docs. Run before to-issues, to-prd, triage, diagnose, tdd, improve-codebase-architecture, zoom-out — or if those skills lack issue tracker/triage/domain context.
disable-model-invocation: true
---

Scaffold per-repo config engineering skills assume:

• **Issue tracker** — where issues live (GitHub default; local markdown supported)
• **Triage labels** — strings for five canonical triage roles
• **Domain docs** — `CONTEXT.md`, ADRs, consumer rules

Prompt-driven — explore, present, confirm, write.

## Process

### 1. Explore

Read what exists; don't assume:

• `git remote -v`, `.git/config` — GitHub? Which repo?
• `AGENTS.md`, `CLAUDE.md` — existing `## Agent skills`?
• `CONTEXT.md`, `CONTEXT-MAP.md`
• `docs/adr/`, `src/*/docs/adr/`
• `docs/agents/` — prior output?
• `.scratch/` — local-markdown issue tracker?

### 2. Present findings and ask

Summarise present/missing. Walk three decisions **one at a time** — explainer + choices + default per section. Don't dump all three.

Assume user may not know terms.

**Section A — Issue tracker**

> Where issues live. Skills (`to-issues`, `triage`, `to-prd`, `qa`) read/write here — `gh issue create`, `.scratch/` markdown, or other workflow.

Default: GitHub if remote points there; GitLab if `gitlab.com`/self-hosted; else offer:

• **GitHub** — GitHub Issues (`gh` CLI)
• **GitLab** — GitLab Issues ([`glab`](https://gitlab.com/gitlab-org/cli))
• **Local markdown** — `.scratch/<feature>/` (solo/no remote)
• **Other** (Jira, Linear…) — user describes workflow in one paragraph; record as freeform

**Section B — Triage label vocabulary**

> `triage` moves issues through state machine — needs evaluation, waiting on reporter, AFK-ready, human-needed, won't fix. Map to labels you've actually configured.

Five canonical roles:

• `needs-triage` — maintainer evaluates
• `needs-info` — waiting on reporter
• `ready-for-agent` — fully specified, AFK-ready
• `ready-for-human` — human implementation
• `wontfix` — will not be actioned

Default: string equals role name. Override if repo uses different names. No existing labels → defaults fine.

**Section C — Domain docs**

> Skills read `CONTEXT.md` + `docs/adr/`. Single vs multi-context layout.

• **Single-context** — root `CONTEXT.md` + `docs/adr/`
• **Multi-context** — `CONTEXT-MAP.md` → per-context `CONTEXT.md` (monorepo)

### 3. Confirm and edit

Draft for user edit:

• `## Agent skills` block for `CLAUDE.md` / `AGENTS.md`
• `docs/agents/issue-tracker.md`, `triage-labels.md`, `domain.md`

### 4. Write

**Pick file:**

• `CLAUDE.md` exists → edit it
• Else `AGENTS.md` exists → edit it
• Neither → ask user which to create

Never create `AGENTS.md` when `CLAUDE.md` exists (or vice versa) — always edit the one that's already there. Update existing `## Agent skills` in-place; don't duplicate or overwrite surrounding sections.

Block:

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

Write `docs/agents/` from seed templates:

• [issue-tracker-github.md](./issue-tracker-github.md)
• [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)
• [issue-tracker-local.md](./issue-tracker-local.md)
• [triage-labels.md](./triage-labels.md)
• [domain.md](./domain.md)

"Other" trackers → write `issue-tracker.md` from user description.

### 5. Done

Setup complete; list which skills now read these files. User can edit `docs/agents/*.md` directly — re-run only to switch trackers or restart.
