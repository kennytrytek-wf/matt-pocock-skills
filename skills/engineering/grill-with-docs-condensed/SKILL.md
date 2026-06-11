---
name: grill-with-docs
description: Grilling session vs domain model; sharpens terminology; updates CONTEXT.md and ADRs inline. Use when stress-testing plan against project language and documented decisions.
---

<what-to-do>

Interview relentlessly until shared understanding. Walk design tree; resolve dependencies one-by-one. Recommend answer per question.

• One question at a time; wait for feedback
• If answerable by codebase → explore instead

</what-to-do>

<supporting-info>

## Domain docs

Single context (typical): root `CONTEXT.md`, `docs/adr/`, `src/`.

Multi-context: root `CONTEXT-MAP.md` → per-context `CONTEXT.md` + `docs/adr/`.

Create lazily: no `CONTEXT.md` until first term resolved; no `docs/adr/` until first ADR needed.

## Session rules

• **Glossary conflict** — user term vs `CONTEXT.md` → call out immediately
• **Fuzzy language** — propose precise canonical term
• **Scenarios** — stress-test domain relationships with edge-case scenarios
• **Code cross-ref** — user claim vs code → surface contradictions
• **Update CONTEXT.md inline** — on term resolution; don't batch. Format: [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md). Glossary only — no implementation details. Do not treat `CONTEXT.md` as a spec, scratch pad, or repository for implementation decisions
• **ADRs sparingly** — only when all three true: (1) hard to reverse, (2) surprising without context, (3) real trade-off with alternatives. Else skip. Format: [ADR-FORMAT.md](./ADR-FORMAT.md)

</supporting-info>
