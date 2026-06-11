# CONTEXT.md Format

## Structure

```md
# {Context Name}

{One or two sentence description of what this context is and why it exists.}

## Language

**Order**:
{A one or two sentence description of the term}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account
```

## Rules

• **Opinionated** — pick best term; list others under `_Avoid_`
• **Tight definitions** — 1–2 sentences; what it IS, not what it does
• **Project-specific only** — no general programming concepts
• **Subheadings** when natural clusters; flat list if single cohesive area

## Single vs multi-context

**Single:** one root `CONTEXT.md`.

**Multi:** root `CONTEXT-MAP.md` lists contexts, locations, relationships (see template in original format).

Infer structure: `CONTEXT-MAP.md` → multi; root `CONTEXT.md` only → single; neither → create root `CONTEXT.md` lazily. Multi-context: infer topic's context; ask if unclear.
