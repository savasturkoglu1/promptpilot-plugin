# PromptPilot — Claude Code Plugin

Turns rough, vague prompts into precise, context-enriched prompts — inside your agent session.

```
/prompt-pilot "buggy login thing fix it"
```

→ The agent explores your codebase read-only (Read/Grep/Glob), then returns an optimized prompt with real `@file/paths` and concrete symbols woven in. It never implements the task itself — you review the enriched prompt and reply `run` to execute it.

Because Claude Code already has read-only codebase tools and knows your working directory, no extra binary or MCP server is needed — the command is pure instructions.

## Install

From the plugin marketplace:

```
/plugin marketplace add savasturkoglu1/promptpilot-plugin
/plugin install prompt-pilot@promptpilot
```

Or locally for development:

```
/plugin marketplace add /path/to/promptpilot
/plugin install prompt-pilot@promptpilot
```

## Usage

```
/prompt-pilot "make the parser faster"
/prompt-pilot "add error handling to @src/auth/login.ts"
/prompt-pilot "hata yönetimi ekle -turkce"
/prompt-pilot "parser'ı hızlandır -o"
```

- `@path` mentions in your prompt seed the exploration; without them, relevant files are inferred from keywords.
- The optimized prompt is shown under a "⚡ Optimized Prompt" heading. Reply **run** to execute it, or describe what to add/change — the prompt is re-optimized and shown again.
- **Language flag** (optional, anywhere in the prompt): `-turkce` / `-dutch` / any language name → rewrite in that language; `-o` → keep the original prompt's language; no flag → English (best results with coding agents).
- **Loop flag** (optional): `-loop` appends a `LOOP HARNESS` section to the optimized prompt — a measurable exit condition, a verify-fix iteration loop with objective checks, a bounded iteration budget, explicit stop conditions, and an honest exit report. Use it for tasks like "make all tests pass" or "get page load under 50ms" where one-pass execution isn't enough.
