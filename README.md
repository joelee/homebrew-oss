# homebrew-oss

Homebrew tap for installing `cli-bot` and other `MyOSS` tools on macOS.

`cli-bot` is a Rust CLI that translates natural-language requests into shell commands using Ollama.

## Install

```bash
brew install joelee/oss/cli-bot
```

Homebrew will automatically tap this repository on first install.

You can also tap it explicitly:

```bash
brew tap joelee/oss
brew install cli-bot
```

## Requirements

- macOS with Homebrew installed
- Ollama installed and running locally
- the desired model pulled into Ollama

Example:

```bash
ollama pull lfm2:latest
```

## Verify

```bash
cli-bot --check
```

## Updating The Formula

When a new `cli-bot` version is released:

1. Update `Formula/cli-bot.rb`
2. Change the `url` to the new crate version
3. Change the `sha256` to the new crates.io checksum
4. Commit and push the tap update

Additional packages can be added alongside `cli-bot` under `Formula/`.

For the upstream project and docs, see:

- `https://github.com/joelee/cli-bot`
