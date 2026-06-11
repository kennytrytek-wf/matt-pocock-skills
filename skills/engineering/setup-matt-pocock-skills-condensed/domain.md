# Domain Docs

How engineering skills consume this repo's domain documentation.

## Before exploring, read these

• **`CONTEXT.md`** at root, or
• **`CONTEXT-MAP.md`** → per-context `CONTEXT.md` for relevant topic
• **`docs/adr/`** — ADRs touching the area; multi-context: also `src/<context>/docs/adr/`

Missing files → **proceed silently**. Don't flag absence; don't suggest creating upfront. `/grill-with-docs` creates lazily.

## File structure

Single-context:

```
/
├── CONTEXT.md
├── docs/adr/
└── src/
```

Multi-context (`CONTEXT-MAP.md` at root):

```
/
├── CONTEXT-MAP.md
├── docs/adr/
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## Use glossary vocabulary

Name domain concepts per `CONTEXT.md`. Don't use avoided synonyms.

Concept missing → inventing language (reconsider) or real gap (note for `/grill-with-docs`).

## Flag ADR conflicts

Contradict existing ADR → surface explicitly:

> _Contradicts ADR-0007 (event-sourced orders) — but worth reopening because…_
