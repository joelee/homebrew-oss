# homebrew-oss

Homebrew tap for installing `cli-bot`, `gmail-tool`, and other `MyOSS` tools on macOS.

- `cli-bot` is a Rust CLI that translates natural-language requests into shell commands using Ollama.
- `gmail-tool` is a Python CLI for Gmail labels, searches, and backup workflows.

## Install

```bash
brew install joelee/oss/cli-bot
brew install joelee/oss/gmail-tool
```

Homebrew will automatically tap this repository on first install.

You can also tap it explicitly:

```bash
brew tap joelee/oss
brew install cli-bot
brew install gmail-tool
```

## Requirements

- `cli-bot`
- macOS with Homebrew installed
- Ollama installed and running locally
- the desired model pulled into Ollama

- `gmail-tool`
- macOS with Homebrew installed
- Gmail credentials are only needed when you run the CLI against your account, not for installation

Example:

```bash
ollama pull lfm2:latest
```

## Verify

```bash
cli-bot --check
gmail-tool --version
gmail-tool search --list-actions
```

## Updating The Formula

When a new `cli-bot` version is released:

1. Update `Formula/cli-bot.rb`
2. Change the `url` to the new crate version
3. Change the `sha256` to the new crates.io checksum
4. Commit and push the tap update

When a new `gmail-tool` version is released:

1. Run `scripts/update-homebrew-formula.sh vX.Y.Z` from the upstream `gmail-tool` repository
2. Review `Formula/gmail-tool.rb`
3. Commit and push the tap update

Additional packages can be added alongside `cli-bot` and `gmail-tool` under `Formula/`.

For the upstream project and docs, see:

- `https://github.com/joelee/cli-bot`
- `https://github.com/joelee/gmail-tool`
