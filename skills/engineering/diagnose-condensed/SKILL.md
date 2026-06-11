---
name: diagnose
description: Reproduce → minimise → hypothesise → instrument → fix → regression-test. Use when user says diagnose/debug, reports bug, broken/throwing/failing, or performance regression.
---

Disciplined diagnosis for hard bugs. Skip phases only when explicitly justified.

Use domain glossary + ADRs in area touched.

## Phase 1 — Build a feedback loop

**This is the skill.** Fast, deterministic, agent-runnable pass/fail signal → you find the cause. No loop → staring at code won't save you.

Spend disproportionate effort. **Be aggressive. Be creative. Refuse to give up.**

### Construct loop — try roughly this order

1. **Failing test** at seam reaching bug — unit, integration, e2e
2. **Curl / HTTP script** against dev server
3. **CLI invocation** with fixture input, diff stdout vs snapshot
4. **Headless browser** (Playwright/Puppeteer) — DOM/console/network asserts
5. **Replay captured trace** — network/payload/event log on disk
6. **Throwaway harness** — minimal subset, single function call
7. **Property / fuzz loop** — 1000 random inputs for intermittent wrong output
8. **Bisection harness** — automate boot-at-state-X for `git bisect run`
9. **Differential loop** — same input old vs new, diff outputs
10. **HITL bash script** — last resort; if a human must click, drive them with `scripts/hitl-loop.template.sh`; captured output feeds back

Build the right loop → bug 90% fixed.

### Iterate on the loop

• Faster? (cache setup, skip init, narrow scope)
• Sharper signal? (assert specific symptom, not "didn't crash")
• More deterministic? (pin time, seed RNG, isolate FS, freeze network)

30s flaky loop ≈ no loop. 2s deterministic loop = superpower.

### Non-deterministic bugs

Goal: **higher reproduction rate**. Loop 100×, parallelise, stress, narrow timing, inject sleeps. 50% flake = debuggable; 1% = not — keep raising rate.

### When you genuinely cannot build a loop

Stop explicitly. List what you tried. Ask user for: (a) repro environment access, (b) captured artifact (HAR, log, core dump, recording), or (c) permission for temporary production instrumentation. Do **not** proceed to hypothesise without a loop.

Do not proceed to Phase 2 until you have a loop you believe in.

## Phase 2 — Reproduce

Run loop. Confirm:

- [ ] Failure matches **user** description — not nearby different failure
- [ ] Reproducible across runs (or high enough rate for non-deterministic)
- [ ] Exact symptom captured (error, wrong output, timing) for later verification

Do not proceed until you reproduce.

## Phase 3 — Hypothesise

**3–5 ranked hypotheses** before testing. Single hypothesis anchors on first plausible idea.

Each hypothesis must be **falsifiable** — state prediction:

> "If <X> is the cause, then <changing Y> will make the bug disappear / <changing Z> will make it worse."

No prediction → vibe — discard or sharpen.

**Show ranked list to user before testing.** Domain knowledge may re-rank. Don't block if AFK.

## Phase 4 — Instrument

Each probe must map to Phase 3 prediction. **Change one variable at a time.**

Tool preference:

1. **Debugger / REPL** — one breakpoint beats ten logs
2. **Targeted logs** at hypothesis boundaries
3. Never "log everything and grep"

**Tag every debug log** with unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup = single grep.

**Perf branch:** baseline measurement first (timing harness, `performance.now()`, profiler, query plan); bisect. Measure first, fix second.

## Phase 5 — Fix + regression test

Regression test **before fix** — only if **correct seam** exists.

Correct seam: test exercises **real bug pattern** at call site. Too shallow (single-caller when bug needs multiple, unit can't replicate chain) → false confidence.

**No correct seam = finding.** Codebase architecture prevents lock-down. Flag for next phase.

If correct seam:

1. Minimised repro → failing test at seam
2. Watch fail
3. Apply fix
4. Watch pass
5. Re-run Phase 1 loop on original (un-minimised) scenario

## Phase 6 — Cleanup + post-mortem

Required before done:

- [ ] Original repro no longer reproduces (re-run Phase 1 loop)
- [ ] Regression test passes (or absence of seam documented)
- [ ] All `[DEBUG-...]` removed (`grep` prefix)
- [ ] Throwaway prototypes deleted (or marked debug location)
- [ ] Correct hypothesis stated in commit/PR message

**Then:** what would have prevented this bug? Architectural answer (no test seam, tangled callers, hidden coupling) → hand off to `/improve-codebase-architecture` **after** fix is in, not before.
