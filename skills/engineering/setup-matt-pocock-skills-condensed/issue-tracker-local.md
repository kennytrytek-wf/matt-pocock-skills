# Issue tracker: Local Markdown

Issues and PRDs as markdown in `.scratch/`.

## Conventions

• One feature per dir: `.scratch/<feature-slug>/`
• PRD: `.scratch/<feature-slug>/PRD.md`
• Issues: `.scratch/<feature-slug>/issues/<NN>-<slug>.md` from `01`
• Triage state: `Status:` line near top (see `triage-labels.md`)
• Comments append under `## Comments`

## When a skill says "publish to the issue tracker"

Create file under `.scratch/<feature-slug>/` (mkdir if needed).

## When a skill says "fetch the relevant ticket"

Read referenced path. User normally passes path or issue number.
