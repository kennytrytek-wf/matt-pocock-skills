---
name: scaffold-exercises
description: Create exercise directory structures with sections, problems, solutions, and explainers that pass linting. Use when user wants to scaffold exercises, create exercise stubs, or set up a new course section.
---

Create exercise structures passing `pnpm ai-hero-cli internal lint`, then `git commit`.

## Directory naming

- **Sections**: `XX-section-name/` in `exercises/` (e.g. `01-retrieval-skill-building`)
- **Exercises**: `XX.YY-exercise-name/` in section (e.g. `01.03-retrieval-with-bm25`)
- Section # = `XX`, exercise # = `XX.YY`
- Dash-case names (lowercase, hyphens)

## Exercise variants

Each exercise needs at least one of:

- `problem/` — student workspace with TODOs
- `solution/` — reference implementation
- `explainer/` — conceptual material, no TODOs

Stubbing default: `explainer/` unless plan specifies otherwise.

## Required files

Each subfolder (`problem/`, `solution/`, `explainer/`) needs `readme.md`:

- **Not empty** (must have real content, even a single title line works)
- No broken links

Stub minimal readme:

```md
# Exercise Title

Description here
```

Subfolder with code → also `main.ts` (>1 line). Stubs: readme-only OK.

## Workflow

1. **Parse plan** — section names, exercise names, variant types
2. **Create directories** — `mkdir -p` each path
3. **Stub readmes** — one per variant folder
4. **Lint** — `pnpm ai-hero-cli internal lint`
5. **Fix errors** — iterate until pass

## Lint rules summary

`pnpm ai-hero-cli internal lint` checks:

- Each exercise has subfolders (`problem/`, `solution/`, `explainer/`)
- At least one of `problem/`, `explainer/`, or `explainer.1/` exists
- `readme.md` exists, non-empty in primary subfolder
- No `.gitkeep`
- No `speaker-notes.md`
- No broken links in readmes
- No `pnpm run exercise` in readmes
- `main.ts` required per subfolder unless readme-only

## Moving/renaming

1. `git mv` (not `mv`) — preserves history
2. Update numeric prefix for order
3. Re-run lint

Example:

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

## Example stub from plan

Plan:

```
Section 05: Memory Skill Building
- 05.01 Introduction to Memory
- 05.02 Short-term Memory (explainer + problem + solution)
- 05.03 Long-term Memory
```

Create:

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

Readme stubs:

```
exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md -> "# Introduction to Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md -> "# Long-term Memory"
```
