# Interface Design

Explore alternative interfaces for chosen deepening. "Design It Twice" (Ousterhout) — first idea rarely best.

Vocabulary: [LANGUAGE.md](./LANGUAGE.md) — **module**, **interface**, **seam**, **adapter**, **leverage**.

## Process

### 1. Frame the problem space

Before sub-agents, user-facing explanation:

• Constraints any new interface must satisfy
• Dependencies + category ([DEEPENING.md](./DEEPENING.md))
• Rough illustrative code sketch — not proposal, grounds constraints

Show user, proceed immediately to Step 2. User reads while sub-agents work.

### 2. Spawn sub-agents

3+ parallel Agent sub-agents. Each: **radically different** interface.

Separate technical brief per agent (paths, coupling, dependency category from [DEEPENING.md](./DEEPENING.md), behind seam). Different design constraint each:

• Agent 1: Minimize interface — 1–3 entry points max; maximise leverage
• Agent 2: Maximise flexibility — many use cases, extension
• Agent 3: Optimise default caller — trivial common case
• Agent 4 (if applicable): Ports & adapters for cross-seam deps

Include [LANGUAGE.md](./LANGUAGE.md) + `CONTEXT.md` vocabulary in brief.

Each outputs:

1. Interface (types, methods, params, invariants, ordering, error modes)
2. Usage example
3. What implementation hides behind seam
4. Dependency strategy + adapters ([DEEPENING.md](./DEEPENING.md))
5. Trade-offs — leverage high/thin

### 3. Present and compare

Sequential presentation, then prose compare by **depth**, **locality**, **seam placement**.

Give recommendation: strongest design + why. Hybrid if elements combine well. Be opinionated — not a menu.
