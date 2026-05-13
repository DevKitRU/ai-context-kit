#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/init-ai-context.sh [project-dir] [--force]

What it does:
  - creates docs/ai_context/
  - copies starter context files
  - creates AGENTS.md if missing
  - appends a short ai_context hint to AGENTS.md if needed

It does not read .env, databases, logs, uploads, or private keys.
USAGE
}

target="."
force="0"

for arg in "$@"; do
  case "$arg" in
    --force)
      force="1"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      target="$arg"
      ;;
  esac
done

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
kit_dir="$(cd -- "$script_dir/.." && pwd)"
template_dir="$kit_dir/templates"
target_dir="$(cd -- "$target" && pwd)"
context_dir="$target_dir/docs/ai_context"

copy_file() {
  local src="$1"
  local dst="$2"

  if [[ -f "$dst" && "$force" != "1" ]]; then
    echo "skip existing: ${dst#$target_dir/}"
    return
  fi

  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "write: ${dst#$target_dir/}"
}

mkdir -p "$context_dir"

copy_file "$template_dir/docs/ai_context/PROJECT_MAP.md" "$context_dir/PROJECT_MAP.md"
copy_file "$template_dir/docs/ai_context/CURRENT_GOAL.md" "$context_dir/CURRENT_GOAL.md"
copy_file "$template_dir/docs/ai_context/DANGER_ZONES.md" "$context_dir/DANGER_ZONES.md"
copy_file "$template_dir/docs/ai_context/VERIFICATION.md" "$context_dir/VERIFICATION.md"
copy_file "$template_dir/docs/ai_context/DECISIONS.jsonl" "$context_dir/DECISIONS.jsonl"
copy_file "$template_dir/docs/ai_context/SESSION_SUMMARY.md" "$context_dir/SESSION_SUMMARY.md"

agents_file="$target_dir/AGENTS.md"
hint='For faster cold start, read `docs/ai_context/PROJECT_MAP.md` next, then only the relevant `docs/ai_context/*` file for the task.'

if [[ ! -f "$agents_file" ]]; then
  copy_file "$template_dir/AGENTS.md" "$agents_file"
elif ! grep -q "docs/ai_context/PROJECT_MAP.md" "$agents_file"; then
  {
    printf '\n## AI Context\n\n'
    printf '%s\n' "$hint"
  } >> "$agents_file"
  echo "append hint: AGENTS.md"
else
  echo "AGENTS.md already links ai_context"
fi

echo
echo "Done. Next:"
echo "  1. Fill docs/ai_context/PROJECT_MAP.md with real paths."
echo "  2. Fill DANGER_ZONES.md before giving the project to an agent."
echo "  3. Keep secrets out of these files."
