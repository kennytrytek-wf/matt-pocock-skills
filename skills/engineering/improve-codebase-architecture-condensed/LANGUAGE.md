# Language

Shared vocabulary — use exactly. Don't substitute "component," "service," "API," "boundary."

## Terms

**Module** — interface + implementation; scale-agnostic (function, class, package, slice). _Avoid:_ unit, component, service.

**Interface** — everything caller must know: signature, invariants, ordering, error modes, config, perf. _Avoid:_ API, signature (too narrow).

**Implementation** — body of code. Distinct from **Adapter** (role at seam, not substance).

**Depth** — leverage at interface. **Deep** = much behaviour, small interface. **Shallow** = interface ≈ implementation complexity.

**Seam** _(Feathers)_ — alter behaviour without editing there; interface location. _Avoid:_ boundary (DDD overload).

**Adapter** — satisfies interface at seam; describes role, not substance.

**Leverage** — caller benefit from depth; one implementation, N call sites, M tests.

**Locality** — maintainer benefit; change/bugs/knowledge concentrated; fix once, fixed everywhere.

## Principles

• **Depth is interface property, not implementation.** Deep module can have internal seams (private, own tests) + external seam at interface.
• **Deletion test.** Delete module — complexity vanishes (pass-through) vs reappears across N callers (earning keep).
• **The interface is the test surface.** Test past interface → wrong module shape.
• **One adapter = hypothetical seam. Two adapters = real seam.** Don't introduce seam unless something varies.

## Relationships

Module → one Interface. Depth = Module property vs Interface. Seam = Interface location. Adapter at Seam satisfies Interface. Depth → Leverage + Locality.

## Rejected framings

• Depth as implementation/interface line ratio (Ousterhout) — we use depth-as-leverage
• "Interface" = TS `interface` keyword only — too narrow
• "Boundary" — say **seam** or **interface**
