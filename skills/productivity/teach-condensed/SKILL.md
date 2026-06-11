---
name: teach
description: Teach user a skill/concept in this workspace. Use when user wants to learn something over multiple sessions.
disable-model-invocation: true
argument-hint: "What would you like to learn about?"
---

Stateful multi-session teaching request.

## Teaching Workspace

Current directory = teaching workspace. State in:

• `MISSION.md` — why user cares; format: [MISSION-FORMAT.md](./MISSION-FORMAT.md)
• `./reference/*.html` — compressed learnings (cheat sheets, algorithms, syntax, poses, glossaries); beautiful, print-friendly, quick reference
• `RESOURCES.md` — trusted sources; format: [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md)
• `./learning-records/*.md` — non-obvious lessons (ADR-like); `0001-<dash-case>.md`; format: [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md); drives zone of proximal development
• `./lessons/*.html` — one self-contained lesson per tightly-scoped thing tied to mission; primary teaching unit
• `NOTES.md` — preferences, working notes

## Philosophy

Deep learning needs:

• **Knowledge** — high-trust resources
• **Skills** — interactive lessons from knowledge
• **Wisdom** — interaction with learners/practitioners

Before `RESOURCES.md` populated → find high-quality resources. Never trust parametric knowledge alone.

Topics vary: physics = knowledge-heavy; yoga = skills-heavy.

### Fluency vs Storage Strength

• **Fluency** — in-the-moment retrieval (illusory mastery)
• **Storage** — long-term retention (real goal)

Design for storage via desirable difficulty: retrieval practice, spacing, interleaving (skills only).

## Lessons

Main output — self-contained HTML in `./lessons/` as `0001-<dash-case>.html` (incrementing).

• **Beautiful** — clean typography (Tufte-style); user revisits
• Short, quick, within working memory; one tangible win tied to mission; zone of proximal development
• Open lesson via CLI if possible
• HTML anchors link lessons + reference docs
• Recommend primary high-trust source per lesson
• Reminder to ask followup questions — agent is teacher

## The Mission

Every lesson tied to mission. Unclear mission or empty `MISSION.md` → interview user on why first.

No mission → abstract lessons, no next-step judgment.

Missions change with skill/knowledge → update `MISSION.md` + learning record; confirm with user first.

## Zone Of Proximal Development

Challenge "just enough" each lesson.

User specifies topic, or infer from:

• `learning-records`
• mission
• most relevant thing in ZPD

## Knowledge

Lessons around a skill to learn. Knowledge = only what's required. Teach knowledge → interactive practice loop.

Gather from trusted resources via `RESOURCES.md`. Citations in lessons. For knowledge acquisition, difficulty is the enemy (eats working memory).

## Skills

Durability + flexibility. Difficulty is the tool — effortful retrieval builds storage.

Interactive lessons: quizzes, light in-browser tasks, real-world step lists (yoga poses).

**Feedback loop** — tight, immediate, ideally automatic.

Quizzes: each answer exactly same word count (and chars if possible) — no formatting clues.

## Acquiring Wisdom

Real-world interaction outside learning environment.

Wisdom questions → attempt answer, delegate to **community** (forum, subreddit, class, local group).

Find high-reputation communities. Respect opt-out preference.

## Reference Documents

While creating lessons, build reference docs — compressed essence for quick revisit.

Good for: syntax/snippets, algorithms/flowcharts, poses/sequences, exercises, glossaries.

Glossaries essential — adhere in every lesson once created. Format: [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md).

## `NOTES.md`

Record teaching preferences and things to keep in mind for future sessions.
