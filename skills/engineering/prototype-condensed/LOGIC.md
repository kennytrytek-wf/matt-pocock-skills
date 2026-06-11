# Logic Prototype

Tiny interactive terminal app — user drives state model by hand. For **business logic, state transitions, data shape** — reasonable on paper, wrong once pushed through real cases.

## When this shape

- "State machine edge case where X then Y?"
- "Data model represent case where...?"
- "Feel out API before writing it."
- User wants to **press buttons and watch state change**.

"What should this look like" → wrong branch. Use [UI.md](./UI.md).

## Process

### 1. State the question

Before code: state model + question. One paragraph in README or top-of-file comment. Wrong question = pure waste — explicit for check later (user watching or AFK).

### 2. Pick language

Host project runtime. No obvious runtime (docs repo) → ask. Match existing tooling — don't add package manager/runtime for prototype.

### 3. Isolate logic in portable module

Logic behind small pure interface liftable to real codebase. TUI throwaway; logic module not.

Shape by question:

- **Pure reducer** `(state, action) => state` — discrete events, single state value
- **State machine** — explicit states/transitions; legal actions part of question
- **Pure functions** over plain data — no implicit current state
- **Class/module with method surface** — logic owns ongoing internal state

Pick shape fitting question, *not* easiest TUI wiring. Pure: no I/O, no terminal code, no `console.log` control flow. TUI imports logic; nothing flows other direction.

Validated reducer/machine/functions lift to real module; TUI shell deleted.

### 4. Smallest TUI exposing state

Lightweight TUI — each tick clear screen (`console.clear()` / `print("\033[2J\033[H")` / equivalent), re-render whole frame. User should always see one stable view, not growing scrollback.

Each frame:

1. **Current state** — pretty-printed, diff-friendly (field per line or JSON). **Bold** field names/headers; **dim** less important (timestamps, IDs, derived). ANSI: `\x1b[1m` bold, `\x1b[2m` dim, `\x1b[0m` reset.
2. **Keyboard shortcuts** bottom: `[a] add user  [d] delete user  [t] tick clock  [q] quit`. Bold key, dim description (or vice versa).

Behaviour:

1. **Initialise state** — in-memory object; render first frame
2. **Read one keystroke (or line)** → handler mutates state
3. **Re-render** full frame after every action — replace, don't append
4. **Loop until quit**

Whole frame fits one screen.

### 5. One command to run

Script in project task runner (`package.json`, `Makefile`, `justfile`, `pyproject.toml`). `pnpm run <prototype-name>` — never remember a path. No task runner → command at top of README.

### 6. Hand over

Run command. Interesting moments: "that shouldn't be possible" / "assumed X different" — bugs in the *idea*. Add actions as requested; prototypes evolve.

### 7. Capture answer

Answer only thing worth keeping. User around → ask what it taught. Else `NOTES.md` for verdict before delete.

## Anti-patterns

- **Don't add tests** — needs tests = no longer prototype
- **Don't wire real database** — in-memory unless question is persistence
- **Don't generalise** — no "support X later"; one question
- **Don't blur logic and TUI** — reducer referencing `console.log`/prompts/escape codes = not portable
- **Don't ship TUI shell to production** — logic module worth keeping
