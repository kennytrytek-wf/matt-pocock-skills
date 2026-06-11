---
name: setup-pre-commit
description: Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests. Use when user wants pre-commit hooks, Husky, lint-staged, or commit-time formatting/typechecking/testing.
---

## What this sets up

- **Husky** pre-commit hook
- **lint-staged** — Prettier on staged files
- **Prettier** config (if missing)
- **typecheck** + **test** in pre-commit hook

## Steps

### 1. Detect package manager

`package-lock.json` (npm), `pnpm-lock.yaml` (pnpm), `yarn.lock` (yarn), `bun.lockb` (bun). Default npm if unclear.

### 2. Install dependencies

DevDependencies:

```
husky lint-staged prettier
```

### 3. Initialize Husky

```bash
npx husky init
```

Creates `.husky/` + `prepare: "husky"` in package.json.

### 4. Create `.husky/pre-commit`

Write this file (no shebang needed for Husky v9+):

```
npx lint-staged
npm run typecheck
npm run test
```

**Adapt**: detected package manager instead of `npm`. No `typecheck`/`test` script → omit lines; tell user.

### 5. Create `.lintstagedrc`

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. Create `.prettierrc` (if missing)

Only if no Prettier config exists:

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. Verify

- [ ] `.husky/pre-commit` exists and executable
- [ ] `.lintstagedrc` exists
- [ ] `prepare` script in package.json is `"husky"`
- [ ] prettier config exists
- [ ] Run `npx lint-staged`

### 8. Commit

Stage all; commit: `Add pre-commit hooks (husky + lint-staged + prettier)`

Runs new hooks — smoke test.

## Notes

- Husky v9+ — no shebangs in hook files
- `prettier --ignore-unknown` skips unparseable files
- Pre-commit: lint-staged first (fast, staged-only), then full typecheck + tests
