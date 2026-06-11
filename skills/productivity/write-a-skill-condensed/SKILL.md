---
name: write-a-skill
description: Create agent skills with structure, progressive disclosure, bundled resources. Use when user wants to create, write, or build a new skill.
---

# Writing Skills

## Process

1. **Gather requirements** — task/domain, use cases, scripts vs instructions only, reference materials
2. **Draft** — `SKILL.md`; ref files if >500 lines; utility scripts if deterministic ops needed
3. **Review with user** — coverage, gaps, detail level

## Structure

```
skill-name/
├── SKILL.md           # required
├── REFERENCE.md    # optional
├── EXAMPLES.md     # optional
└── scripts/        # optional
```

## Description (agent routing)

Only thing agent sees when picking skills. Max 1024 chars. Third person. Sentence 1: capability. Sentence 2: `Use when [triggers]`.

Good: specific capability + triggers. Bad: "Helps with documents."

## Scripts when

• Deterministic (validation, formatting)
• Same code regenerated repeatedly
• Explicit error handling needed

## Split files when

• SKILL.md >100 lines
• Distinct domains
• Advanced features rarely needed

## Review checklist

- [ ] Description includes "Use when..." triggers
- [ ] SKILL.md under 100 lines
- [ ] No time-sensitive info
- [ ] Consistent terminology
- [ ] Concrete examples
- [ ] References one level deep
