# UI Prototype

Several radically different UI variations on one route, switchable from floating bottom bar. User flips variants, picks one (or steals bits), throws rest away.

Logic/state question → wrong branch. Use [LOGIC.md](./LOGIC.md).

## When this shape

- "What should this page look like?"
- "See a few dashboard options before committing."
- "Try a different layout for settings."
- Any time user would spend a day picking between vague mockups in their head.

## Sub-shapes — strongly prefer A

Easier to judge **butting up against rest of app** — real header, sidebar, data, density. Vacuum route makes every variant look fine. Default A when plausible existing page hosts variants. B only when no nearby home.

### A — existing page (preferred)

Route exists. Variants on same route, gated by `?variant=` search param. Existing fetch/params/auth stay — only rendering swaps. Default unless specific reason not to.

No page yet but would live inside one (dashboard section, settings card, flow step) → still A. Mount variants inside host page.

### B — new page (last resort)

Only when no existing page — new top-level surface or unembeddable flow.

Throwaway route per project routing convention; don't invent new top-level structure. Name obviously prototype (e.g. `prototype` in path). Same `?variant=` pattern.

Before B: sanity-check — really no page to embed in? Empty route hides design problems.

Both sub-shapes: identical floating bottom bar.

## Process

### 1. State question; pick N

Default **3 variants**. Cap at 5 — beyond that, noise not radical difference.

One-line plan in location or top-of-file comment:

> "Three variants of the settings page, switchable via `?variant=`, on the existing `/settings` route."

### 2. Generate radically different variants

Per variant:

- Page purpose + data access
- Project component library / styling (Tailwind, shadcn, MUI, etc.)
- Clear export name: `VariantA`, `VariantB`, `VariantC`

Variants must be **structurally different** — layout, hierarchy, primary affordance; not just colours. Three tweaked card grids = wallpaper not prototype. Too similar → redo with explicit constraint (e.g. "do not use a card grid").

### 3. Wire together

Single switcher on route:

```tsx
// pseudo-code — adapt to the project's framework
const variant = searchParams.get('variant') ?? 'A';
return (
  <>
    {variant === 'A' && <VariantA {...data} />}
    {variant === 'B' && <VariantB {...data} />}
    {variant === 'C' && <VariantC {...data} />}
    <PrototypeSwitcher variants={['A','B','C']} current={variant} />
  </>
);
```

Sub-shape A: existing fetch above switcher; only subtree changes per variant.

Sub-shape B: throwaway route `/prototype/<name>` mounts same switcher.

### 4. Floating switcher

Fixed bottom-centre bar:

- **Left arrow** — previous variant (wrap)
- **Variant label** — key + optional name, e.g. `B — Sidebar layout`
- **Right arrow** — forward (wrap)

Behaviour:

- Arrows update URL search param via framework router (`router.replace` Next, `navigate` React Router, etc.) — shareable, reload-stable
- Keyboard `←`/`→` cycle; don't intercept when `<input>`, `<textarea>`, or `[contenteditable]` focused
- Visually distinct from page (high-contrast pill, shadow) — not part of design under evaluation
- Hidden in production — `process.env.NODE_ENV !== 'production'` or equivalent

Single shared component; locate where shared UI lives.

### 5. Hand over

Surface URL + `?variant=` keys. Feedback often: "header from B, sidebar from C" — that's the actual design.

### 6. Capture answer; clean up

Winner + why (commit, ADR, issue, or `NOTES.md` if AFK). Then:

- **A** — delete losers + switcher; fold winner into existing page
- **B** — promote winner to real route; delete throwaway route + switcher

Don't leave variant components or switcher lying around.

## Anti-patterns

- Variants differing only in colour/copy — tweak not prototype
- Shared `<Layout>` between variants — shared `<Header>` OK; each variant free to throw out layout
- Real mutations — read-only OK; mutations → stub
- Promoting prototype directly to production — rewrite properly when folding in
