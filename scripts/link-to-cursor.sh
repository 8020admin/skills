#!/usr/bin/env bash
# Link all skills in this repo into ~/.cursor/skills/ so Cursor sees them.
# Run from repo root: ./scripts/link-to-cursor.sh
# After 'git pull', skills stay up to date (symlinks point at the repo).

set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CURSOR_SKILLS="${CURSOR_SKILLS:-$HOME/.cursor/skills}"

if [[ ! -d "$CURSOR_SKILLS" ]]; then
  echo "Creating $CURSOR_SKILLS"
  mkdir -p "$CURSOR_SKILLS"
fi

for dir in "$REPO_ROOT"/*/; do
  name=$(basename "$dir")
  if [[ -f "$dir/SKILL.md" ]]; then
    target="$CURSOR_SKILLS/$name"
    if [[ -L "$target" ]]; then
      current=$(readlink "$target")
      if [[ "$current" == "$dir" || "$current" == "$dir/" ]]; then
        echo "Already linked: $name"
        continue
      fi
    fi
    if [[ -e "$target" ]]; then
      echo "Skip (exists, not our link): $name at $target"
      continue
    fi
    ln -s "$dir" "$target"
    echo "Linked: $name -> $dir"
  fi
done

echo "Done. Skills in this repo are now available in Cursor (restart Cursor if needed)."
