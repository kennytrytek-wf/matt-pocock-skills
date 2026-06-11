# ADR Format

`docs/adr/` — sequential `0001-slug.md`, `0002-slug.md`, … Create dir lazily on first ADR.

## Template

```md
# {Short title of the decision}

{1-3 sentences: what's the context, what did we decide, and why.}
```

Single paragraph OK. Value = *that* decision + *why*.

## Optional sections (only when valuable)

• **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`)
• **Considered Options** — rejected alternatives worth remembering
• **Consequences** — non-obvious downstream effects

## Numbering

Scan `docs/adr/` for highest number; increment by one.

## When to offer ADR

All three required:

1. **Hard to reverse**
2. **Surprising without context**
3. **Real trade-off** with genuine alternatives

Skip if easy to reverse, not surprising, or no real alternative.

### Qualifies

• Architectural shape • Integration patterns between contexts • Tech with lock-in (DB, bus, auth, deploy — not every library) • Boundary/scope decisions • Deliberate non-obvious deviations • Constraints not in code • Rejected alternatives when rejection non-obvious
