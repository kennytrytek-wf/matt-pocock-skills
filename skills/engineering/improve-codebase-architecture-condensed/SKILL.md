---
name: improve-codebase-architecture
description: Find deepening opportunities informed by CONTEXT.md and docs/adr/. Use when improving architecture, refactoring opportunities, consolidating coupled modules, or improving testability/AI-navigability.
---

Surface architectural friction; propose **deepening opportunities** — shallow → deep modules. Aim: testability + AI-navigability.

## Glossary

Use terms exactly in every suggestion. Full defs: [LANGUAGE.md](./LANGUAGE.md). Don't drift to "component," "service," "API," "boundary."

• **Module** — interface + implementation (function, class, package, slice)
• **Interface** — everything caller must know: types, invariants, error modes, ordering, config — not just signature
• **Implementation** — code inside
• **Depth** — leverage at interface: much behaviour behind small interface. **Deep** = high leverage. **Shallow** = interface nearly as complex as implementation
• **Seam** — where interface lives; alter behaviour without editing in place (not "boundary")
• **Adapter** — concrete thing satisfying interface at seam
• **Leverage** — what callers get from depth
• **Locality** — what maintainers get: change, bugs, knowledge concentrated

Key principles ([LANGUAGE.md](./LANGUAGE.md)):

• **Deletion test:** delete module — complexity vanishes (pass-through) vs reappears across N callers (earning keep)
• **The interface is the test surface.**
• **One adapter = hypothetical seam. Two adapters = real seam.**

Informed by domain model (`CONTEXT.md` names seams; ADRs = don't re-litigate).

## Process

### 1. Explore

Read domain glossary + ADRs in area first.

Agent tool `subagent_type=Explore` — organic walk; note friction:

• Understanding one concept bounces across many small modules?
• **Shallow** modules — interface ≈ implementation complexity?
• Pure functions extracted for testability but bugs hide in call patterns (no **locality**)?
• Tightly-coupled modules leak across seams?
• Untested or hard-to-test via current interface?

**Deletion test** on suspects: delete → concentrate complexity or just move it?

### 2. Present candidates as HTML report

Self-contained HTML to OS temp dir — nothing in repo. `$TMPDIR` or `/tmp` (Windows: `%TEMP%`) → `<tmpdir>/architecture-review-<timestamp>.html`. Open: `xdg-open` / `open` / `start`. Tell user absolute path.

**Tailwind CDN** layout + **Mermaid CDN** for graph-shaped diagrams. Mix Mermaid with hand-built CSS/SVG (mass diagrams, cross-sections, collapse animations). Each candidate: **before/after visualisation**.

Per candidate card:

• **Files** — involved modules
• **Problem** — friction
• **Solution** — plain English change
• **Benefits** — locality, leverage, test improvement
• **Before / After diagram** — side-by-side
• **Recommendation strength** — `Strong` | `Worth exploring` | `Speculative` (badge)

End: **Top recommendation** — first pick + why.

**CONTEXT.md** vocabulary for domain; [LANGUAGE.md](./LANGUAGE.md) for architecture. "Order intake module" not "FooBarHandler" or "Order service."

**ADR conflicts:** surface only when friction warrants revisiting ADR. Warning callout: _"contradicts ADR-0007 — but worth reopening because…"_

See [HTML-REPORT.md](./HTML-REPORT.md). Do NOT propose interfaces yet. After write: ask "Which would you like to explore?"

### 3. Grilling loop

User picks candidate → grilling conversation. Design tree: constraints, dependencies, deepened module shape, behind seam, surviving tests.

Inline side effects:

• New module name not in `CONTEXT.md`? → add term ([CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md)); create lazily. Same discipline as `/grill-with-docs`
• Fuzzy term sharpened? → update `CONTEXT.md` inline
• User rejects with load-bearing reason? → offer ADR: _"Record as ADR so future reviews don't re-suggest?"_ Only when future explorer needs it — skip ephemeral/self-evident. [ADR-FORMAT.md](./ADR-FORMAT.md)
• Explore alternative interfaces? → [INTERFACE-DESIGN.md](./INTERFACE-DESIGN.md)
