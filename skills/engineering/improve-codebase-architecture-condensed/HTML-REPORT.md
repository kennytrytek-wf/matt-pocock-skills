# HTML Report Format

Self-contained HTML in OS temp dir. Tailwind + Mermaid from CDNs. Mermaid for graphs; hand-built divs/SVG for editorial visuals (mass, cross-section). Mix — don't Mermaid everything.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review — {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## Header

Repo name, date, legend: solid box = module, dashed = seam, red arrow = leakage, thick dark = deep module. No intro paragraph.

## Candidate card

Diagrams carry weight. Prose sparse; glossary terms ([LANGUAGE.md](./LANGUAGE.md)).

Each `<article>`:

• **Title** — deepening name (e.g. "Collapse the Order intake pipeline")
• **Badge row** — strength (`Strong` emerald, `Worth exploring` amber, `Speculative` slate) + dependency tag (`in-process`, `local-substitutable`, `ports & adapters`, `mock`)
• **Files** — `font-mono text-sm`
• **Before / After** — two columns; see patterns
• **Problem** — one sentence
• **Solution** — one sentence
• **Wins** — bullets ≤6 words
• **ADR callout** (if applicable) — amber box, one line

Diagram unclear → redraw, don't add paragraph.

## Diagram patterns

### Mermaid graph (dependencies / call flow)

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[OrderHandler] --> B[OrderValidator]
      B --> C[OrderRepo]
      C -.leak.-> D[PricingClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### Hand-built boxes-and-arrows

`<div>` modules + SVG arrows when Mermaid layout fights you — thick deep module with greyed internals.

### Cross-section

Horizontal bands — before: 6 thin layers; after: 1 thick consolidated band.

### Mass diagram

Interface vs implementation rectangles — shallow: similar height; deep: short interface, tall implementation.

### Call-graph collapse

Before: nested call tree. After: one box, internal calls faded inside.

## Style

Editorial not dashboard. Whitespace. Serif headings optional. One accent + red leakage + amber warnings. Diagrams ~320px tall. `text-xs uppercase tracking-wider` for labels. Only Tailwind + Mermaid scripts — static report.

## Top recommendation

One card: name, one sentence why, anchor link.

## Tone

Plain English; nouns from [LANGUAGE.md](./LANGUAGE.md).

**Use exactly:** module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

**Never:** component, service, unit (for module) · API, signature (for interface) · boundary (for seam) · layer, wrapper (when you mean module).

**Wins bullets** in glossary terms — not "easier to maintain" or "cleaner code."

No hedging. Sentence → bullet if possible. Bullet → cut if possible. Term not in [LANGUAGE.md](LANGUAGE.md) → reach for glossary term first.
