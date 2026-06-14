# Context Hygiene

AI context files should make the next session faster and safer.

They should not become a second messy repository.

## Good context

Good context answers:

- what is this project;
- where is the relevant code;
- what is dangerous;
- how to verify the result;
- what decision was already made;
- what should the next agent do first.

## Bad context

Bad context:

- copies the whole README;
- stores raw terminal logs;
- stores full chat transcripts;
- stores database rows;
- stores secrets or `.env` values;
- keeps old plans that are no longer true;
- grows until the agent has to summarize the summary.

## Suggested size limits

These are not strict rules, but they are useful warnings:

| File | Warning size |
| --- | --- |
| `PROJECT_MAP.md` | more than 120 lines |
| `DANGER_ZONES.md` | more than 80 lines |
| `VERIFICATION.md` | more than 120 lines |
| `CURRENT_GOAL.md` | more than 80 lines |
| `SESSION_SUMMARY.md` | more than 150 lines |
| `CONTEXT_HYGIENE.md` | more than 120 lines |

If a file is larger, split it into a route and details.

Example:

```text
PROJECT_MAP.md says: "For API internals, read docs/ai_context/services/api.md."
```

It should not copy all API internals into `PROJECT_MAP.md`.

## Structured facts

Use JSONL for facts that should stay exact:

- decisions;
- findings;
- bug lessons;
- evidence links;
- dates and statuses.

Use markdown for explanations and human-readable maps.

## End of session routine

At the end of a meaningful session:

1. Update `SESSION_SUMMARY.md`.
2. Add durable decisions to `DECISIONS.jsonl`.
3. Add useful findings to `optional/FINDINGS.jsonl` if Level 3 is enabled.
4. Run `scripts/check-ai-context.sh`.
5. Keep secrets, logs, DB files, and private data out of context.

## Weekly routine

Once in a while:

- remove stale goals;
- shorten old summaries;
- check broken links;
- check JSONL validity;
- check whether `PROJECT_MAP.md` still points to real files;
- archive or delete context that no longer helps.
