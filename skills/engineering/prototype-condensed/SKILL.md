---
name: prototype
description: Build throwaway prototype to flesh out design before committing. Routes to terminal app (logic/state) or UI variations on one route. Use when user wants to prototype, sanity-check data model or state machine, mock up UI, explore design options, or says "prototype this", "let me play with it", "try a few designs".
---

Throwaway code that answers a question. Question decides shape.

## Pick a branch

From prompt, surrounding code, or ask user:

- **"Does this logic / state model feel right?"** → [LOGIC.md](./LOGIC.md). Tiny interactive terminal app; push state machine through hard-to-reason cases.
- **"What should this look like?"** → [UI.md](./UI.md). Several radically different UI variations on one route; switch via URL search param + floating bottom bar.

Getting branch wrong wastes the prototype. If ambiguous and user unreachable → default to branch matching surrounding code (backend → logic; page/component → UI); state assumption at top.

## Rules (both branches)

1. **Throwaway, clearly marked** — locate near module/page being prototyped; name so reader sees it's prototype not production. UI routes: obey existing routing convention; don't invent new top-level structure.
2. **One command to run** — project's task runner (`pnpm <name>`, `python <path>`, etc.). User must be able to start without thinking.
3. **No persistence by default** — state in memory. DB question → scratch DB or local file with "PROTOTYPE — wipe me" name.
4. **Skip polish** — no tests, no error handling beyond runnable, no abstractions.
5. **Surface state** — after every action (logic) or variant switch (UI), print/render full relevant state.
6. **Delete or absorb when done** — delete or fold validated decision into real code; don't leave rotting.

## When done

Answer is only thing worth keeping. Capture durably (commit message, ADR, issue, or `NOTES.md` next to prototype) with the question answered. User around → quick conversation; else leave placeholder for verdict before delete.
