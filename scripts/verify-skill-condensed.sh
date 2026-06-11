#!/usr/bin/env bash
# -----------------------------------------------------------------------
# verify-skill-condensed.sh
#
# For each original skill, checks that its -condensed sibling contains
# every "normative atom" — a keyword or phrase that carries a rule
# (e.g. "must not", "never", "ready-for-agent").
#
# Usage:
#   ./scripts/verify-skill-condensed.sh skills/engineering/triage
#   ./scripts/verify-skill-condensed.sh --all
#
# Exit code: 0 = all OK, 1 = one or more pairs have missing atoms.
# -----------------------------------------------------------------------
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"


# -----------------------------------------------------------------------
# NORMATIVE_ATOMS
#
# The list of words and phrases we look for in each skill.
# If an atom is present in the original but absent from the condensed
# version, that is a failure — a rule was dropped during condensation.
#
# Grouped by category so it is easy to add new ones.
# -----------------------------------------------------------------------

# Generic obligation and prohibition language
OBLIGATION_ATOMS=(
  "must not"
  "must"
  "never"
  "do not"
  "don't"
  "required"
  "exactly"
  "always"
  "only when"
)

# Triage state-machine role names (used in triage + setup-matt-pocock-skills)
TRIAGE_ROLE_ATOMS=(
  "needs-triage"
  "needs-info"
  "ready-for-agent"
  "ready-for-human"
  "wontfix"
)

# File and directory paths that skills reference by convention
PATH_ATOMS=(
  "context.md"
  "context-map.md"
  "docs/adr/"
  ".out-of-scope/"
)

# Section headings that are part of required normative templates
TEMPLATE_HEADING_ATOMS=(
  "## agent brief"
  "## triage notes"
  "## agent skills"
)

# TDD vocabulary
TDD_ATOMS=(
  "red-green"
  "vertical slice"
  "horizontal slice"
  "tracer bullet"
)

# Architecture vocabulary (improve-codebase-architecture)
ARCHITECTURE_ATOMS=(
  "deletion test"
  "deep module"
  "shallow module"
)

# Hard-dependency setup pointers that must survive condensation
SETUP_POINTER_ATOMS=(
  "run /setup-matt-pocock-skills"
)

# Cross-skill invocation references
SKILL_REFERENCE_ATOMS=(
  "/grill-with-docs"
  "/grill-me"
  "/triage"
  "/tdd"
  "/diagnose"
)

# Domain terms used across multiple skills
DOMAIN_ATOMS=(
  "issue tracker"
  "triage role"
  "agent brief"
  "acceptance criteria"
)

# Combine all groups into one array for use during scanning
ALL_ATOMS=(
  "${OBLIGATION_ATOMS[@]}"
  "${TRIAGE_ROLE_ATOMS[@]}"
  "${PATH_ATOMS[@]}"
  "${TEMPLATE_HEADING_ATOMS[@]}"
  "${TDD_ATOMS[@]}"
  "${ARCHITECTURE_ATOMS[@]}"
  "${SETUP_POINTER_ATOMS[@]}"
  "${SKILL_REFERENCE_ATOMS[@]}"
  "${DOMAIN_ATOMS[@]}"
)


# -----------------------------------------------------------------------
# strip_frontmatter <file>
#
# SKILL.md files begin with a YAML frontmatter block like this:
#
#   ---
#   name: triage
#   description: ...
#   ---
#
# We skip this block when scanning for atoms because the name and
# description legitimately differ between original and condensed, and
# we don't want those differences to trigger false failures.
#
# This function prints everything after the closing "---" line.
# -----------------------------------------------------------------------
strip_frontmatter() {
  local file="$1"
  local delimiter_count=0

  while IFS= read -r line; do
    if [[ $delimiter_count -lt 2 ]]; then
      # We are still inside the frontmatter block.
      # Count "---" delimiters but do not print anything yet.
      if [[ "$line" == "---" ]]; then
        delimiter_count=$(( delimiter_count + 1 ))
      fi
    else
      # We are past the closing "---" line. Print the rest of the file.
      echo "$line"
    fi
  done < "$file"
}


