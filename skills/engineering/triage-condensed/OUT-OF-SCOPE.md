# Out-of-Scope Knowledge Base

`.out-of-scope/` stores rejected feature requests.

• **Institutional memory** — why rejected
• **Deduplication** — surface prior decisions on similar issues

## Directory structure

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

One file per **concept**, not per issue.

## File format

Relaxed, readable — short design doc style.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### Naming

Kebab-case concept name: `dark-mode.md`, `plugin-system.md`.

### Writing the reason

Substantive — project scope, technical constraints, strategic decisions. Durable — not temporary deferrals.

## When to check `.out-of-scope/`

During triage (Gather context): read all files. Match by concept similarity (not keywords) — "night theme" → `dark-mode.md`. Surface: "Similar to `.out-of-scope/dark-mode.md` — rejected because [reason]. Still feel the same?"

Maintainer may: **Confirm** (append to Prior requests, close) · **Reconsider** (delete/update file, proceed) · **Disagree** (distinct, normal triage)

## When to write

Only when an **enhancement** is rejected as `wontfix`:

1. Maintainer decides out of scope
2. Matching file exists? → append to Prior requests
3. Else → create file (concept, decision, reason, first request)
4. Comment on issue + mention file
5. Close with `wontfix`

## Updating or removing

Mind changed → delete file. Don't reopen old issues. New issue proceeds through normal triage.
