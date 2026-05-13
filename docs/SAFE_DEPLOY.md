# Safe Deploy For Beginners

Deploy is not "copy files and hope".

Use a simple routine.

## Normal flow

```text
local change
local verification
git commit
git push
server git pull
restart service
smoke test
```

## Before deploy

Check:

```bash
git status --short
git diff --check
```

Run the project tests from `docs/ai_context/VERIFICATION.md`.

If the change touches auth, payments, production DB, migrations, nginx, Docker, cron, systemd, or external APIs, read `docs/ai_context/DANGER_ZONES.md` first.

## On the server

Prefer:

```bash
git pull
systemctl restart service-name
systemctl is-active service-name
```

Use Docker commands only if the project is Docker based.

Avoid random `scp` deploys unless it is an emergency and you write down what was copied.

## After deploy

Run a small smoke test.

Examples:

```bash
curl -fsS http://127.0.0.1:8000/health
systemctl is-active service-name
journalctl -u service-name --since "5 minutes ago" --no-pager
```

Do not paste logs with tokens into chat.

Redact first.

## Rollback note

Before risky production work, know the rollback.

Write it in plain text:

```text
Rollback: git checkout previous commit, restart service, restore DB backup if migration changed data.
```

If you cannot say the rollback, the deploy is not ready.
