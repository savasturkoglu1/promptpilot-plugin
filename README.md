# PromptPilot

Turn rough, vague prompts into precise, context-enriched prompts — inside your AI coding agent session.

```
/prompt-pilot "buggy login thing fix it"
```

→ The agent explores your codebase **read-only**, then returns an optimized prompt with real `@file/paths` and concrete symbols woven in. It never implements the task itself — you review the enriched prompt and reply `run` to execute it.

Ships as a [Claude Code plugin](#claude-code-plugin) and as native custom commands for [Codex CLI, OpenCode, Gemini CLI, and Cursor](#other-agents-codex-opencode-gemini-cli-cursor). No server, no binary, no MCP — the command is pure instructions.

## Claude Code Plugin

```
/plugin marketplace add savasturkoglu1/promptpilot-plugin
/plugin install prompt-pilot@promptpilot
```

Then:

```
/prompt-pilot "make the parser faster"
/prompt-pilot "add error handling to @src/auth/login.ts"
/prompt-pilot "hata yönetimi ekle -turkce"
/prompt-pilot "parser'ı hızlandır -o"
```

See [plugin/README.md](plugin/README.md) for full usage, including the language and loop flags.

## Other Agents (Codex, OpenCode, Gemini CLI, Cursor)

Clone the repo, then run the installer:

```sh
git clone https://github.com/savasturkoglu1/promptpilot-plugin.git
cd promptpilot-plugin
scripts/install-agents.sh
```

Or pick agents / install into the current project only:

```sh
scripts/install-agents.sh codex opencode     # only these
scripts/install-agents.sh --project          # .opencode/ .gemini/ .cursor/ in cwd
```

| Agent | Installed to | Invoke |
|---|---|---|
| Codex CLI | `~/.codex/prompts/prompt-pilot.md` | `/prompt-pilot <rough prompt>` |
| OpenCode | `~/.config/opencode/command/prompt-pilot.md` | `/prompt-pilot <rough prompt>` |
| Gemini CLI | `~/.gemini/commands/prompt-pilot.toml` | `/prompt-pilot <rough prompt>` |
| Cursor | `~/.cursor/commands/prompt-pilot.md` | `/prompt-pilot <rough prompt>` |

## Flags

Both flags can appear anywhere in the prompt:

- **Language** — `-turkce` / `-dutch` / any language name → rewrite the optimized prompt in that language; `-o` → keep the original prompt's language; no flag → English (best results with coding agents).
- **Loop** — `-loop` appends a `LOOP HARNESS` section to the optimized prompt: a measurable exit condition, a verify-fix iteration loop with objective checks, a bounded iteration budget, explicit stop conditions, and an honest exit report. Use it for tasks like "make all tests pass" where one-pass execution isn't enough.

## How it works

The command instructs the agent to act as a prompt engineer under strict constraints: explore the codebase with read-only tools only (delegating to a subagent where the platform supports it, to keep the main context clean), rewrite the prompt using a WHAT/WHERE/HOW/CONSTRAINTS/VALIDATION structure, and present the result for approval. Nothing is executed until you reply `run`.

## Contributing

[plugin/commands/prompt-pilot.md](plugin/commands/prompt-pilot.md) is the canonical prompt; the files in [agents/](agents/) are per-platform variants of it (they differ only in argument placeholders and tool naming). When editing the canonical prompt, apply the same change to all four variants.

## License

[MIT](LICENSE)
