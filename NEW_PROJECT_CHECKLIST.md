# New Project Checklist

This is the small routine for every new project before Codex or Claude starts doing real work.

## 1. Add the context layer

Run from `ai-context-kit`:

```bash
./scripts/init-ai-context.sh /path/to/project
```

Or copy `templates/docs/ai_context/` by hand.

## 2. Fill only the useful facts

Start with short files.

- `PROJECT_MAP.md`: what the project is, main folders, entry points.
- `CURRENT_GOAL.md`: what we are doing now and what is not the goal.
- `DANGER_ZONES.md`: secrets, production, user data, paid APIs, migrations.
- `VERIFICATION.md`: exact commands to check a change.
- `DECISIONS.jsonl`: one durable decision per line.
- `SESSION_SUMMARY.md`: what changed in the last session.

## 3. Add the agent hint

Put this in `AGENTS.md` or `CLAUDE.md`:

```md
For faster cold start, read `docs/ai_context/PROJECT_MAP.md` next, then only the relevant `docs/ai_context/*` file for the task.
```

## 4. Check secrets

Do not put values in context files.

Write:

```text
Do not read `.env`. It contains Telegram token and API keys.
```

Do not write:

```text
BOT_TOKEN=...
```

## 5. First agent task

Ask the agent to inspect the project without touching runtime data:

```text
Read AGENTS.md and docs/ai_context/PROJECT_MAP.md.
Do not read .env, tokens, keys, DB, logs, uploads, or private user data.
Tell me what files matter for this task and what verification you would run.
```

## 6. Before commit

Run the project checklist from `VERIFICATION.md`.

Also check:

```bash
git status --short
git diff --check
```

If the project has secrets nearby, run a targeted scan that excludes `.env` values from output.
