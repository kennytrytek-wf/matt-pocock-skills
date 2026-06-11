# Deepening

Deepen shallow module clusters safely given dependencies. Vocabulary: [LANGUAGE.md](./LANGUAGE.md) — **module**, **interface**, **seam**, **adapter**.

## Dependency categories

Category determines how deepened module is tested across seam.

### 1. In-process

Pure computation, in-memory, no I/O. Always deepenable — merge modules, test via new interface. No adapter.

### 2. Local-substitutable

Local test stand-ins (PGLite, in-memory FS). Deepenable if stand-in exists. Seam internal; no port at external interface.

### 3. Remote but owned (Ports & Adapters)

Own services across network. **Port** at seam; transport as injected **adapter**. Tests: in-memory adapter. Prod: HTTP/gRPC/queue adapter.

Shape: _"Port at seam, HTTP adapter prod + in-memory adapter tests — logic in one deep module across network."_

### 4. True external (Mock)

Third-party (Stripe, Twilio). Injected port; mock adapter in tests.

## Seam discipline

• **One adapter = hypothetical seam. Two adapters = real seam.** No port unless ≥2 adapters justified (prod + test).
• **Internal vs external seams.** Deep module can have private internal seams (own tests) + external seam at interface. Don't expose internal seams through interface because tests use them.

## Testing strategy: replace, don't layer

• Old shallow-module unit tests → waste once interface tests exist — delete
• New tests at deepened module's interface. **The interface is the test surface.**
• Assert observable outcomes through interface, not internal state
• Tests survive internal refactors — behaviour not implementation. Test changes with implementation → testing past interface
