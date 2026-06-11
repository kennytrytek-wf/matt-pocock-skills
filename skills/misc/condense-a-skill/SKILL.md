---
name: condense-a-skill
description: Create or update token-optimized -condensed sibling skills that preserve all rules from originals. Use when adding -condensed variants, re-syncing after upstream skill changes, or batch condensing shipped skills.
---

# Condense a Skill

Maintain `{name}-condensed/` siblings of shipped skills. **Never edit originals.**

## When to use

- Creating a new `-condensed` skill
- Re-syncing after upstream changes to the original
- Batch re-condense: `./scripts/verify-skill-condensed.sh --all`

## Workflow

1. Read original dir (`skills/{bucket}/{name}/`) — all `.md` and `scripts/`
2. Mirror structure in `skills/{bucket}/{name}-condensed/`
3. Condense file-by-file (rules below)
4. Run `./scripts/verify-skill-condensed.sh skills/{bucket}/{name}` — fix until OK
5. Report byte reduction from script output

## Conventions

- Frontmatter: `name: {name}` (same as original — the directory carries the `-condensed` suffix, not the command name); description is the original's description, trimmed
- Links: local only (`./AGENT-BRIEF.md`), never `../{name}/`
- Shell scripts: copy unchanged
- Scope: `engineering/`, `productivity/`, `misc/` only

## Condensation rules

1. **Never drop normative rules** — MUST/NEVER/DO NOT/required/state transitions/template fields/canonical terms/labels/paths survive
2. **Templates verbatim** — markdown/code templates unchanged; compress surrounding prose only
3. **Prose → bullets** — use `•`/`→`; tables for role mappings
4. **Examples: extract first** — convert illustrated rules to bullets; keep ≤1 minimal example per pattern
5. **Remove non-rules** — motivation, duplicate explanations, redundant examples
6. **Keep setup pointers** — hard-dependency one-liners in `to-issues`, `to-prd`, `triage`: _"… should have been provided to you — run `/setup-matt-pocock-skills` if not."_
7. **Link locally** — condensed refs point to condensed support files

Target: ~40–60% byte reduction on SKILL.md + support files combined.

## Verify script

```bash
./scripts/verify-skill-condensed.sh skills/engineering/triage
./scripts/verify-skill-condensed.sh --all
```

Exits non-zero on missing normative atoms. WARN on new atoms — review, don't invent rules.
