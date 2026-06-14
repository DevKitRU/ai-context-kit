# AI Context Levels

This project is not a big ready-made brain.

It is a way to help your own AI agent build the smallest useful context system for your repository.

## The rule

```text
Context is a router, not an archive.
```

The agent should not load the whole repo, old chats, logs, databases, or secrets. It should use a short map to choose the right files.

## Level 0: Beginner

Required for almost every project.

```text
AGENTS.md
docs/ai_context/PROJECT_MAP.md
docs/ai_context/DANGER_ZONES.md
docs/ai_context/VERIFICATION.md
```

Purpose:

- tell the agent what the project is;
- tell the agent what not to touch;
- tell the agent how to check the result.

This is enough for small projects.

## Level 1: Session continuity

Recommended when the project will continue across multiple sessions.

```text
docs/ai_context/CURRENT_GOAL.md
docs/ai_context/SESSION_SUMMARY.md
docs/ai_context/DECISIONS.jsonl
```

Purpose:

- keep the current task narrow;
- preserve the last useful summary;
- store durable decisions as one JSON object per line.

Do not paste full chats into `SESSION_SUMMARY.md`. Summarize only what helps the next session.

## Level 2: Context hygiene

Use when context files start growing or multiple agents touch the project.

```text
docs/ai_context/CONTEXT_HYGIENE.md
scripts/check-ai-context.sh
```

Purpose:

- warn when context files become too large;
- validate JSONL files;
- detect risky tracked files;
- keep `docs/ai_context` as a map, not a dumping ground.

Run:

```bash
./scripts/check-ai-context.sh /path/to/project
```

## Level 3: Evidence and findings

Optional.

Use when the project has repeated bugs, research findings, audits, or decisions that should not disappear.

```text
docs/ai_context/optional/FINDINGS.jsonl
docs/ai_context/optional/EVIDENCE_LEDGER.md
```

Purpose:

- record useful findings before they become long-term memory;
- connect a finding to evidence, commands, files, tests, or issue links;
- keep exact facts in structured data;
- keep markdown as a human-readable explanation.

Good finding:

```jsonl
{"date":"2026-06-14","type":"bug","summary":"Login test fails only when cached session exists.","evidence":"tests/test_auth.py::test_cached_session","status":"candidate"}
```

Bad finding:

```text
500 lines copied from a terminal, a chat, or a log file.
```

## Level 4: Advanced

Not for the first day.

Examples:

- code-map or symbol index;
- MCP router;
- Telegram, voice, or mobile entry point;
- project memory database;
- metrics, watchdog, audit, and dashboard.

These can be useful for a large personal or team setup, but they should grow from real pain. Do not copy an advanced system before Level 0-2 are stable.

## What to ask your agent

Use this prompt inside your project:

```text
Read AGENTS.md and docs/ai_context/PROJECT_MAP.md.
Do not read .env, tokens, private keys, DB, logs, uploads, backups, or private user data.
Inspect the project structure and propose the smallest useful AI context setup:
- keep Level 0 required;
- add Level 1 if the project continues across sessions;
- add Level 2 if context files may grow;
- add Level 3 only if there are repeated findings, bugs, or decisions.
Do not build advanced tools unless you can explain the concrete problem they solve.
```

## Maintenance rule

At the end of a meaningful session:

1. Update `SESSION_SUMMARY.md`.
2. Add a line to `DECISIONS.jsonl` only for durable decisions.
3. Add a line to `FINDINGS.jsonl` only for useful evidence or repeated lessons.
4. Run `scripts/check-ai-context.sh`.
5. Keep secrets out of all context files.
