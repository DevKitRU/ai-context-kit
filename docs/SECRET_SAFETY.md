# Secret Safety For Beginners

The fastest way to break a project with AI is to paste tokens into chat or commit `.env`.

Use this rule:

```text
Secret values live in .env or a secret manager.
Agent context files only describe where secrets are, never what they are.
```

## What is a secret

- Telegram bot token.
- OpenAI, Groq, Anthropic, Google, Yandex, Cloudflare API key.
- OAuth client secret or refresh token.
- SSH private key.
- Database password.
- VPN config, VLESS link, UUID, private key, shortId.
- Production IP if the repo is public.

## Safe pattern

Good:

```text
The bot reads BOT_TOKEN from .env.
Do not read or print .env.
Use .env.example for variable names.
```

Bad:

```text
BOT_TOKEN=123456789:...
```

## Files to commit

Commit:

- `.env.example`
- `docs/ai_context/DANGER_ZONES.md`
- setup docs with variable names

Do not commit:

- `.env`
- `.env.local`
- `*.pem`
- `*.key`
- database files
- logs
- chat exports
- production backups

## If a secret leaked

1. Rotate it in the original service.
2. Update `.env` on every machine that runs the project.
3. Restart the service.
4. Check current tree has no secret.
5. Decide separately if git history needs cleanup.

Do not rely on "I deleted it in the next commit".

If a token was ever pushed, treat it as public.
