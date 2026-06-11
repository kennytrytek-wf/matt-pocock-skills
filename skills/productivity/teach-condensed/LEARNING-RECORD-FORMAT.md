# Learning Record Format

`./learning-records/` — `0001-slug.md`, `0002-slug.md`, … Create dir lazily on first record.

ADR-like: non-obvious lessons, insights, prior knowledge → zone of proximal development.

## Template

```md
# {Short title of what was learned or established}

{1-3 sentences: what was learned (or what prior knowledge was established), and why it matters for future sessions.}
```

Single paragraph OK. Value = _that_ known + _why_ it changes what to teach next.

## Optional sections

Only when valuable:

• **Status** frontmatter (`active | superseded by LR-NNNN`)
• **Evidence** — how demonstrated (question, exercise, prior experience cited)
• **Implications** — unlocks/rules out for future sessions

## Numbering

Scan `./learning-records/` for highest number; increment.

## When to write

When any true:

1. **Genuine understanding of something non-trivial** — can use correctly; new floor for next teach
2. **Disclosed prior knowledge** — "I already know X"; record depth claimed
3. **Misconception corrected** — high-value; predicts future stumbling blocks
4. **Mission shifted from learning** — cross-link [[MISSION.md]]; update it

### What does _not_ qualify

• Merely covered — coverage ≠ learning
• Already in [[GLOSSARY.md]] as term definition — don't duplicate
• Session activity logs — decision-grade insights only

## Supersession

Contradicted by later record → mark old `Status: superseded by LR-NNNN`; don't delete. Evolution history = useful signal.
