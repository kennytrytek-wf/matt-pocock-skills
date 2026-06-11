---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable issues on the project issue tracker using tracer-bullet vertical slices. Use when user wants to convert a plan into issues, create implementation tickets, or break down work into issues.
---

Break a plan into independently-grabbable issues using **tracer bullet** vertical slices.

The issue tracker and triage label vocabulary should have been provided to you — run `/setup-matt-pocock-skills` if not.

## Process

### 1. Gather context

Work from conversation context. If user passes issue ref (number, URL, path) → fetch full body + comments from issue tracker.

### 2. Explore codebase (optional)

If not explored — use domain glossary; respect ADRs in touched areas.

### 3. Draft vertical slices

Break into **tracer bullet** issues. Each = thin vertical slice through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

Slices: **HITL** (human interaction required) or **AFK** (implement + merge without human). Prefer AFK over HITL.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present numbered breakdown. Per slice:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which slices must complete first
- **User stories covered**: which user stories (if source has them)

Ask:

- Granularity right? (too coarse / too fine)
- Dependency relationships correct?
- Merge or split further?
- Correct HITL/AFK marking?

Iterate until approved.

### 5. Publish to issue tracker

Per approved slice → new issue (body template below). Ready for AFK agents → correct triage label unless instructed otherwise.

Publish in dependency order (blockers first) for real issue IDs in "Blocked by".

<issue-template>
## Parent

A reference to the parent issue on the issue tracker (if the source was an existing issue, otherwise omit this section).

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets — they go stale fast. Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it here and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- A reference to the blocking ticket (if any)

Or "None - can start immediately" if no blockers.

</issue-template>

Do NOT close or modify any parent issue.