# -----------------------------------------------------------------------
# collect_and_normalise_text <dir> <output_file>
#
# Reads every .md and .sh file in <dir> (except README.md) and writes
# their combined, normalised text to <output_file>.
#
# Normalisation steps, in order:
#   1. Strip SKILL.md frontmatter (name/description differ by design)
#   2. Remove Markdown formatting characters so atoms are not hidden
#      inside backticks or bold/italic markers
#   3. Lowercase everything so atom matching is case-insensitive
# -----------------------------------------------------------------------
collect_and_normalise_text() {
  local dir="$1"
  local output_file="$2"

  # Collect files in sorted order for deterministic output
  local files=()
  while IFS= read -r -d '' f; do
    files+=("$f")
  done < <(find "$dir" -type f \( -name '*.md' -o -name '*.sh' \) ! -name 'README.md' -print0 | sort -z)

  # Start with an empty output file
  : > "$output_file"

  # Step 1: Write each file's content, stripping frontmatter from SKILL.md
  for f in "${files[@]}"; do
    if [[ "$(basename "$f")" == "SKILL.md" ]]; then
      strip_frontmatter "$f" >> "$output_file"
    else
      cat "$f" >> "$output_file"
    fi
  done

  # Step 2: Remove Markdown formatting characters.
  #
  #   `foo`    ->  foo   (inline code)
  #   **foo**  ->  foo   (bold)
  #   *foo*    ->  foo   (italic)
  #
  # Without this step, an atom like "must" inside `must` would not match.
  local stripped_markdown
  stripped_markdown="$(mktemp)"
  sed \
    -e 's/`\([^`]*\)`/\1/g' \
    -e 's/\*\*\([^*]*\)\*\*/\1/g' \
    -e 's/\*\([^*]*\)\*/\1/g' \
    "$output_file" > "$stripped_markdown"

  # Step 3: Lowercase everything so we match "Must", "MUST", and "must" equally
  tr '[:upper:]' '[:lower:]' < "$stripped_markdown" > "$output_file"

  rm -f "$stripped_markdown"
}


# -----------------------------------------------------------------------
# find_present_atoms <text_file> <output_file>
#
# Searches <text_file> for each atom in ALL_ATOMS.
# Writes one line per atom that is present to <output_file>.
#
# Using an explicit loop (rather than one large regex) means:
#   - Each atom is easy to read and reason about
#   - Adding or removing atoms is a one-line change
#   - A failure message names the exact atom that is missing
# -----------------------------------------------------------------------
find_present_atoms() {
  local text_file="$1"
  local output_file="$2"

  : > "$output_file"

  for atom in "${ALL_ATOMS[@]}"; do
    # -q  = quiet (we only care about presence, not where)
    # -F  = fixed string (atoms are literals, not regexes)
    if grep -qF "$atom" "$text_file"; then
      echo "$atom" >> "$output_file"
    fi
  done

  # Sort so we can use comm to diff two atom lists
  sort -u "$output_file" -o "$output_file"
}


# -----------------------------------------------------------------------
# count_bytes <dir>
#
# Returns the total size in bytes of all .md and .sh files in <dir>,
# excluding README.md.
# -----------------------------------------------------------------------
count_bytes() {
  local dir="$1"
  local total=0

  while IFS= read -r -d '' f; do
    local file_size
    file_size="$(wc -c < "$f")"
    total=$(( total + file_size ))
  done < <(find "$dir" -type f \( -name '*.md' -o -name '*.sh' \) ! -name 'README.md' -print0)

  echo "$total"
}


