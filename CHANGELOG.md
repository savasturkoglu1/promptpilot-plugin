# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the plugin version follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Fixed
- OpenCode: `/prompt-pilot` no longer prints the plugin's full instruction
  body into the conversation. OpenCode renders a custom command's body as the
  user message, so the instructions now live in the `prompt-pilot` skill
  (`~/.config/opencode/skill/prompt-pilot/SKILL.md`) and the command
  (`~/.config/opencode/command/prompt-pilot.md`) is a thin trigger that loads
  it via the skill tool. The skill content enters context as a collapsed tool
  result, so the approval loop, flags, and prompt history keep working.
  `scripts/install-agents.sh` installs both files, globally and with
  `--project`; README and landing page updated.

## [0.4.0] - 2026-08-11

### Added
- `-ask` flag: if the rough prompt leaves genuinely open decisions, the agent
  asks up to 3 clarifying questions before exploring and folds the answers
  into the rewritten prompt as explicit requirements.
- `-split` flag: a prompt that bundles several independent tasks is divided
  into self-contained, dependency-ordered optimized prompts — explored by one
  parallel subagent per task where the platform supports it. Reply `run` to
  execute all in order, or `run <n>` for a single one.
- `-issue` flag: the rewritten prompt is formatted as a ready-to-file GitHub
  issue (title, context, task, constraints, acceptance-criteria checklist).
  Reply `run` to execute locally or `publish` to create the issue on the
  remote via the `gh` CLI.
- Prompt history: every approved prompt is logged to
  `.promptpilot/history.md` in the working directory before execution;
  ask "show my prompt history" to list past entries.

## [0.3.1] - 2026-08-10

### Fixed
- Codex integration migrated from the deprecated `~/.codex/prompts` custom
  prompts (no longer loaded by codex-cli >= 0.117) to a Codex skill at
  `~/.agents/skills/prompt-pilot/SKILL.md`. The skill works in the Codex CLI,
  IDE extension, and desktop app; invoke it with `$prompt-pilot` or from the
  `/skills` menu. `scripts/install-agents.sh` now installs the skill (and
  supports `--project` for Codex via `.agents/skills/`); README and landing
  page updated accordingly.

## [0.3.0] - 2026-08-07

### Added
- `-plan` flag: appends a `PLAN GATE` section to the optimized prompt — the
  executing agent must present a file-by-file implementation plan and wait
  for approval before making any changes.
- `-safe` flag: appends a `SAFETY RAILS` section — minimal diff, no new
  dependencies, no destructive operations, reversible changes preferred,
  stop-and-ask on ambiguity.
- `-quick` flag: skips codebase exploration entirely and only fixes language
  and structure, for prompts that don't depend on the current codebase.
- Flags are combinable (e.g. `-quick -plan -turkce`); documented in both
  READMEs and on the landing page.

## [0.2.0] - 2026-08-06

### Changed
- Repository slimmed down to the plugin and agent commands only; the Tauri
  desktop app and the `pp` CLI prototype were removed from the distribution.
- Unified the closing line of the optimized-prompt output across the Claude
  Code plugin and all agent variants (previously the plugin copy hardcoded a
  Turkish string).
- `plugin.json` now declares `license` and `repository`.

### Added
- MIT `LICENSE` file.
- CI workflow validating the plugin manifest and command files on every push
  and pull request.

## [0.1.8] - earlier

- Last version of the plugin as part of the combined desktop app + CLI +
  plugin repository.
