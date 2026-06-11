# Writing Agent Briefs

Authoritative spec for AFK agent when issue moves to `ready-for-agent`. Issue body/discussion = context; agent brief = contract.

## Principles

### Durability over precision

Issue may sit in `ready-for-agent` days/weeks; codebase changes. Brief stays useful as files rename/move/refactor.

- **Do** — interfaces, types, behavioral contracts; name types, signatures, config shapes to find/modify
- **Don't** — file paths, line numbers, assume current structure persists

### Behavioral, not procedural

Describe **what**, not **how**. Agent explores fresh.

- **Good:** "`SkillConfig` accepts optional `schedule: CronExpression`"
- **Bad:** "Open src/types/skill.ts line 42"
- **Good:** "`/triage` with no args shows issues needing attention"
- **Bad:** "Add switch in main handler"

### Complete acceptance criteria

Concrete, testable, independently verifiable.

- **Good:** "`gh issue list --label needs-triage` returns classified issues"
- **Bad:** "Triage should work correctly"

### Explicit scope boundaries

State out of scope — prevents gold-plating.

## Template

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** one-line description of what needs to happen

**Current behavior:**
Describe what happens now. For bugs, this is the broken behavior.
For enhancements, this is the status quo the feature builds on.

**Desired behavior:**
Describe what should happen after the agent's work is complete.
Be specific about edge cases and error conditions.

**Key interfaces:**
- `TypeName` — what needs to change and why
- `functionName()` return type — what it currently returns vs what it should return
- Config shape — any new configuration options needed

**Acceptance criteria:**
- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2
- [ ] Specific, testable criterion 3

**Out of scope:**
- Thing that should NOT be changed or addressed in this issue
- Adjacent feature that might seem related but is separate
```

## Anti-patterns

- No category; vague summary; file paths/line numbers; no acceptance criteria; no scope; no current vs desired behavior