# -----------------------------------------------------------------------
# verify_pair <original_skill_dir>
#
# Verifies that the -condensed sibling of <original_skill_dir> contains
# every normative atom found in the original.
#
# Output:
#   OK   <skill>  all atoms present; byte reduction shown
#   FAIL <skill>  atoms are missing from condensed (list follows)
#   WARN <skill>  condensed has atoms not in original (informational only)
#   SKIP <skill>  no SKILL.md found; skipped
#
# Returns exit code 1 on FAIL, 0 otherwise.
# -----------------------------------------------------------------------
verify_pair() {
  local original_dir="$1"

  local skill_name
  skill_name="$(basename "$original_dir")"

  local condensed_dir
  condensed_dir="$(dirname "$original_dir")/${skill_name}-condensed"

  # Guard: original must have a SKILL.md
  if [[ ! -f "$original_dir/SKILL.md" ]]; then
    echo "SKIP $original_dir (no SKILL.md found)"
    return 0
  fi

  # Guard: condensed sibling must exist
  if [[ ! -d "$condensed_dir" ]] || [[ ! -f "$condensed_dir/SKILL.md" ]]; then
    echo "FAIL $skill_name: condensed sibling not found at $condensed_dir"
    return 1
  fi

  # Collect and normalise text from both the original and condensed dirs
  local original_text condensed_text
  original_text="$(mktemp)"
  condensed_text="$(mktemp)"
  collect_and_normalise_text "$original_dir"  "$original_text"
  collect_and_normalise_text "$condensed_dir" "$condensed_text"

  # Find which atoms are present in each side
  local original_atoms condensed_atoms
  original_atoms="$(mktemp)"
  condensed_atoms="$(mktemp)"
  find_present_atoms "$original_text"  "$original_atoms"
  find_present_atoms "$condensed_text" "$condensed_atoms"

  # Diff the two atom lists using comm.
  #
  # comm compares two sorted files and produces three columns:
  #   column 1 = lines only in file 1  (original only)
  #   column 2 = lines only in file 2  (condensed only)
  #   column 3 = lines in both files
  #
  # -2 -3  suppresses columns 2 and 3 -> shows only "original only" = missing from condensed
  # -1 -3  suppresses columns 1 and 3 -> shows only "condensed only" = new in condensed
  local missing_from_condensed
  missing_from_condensed="$(comm -2 -3 "$original_atoms" "$condensed_atoms")"

  local added_in_condensed
  added_in_condensed="$(comm -1 -3 "$original_atoms" "$condensed_atoms")"

  # Byte reduction stats
  local original_bytes condensed_bytes reduction_pct
  original_bytes="$(count_bytes "$original_dir")"
  condensed_bytes="$(count_bytes "$condensed_dir")"
  if [[ "$original_bytes" -gt 0 ]]; then
    reduction_pct=$(( (original_bytes - condensed_bytes) * 100 / original_bytes ))
  else
    reduction_pct=0
  fi

  # Report results
  local exit_code=0

  if [[ -n "$missing_from_condensed" ]]; then
    echo "FAIL $skill_name: the following atoms are in the original but missing from condensed:"
    echo "$missing_from_condensed" | sed 's/^/  - /'
    exit_code=1
  else
    echo "OK   $skill_name: all normative atoms present  ($original_bytes -> $condensed_bytes bytes, ${reduction_pct}% reduction)"
  fi

  if [[ -n "$added_in_condensed" ]]; then
    echo "WARN $skill_name: condensed contains atoms not in original — review to ensure no new rules were invented:"
    echo "$added_in_condensed" | sed 's/^/  - /'
  fi

  rm -f "$original_text" "$condensed_text" "$original_atoms" "$condensed_atoms"
  return "$exit_code"
}


# -----------------------------------------------------------------------
# list_shipped_skills
#
# Prints the directory path of every original (non-condensed) skill in
# the three shipped buckets: engineering/, productivity/, misc/.
#
# Excludes:
#   - *-condensed/ siblings  (those are what we are verifying against)
#   - condense-a-skill/      (maintenance tool, has no condensed twin)
# -----------------------------------------------------------------------
list_shipped_skills() {
  find skills/engineering skills/productivity skills/misc \
    -name SKILL.md \
    ! -path '*-condensed/*' \
    ! -path '*/condense-a-skill/*' \
    -print \
  | sed 's|/SKILL.md||' \
  | sort
}


# -----------------------------------------------------------------------
# main
# -----------------------------------------------------------------------
main() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
Usage:
  ./scripts/verify-skill-condensed.sh skills/engineering/triage   # verify one skill pair
  ./scripts/verify-skill-condensed.sh --all                       # verify all shipped pairs

Checks that each -condensed skill preserves every normative atom from the original.
Exits 1 if any pair has missing atoms.
EOF
    exit 1
  fi

  local any_failed=0

  if [[ "$1" == "--all" ]]; then
    while IFS= read -r skill_dir; do
      verify_pair "$skill_dir" || any_failed=1
    done < <(list_shipped_skills)
  else
    # Accept either a relative path (skills/engineering/triage)
    # or an absolute path (/Users/you/repo/skills/engineering/triage)
    local skill_dir="$1"
    if [[ "$skill_dir" != /* ]]; then
      skill_dir="$REPO/$skill_dir"
    fi
    verify_pair "$skill_dir" || any_failed=1
  fi

  exit "$any_failed"
}

main "$@"
