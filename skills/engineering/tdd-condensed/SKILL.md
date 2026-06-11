---
name: tdd
description: Test-driven development with red-green-refactor loop. Use when building/fixing via TDD, "red-green-refactor", integration tests, or test-first development.
---

# Test-Driven Development

## Philosophy

**Core:** Tests verify behavior through public interfaces, not implementation details.

• **Good tests** — integration-style; real code paths via public APIs; describe _what_; survive refactors
• **Bad tests** — mock internals, test private methods, verify via external means (DB direct vs interface); break on refactor without behavior change

See [tests.md](./tests.md), [mocking.md](./mocking.md).

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.** Horizontal slicing → crap tests: imagined behavior, shape not user-facing behavior, insensitive tests, outrun headlights.

**Correct:** Vertical slices via tracer bullets. One test → one implementation → repeat. Each test responds to prior cycle; you know exactly what behavior matters and how to verify it.

```
WRONG (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  ...
```

## Workflow

### 1. Planning

Use domain glossary + ADRs in area touched.

Before code:

- [ ] Confirm interface changes with user
- [ ] Confirm behaviors to test (prioritize)
- [ ] [Deep modules](./deep-modules.md) opportunities
- [ ] [Testability](./interface-design.md) in interface design
- [ ] List behaviors (not implementation steps)
- [ ] User approval on plan

Ask: public interface? Which behaviors matter most?

**You can't test everything.** Confirm critical paths/complex logic with user.

### 2. Tracer Bullet

ONE test, ONE thing:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

Tracer bullet — proves path end-to-end.

### 3. Incremental Loop

Per remaining behavior:

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules: one test at a time; only enough code to pass; don't anticipate future tests; observable behavior only.

### 4. Refactor

After all pass, [refactor candidates](./refactoring.md):

- [ ] Extract duplication
- [ ] Deepen modules (complexity behind simple interfaces)
- [ ] SOLID where natural
- [ ] What new code reveals about existing code
- [ ] Run tests after each refactor step

**Never refactor while RED.** Get to GREEN first.

## Checklist Per Cycle

```
[ ] Test describes behavior, not implementation
[ ] Test uses public interface only
[ ] Test would survive internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
```
