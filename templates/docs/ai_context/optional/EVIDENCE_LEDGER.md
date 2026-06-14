# EVIDENCE_LEDGER

Optional Level 3 file.

Use this only when the project has repeated bugs, research findings, audits, or decisions that should not disappear.

## Rule

Do not paste raw logs, full chats, DB rows, private data, or secrets here.

Use short evidence references instead:

- file path;
- test name;
- command name;
- issue link;
- commit hash;
- report path;
- sanitized summary.

## Evidence chain

```text
shown -> persisted -> indexed -> verified -> usable
```

## Entries

### YYYY-MM-DD - Short title

- type: bug | decision | research | risk | lesson
- status: candidate | accepted | archived
- summary: one or two sentences
- evidence: path, command, test, issue, or doc link
- next action: what should happen next
