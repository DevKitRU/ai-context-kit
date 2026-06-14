# VERIFICATION

Что проверить перед финалом.

## Базово

```bash
git status --short
git diff --check
```

## Python

```bash
python3 -m py_compile path/to/file.py
python3 -m pytest
```

## Node

```bash
npm test
npm run lint
```

## Docs-only

```bash
git diff --check
```

## Safety checklist

- `.env` не читался и не печатался.
- Секреты не попали в diff.
- Runtime files не попали в git.
- Проверки соответствуют зоне правки.
- В `SESSION_SUMMARY.md` записано, что изменилось.
- Если есть `scripts/check-ai-context.sh`, он запущен или причина пропуска понятна.
