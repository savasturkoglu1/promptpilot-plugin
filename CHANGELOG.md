# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the plugin version follows [Semantic Versioning](https://semver.org/).

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
