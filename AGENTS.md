# AGENTS.md

## Purpose

This repository is a dedicated Homebrew tap for `MyOSS` command-line tools.

Keep work in this repository focused on Homebrew packaging, formula maintenance, release updates, and tap automation.

Do not use this repository for implementing application features from upstream projects such as `cli-bot` itself.

## Current Scope

Current formulae:

- `Formula/cli-bot.rb`
- `Formula/gmail-tool.rb`
- `Formula/joedocs.rb`
- `Formula/passalong.rb`

Intended future install patterns:

- `brew install joelee/oss/cli-bot`
- `brew install joelee/oss/joedocs`
- `brew install joelee/oss/passalong`
- `brew install joelee/oss/camwatch`

The repository name is intended to map to the GitHub repository `joelee/homebrew-oss`.

## Current State

- The tap has been scaffolded locally.
- A `cli-bot` formula exists and installs from the published crates.io package.
- The formula currently targets `cli-bot` version `0.1.1`.
- The formula checksum currently matches the crates.io release metadata.
- A macOS GitHub Actions workflow exists at `.github/workflows/test-formula.yml`.
- The workflow is intended to run `brew install`, `brew test`, and `brew audit` for `joelee/oss/cli-bot`.

## Important Constraints

- This repository should stay packaging-focused.
- Upstream application changes belong in the upstream repositories, not here.
- Formula tests should avoid requiring live network access or a running Ollama instance.
- Prefer small, direct formula updates over broad tap refactors.
- Keep install instructions and caveats aligned with upstream defaults, especially the default Ollama model.

## Formula Notes

`Formula/cli-bot.rb` currently:

- installs from `https://static.crates.io/crates/cli-bot/cli-bot-0.1.1.crate`
- uses the checksum of the published crates.io artifact, not the local `target/package` archive
- builds with `cargo install`
- depends on `rust` at build time
- includes `caveats` about Ollama and the default `lfm2:latest` model

`Formula/joedocs.rb`:

- installs from `https://static.crates.io/crates/joedocs/joedocs-<version>.crate`, starting at 0.1.0
- uses the checksum of the published crates.io artifact
- builds with `cargo install`, depending on `rust` at build time (the crate needs Rust 1.99 or later)
- needs `git` at run time and uses the system one, so it declares no `git` dependency
- has a `service` block, so `brew services start joedocs` runs `joedocs serve` at login, logging to `var/log/joedocs.log`
- includes `caveats` pointing to `storage.home` in `~/.config/joedocs/config.toml`, `joedocs init`, `project add`, `key create`, and `brew services`
- its test creates a store, a project and a key in the test folder through `JOEDOCS__STORAGE__*` overrides, runs `joedocs check`, and checks `GET /health` of `joedocs serve` on a free local port, so it needs no network
- is updated by hand: set `url` and `sha256` from crates.io

`Formula/passalong.rb`:

- installs from `https://static.crates.io/crates/passalong/passalong-<version>.crate`, starting at 0.1.5
- uses the checksum of the published crates.io artifact
- builds with `cargo install`, depending on `rust` at build time (the crate needs Rust 1.98 or later)
- includes `caveats` pointing to `passalong init`, `passalong check`, and `passalong service-install`
- its test stores and prints text through a local store in the test folder, so it needs no SSH server or network
- is updated by `scripts/update-homebrew-formula.sh vX.Y.Z [TAP_DIR]` in the upstream repository, which sets `url` and `sha256` from crates.io

## Recommended Release Update Flow

When `cli-bot` publishes a new crates.io version:

1. Update `Formula/cli-bot.rb`
2. Change the crate version in `url`
3. Update the `sha256`
4. Run local Homebrew validation on macOS:
   `brew install --build-from-source joelee/oss/cli-bot`
   `brew test joelee/oss/cli-bot`
   `brew audit --strict joelee/oss/cli-bot`
5. Commit and push the tap update

When `joedocs` publishes a new crates.io version, update `url` and `sha256`
in `Formula/joedocs.rb` as for `cli-bot`, then validate with `joedocs`.

When `passalong` publishes a new crates.io version, run
`scripts/update-homebrew-formula.sh vX.Y.Z` from the `passalong`
repository, validate as above with `passalong` in place of `cli-bot`, then
commit and push.

## Known Gaps

- The tap has been prepared locally but may not yet be pushed to GitHub.
- Homebrew validation was not run locally in the original scaffolding session because that environment was Linux, not macOS.
- Additional formulae such as `camwatch` have not yet been added.

## Suggested Next Steps

1. Push this repository to `https://github.com/joelee/homebrew-oss`
2. Let the macOS GitHub Actions workflow validate the tap
3. Test `brew install joelee/oss/cli-bot` on a real macOS machine
4. Add more formulae under `Formula/` as needed
5. Optionally automate formula version bumps from upstream releases

## Verification

Useful commands for a Homebrew-focused session on macOS. Homebrew 7 and
later refuse formulae from untrusted taps, and a tap cloned from a local
folder cannot be trusted by name, so set `HOMEBREW_NO_REQUIRE_TAP_TRUST=1`
for it, as the workflow does. For the tap from GitHub, run
`brew trust joelee/oss` instead.

```bash
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
brew tap joelee/oss /path/to/homebrew-oss
brew install --build-from-source joelee/oss/cli-bot
brew test joelee/oss/cli-bot
brew audit --strict joelee/oss/cli-bot
```
