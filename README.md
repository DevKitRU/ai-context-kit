# ai-context-kit

Простая система контекста для Codex, Claude и других AI-агентов.

Не фреймворк.
Не секретный промпт.
Не замена нормальной документации.

Это стартовые рельсы для проекта: агент сначала читает карту, потом опасные зоны и проверки, а уже после этого открывает нужные файлы.

Главная идея:

```text
Контекст должен быть роутером, а не архивом.
```

Новая сессия агента не должна читать весь репозиторий, старые чаты, логи, базы и секреты. Ей нужна короткая карта: где вход, что опасно, чем проверить результат и какие решения уже приняты.

## Для кого

Для человека, который вайбкодит с AI-агентом и хочет меньше хаоса:

- агент быстрее понимает проект;
- не перечитывает одно и то же в каждой вкладке;
- не лезет в `.env`, базы, логи и приватные данные;
- не забывает текущую цель;
- записывает решения и итог сессии рядом с кодом;
- постепенно строит свою маленькую систему памяти под конкретный проект.

## Уровни

Начинай с Level 0. Остальное добавляй только когда реально нужно.

```text
Level 0: Для новичка
AGENTS.md
docs/ai_context/PROJECT_MAP.md
docs/ai_context/DANGER_ZONES.md
docs/ai_context/VERIFICATION.md

Level 1: Чтобы не терять контекст
docs/ai_context/CURRENT_GOAL.md
docs/ai_context/SESSION_SUMMARY.md
docs/ai_context/DECISIONS.jsonl

Level 2: Чтобы не разрасталось
docs/ai_context/CONTEXT_HYGIENE.md
scripts/check-ai-context.sh
лимиты размера файлов
проверка секретов
проверка jsonl

Level 3: Для тех, кто вырос
docs/ai_context/optional/FINDINGS.jsonl
docs/ai_context/optional/EVIDENCE_LEDGER.md
ошибки, выводы, ссылки на доказательства
кандидаты в долговременную память

Level 4: Advanced, не для первого дня
codex-map-like индекс
MCP/router
Telegram или voice вход
Project Memory
метрики, watchdog, audit
```

Подробнее: [`docs/LEVELS.md`](docs/LEVELS.md).

## Что добавляется в проект по умолчанию

```text
docs/ai_context/
├── PROJECT_MAP.md
├── CURRENT_GOAL.md
├── DANGER_ZONES.md
├── VERIFICATION.md
├── DECISIONS.jsonl
├── SESSION_SUMMARY.md
└── CONTEXT_HYGIENE.md
```

Плюс короткая ссылка из `AGENTS.md` или `CLAUDE.md`.

Optional Level 3 templates лежат в `templates/docs/ai_context/optional/`.
Их можно добавить позже:

```bash
./scripts/init-ai-context.sh /path/to/project --with-level3
```

## Быстрый старт

Вариант 1. Скриптом:

```bash
./scripts/init-ai-context.sh /path/to/project
```

Вариант 2. Руками:

Скопируй папку `templates/docs/ai_context/` в свой проект.

Потом добавь в `AGENTS.md`:

```md
For faster cold start, read `docs/ai_context/PROJECT_MAP.md` next, then only the relevant `docs/ai_context/*` file for the task.
```

Если у тебя Claude, добавь похожую строку в `CLAUDE.md`.

## Первый запрос агенту

Скопируй это в Codex или Claude внутри своего проекта:

```text
Read AGENTS.md and docs/ai_context/PROJECT_MAP.md.
Do not read .env, tokens, keys, DB, logs, uploads, backups, or private user data.
Set up the smallest useful AI context system for this project:
- keep Level 0 required;
- add Level 1 if the project will continue across sessions;
- add Level 2 checks if context files may grow;
- do not add Level 3 unless there are repeated decisions, bugs, or findings.
Tell me what files matter for the current task and what verification you would run.
```

## Как заполнять

Начни коротко.

Не надо писать книгу.

Хороший `PROJECT_MAP.md` на старте может быть на 40 строк.
Хороший `DANGER_ZONES.md` может быть на 20 строк.
Хороший `SESSION_SUMMARY.md` должен сжимать прошлую сессию, а не хранить весь чат.

Правило:

```text
Если файл не помогает новой вкладке быстрее и безопаснее работать, его надо сократить или удалить.
```

## Что нельзя класть в эти файлы

Не клади:

- токены;
- пароли;
- `.env`;
- приватные ключи;
- VPN config;
- реальные IP личных серверов;
- базы данных;
- логи с пользователями;
- приватные чаты.

Пиши так:

```text
Не читать `.env`. Там лежат token и API keys.
```

Не пиши так:

```text
BOT_TOKEN=...
```

Подробнее: [`docs/SECRET_SAFETY.md`](docs/SECRET_SAFETY.md).

## Проверка контекста

После установки можно проверить структуру:

```bash
./scripts/check-ai-context.sh /path/to/project
```

Скрипт проверяет наличие базовых файлов, размер контекстных файлов, валидность JSONL и явные риски секретов в tracked files. Если Level 3 включен, он также проверит `optional/FINDINGS.jsonl`. Он не печатает значения секретов.

## Для каких проектов подходит

Подходит почти для всего:

- Telegram bot;
- web app;
- SaaS;
- WordPress site;
- парсер;
- личный automation repo;
- большой monorepo.

Для маленького проекта хватит Level 0-1.

Для большого monorepo можно добавить карты по сервисам:

```text
docs/ai_context/
└── services/
    ├── api.md
    ├── webapp.md
    └── deploy.md
```

## Почему не один огромный промпт

Огромный промпт быстро устаревает.

Файлы рядом с проектом проще поддерживать. Когда меняется код, меняешь и карту. Когда новая вкладка стартует, агент читает только нужный кусок.

Это и есть простая версия context engineering:

```text
сначала карта -> потом нужная зона -> потом конкретные файлы -> потом проверка
```

## Что дальше

Готово в этом наборе:

- скрипт `scripts/init-ai-context.sh`;
- скрипт `scripts/check-ai-context.sh`;
- чеклист `NEW_PROJECT_CHECKLIST.md`;
- шаблон `AGENTS.md`;
- шаблоны `docs/ai_context/*`;
- памятка по уровням в `docs/LEVELS.md`;
- памятка по гигиене контекста в `docs/CONTEXT_HYGIENE.md`;
- памятка по секретам в `docs/SECRET_SAFETY.md`;
- минимальный deploy flow в `docs/SAFE_DEPLOY.md`.

Важное ограничение: этот набор не пытается быть универсальным мозгом. Он дает правила и шаблоны, чтобы твой агент сам собрал маленькую систему под твой проект.
