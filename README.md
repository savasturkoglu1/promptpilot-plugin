# PromptPilot

Turn rough, vague prompts into precise, context-enriched prompts — inside your AI coding agent session.

```
/prompt-pilot "buggy login thing fix it"
```

→ The agent explores your codebase **read-only**, then returns an optimized prompt with real `@file/paths` and concrete symbols woven in. It never implements the task itself — you review the enriched prompt and reply `run` to execute it.

Ships as a [Claude Code plugin](#claude-code-plugin) and as native custom commands for [Codex CLI, OpenCode, Gemini CLI, and Cursor](#other-agents-codex-opencode-gemini-cli-cursor). No server, no binary, no MCP — the command is pure instructions.

## The Problem

AI coding agents are only as good as the prompts they receive — and most real-world prompts look like `"buggy login thing fix it"`. When an agent gets a prompt like that, three things go wrong:

1. **It guesses.** Without concrete file paths or symbol names, the agent explores blindly, often lands on the wrong files, and confidently implements the wrong fix.
2. **Context is wasted.** Searching and implementing happen in one long session — a large share of the context window is burned on exploration before any real work starts, degrading the quality of the actual change.
3. **There is no checkpoint.** The agent jumps straight from vague words to code changes; you never get to confirm *what* it is about to do before it does it.

The obvious cure — writing a precise prompt yourself — requires already knowing which files, functions, and constraints are involved. That is exactly the knowledge you were hoping the agent would dig up for you.

## How PromptPilot Solves It

PromptPilot separates **understanding** from **acting**:

1. **Explore, read-only.** The agent (delegating to a subagent where the platform supports it, keeping the main context clean) investigates the codebase with read-only tools — no edits, no commands.
2. **Rewrite.** Your rough prompt is restructured into WHAT / WHERE / HOW / CONSTRAINTS / VALIDATION, with real `@file/paths` and concrete symbols woven in.
3. **Approve, then run.** The optimized prompt is shown to you first. Nothing executes until you reply `run` — or you refine it with follow-up notes and it is re-optimized.

The implementation run then starts from precise, verified context instead of guesses: fewer wrong turns, fewer wasted tokens, and a human checkpoint on intent before any code changes.

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

## Contributing

[plugin/commands/prompt-pilot.md](plugin/commands/prompt-pilot.md) is the canonical prompt; the files in [agents/](agents/) are per-platform variants of it (they differ only in argument placeholders and tool naming). When editing the canonical prompt, apply the same change to all four variants.

## License

[MIT](LICENSE)
