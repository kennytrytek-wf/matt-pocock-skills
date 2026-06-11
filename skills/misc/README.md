# Misc

Tools I keep around but rarely use.

- **[git-guardrails-claude-code](./git-guardrails-claude-code/SKILL.md)** — Set up Claude Code hooks to block dangerous git commands (push, reset --hard, clean, etc.) before they execute.
- **[migrate-to-shoehorn](./migrate-to-shoehorn/SKILL.md)** — Migrate test files from `as` type assertions to @total-typescript/shoehorn.
- **[scaffold-exercises](./scaffold-exercises/SKILL.md)** — Create exercise directory structures with sections, problems, solutions, and explainers.
- **[setup-pre-commit](./setup-pre-commit/SKILL.md)** — Set up Husky pre-commit hooks with lint-staged, Prettier, type checking, and tests.

## Maintaining condensed skills

Each skill has a token-optimized `-condensed` sibling directory (e.g. `triage-condensed/`) that preserves all normative rules while reducing token usage. These are not listed above to keep this README readable.

To create a new condensed skill or re-sync one after upstream changes, use **[condense-a-skill](./condense-a-skill/SKILL.md)**. After editing, run the verify script to confirm no rules were dropped:

```bash
./scripts/verify-skill-condensed.sh skills/misc/git-guardrails-claude-code
./scripts/verify-skill-condensed.sh --all
```
