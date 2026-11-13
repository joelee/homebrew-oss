<div align="center">

# 🍺 joelee/oss

**A Homebrew tap of small, sharp command-line tools: local AI shell help, Gmail automation, an MCP docs server, and clipboard sharing over SSH.**

[![Test Formula](https://github.com/joelee/homebrew-oss/actions/workflows/test-formula.yml/badge.svg)](https://github.com/joelee/homebrew-oss/actions/workflows/test-formula.yml)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey?logo=apple)
![Homebrew](https://img.shields.io/badge/homebrew-tap-FBB040?logo=homebrew&logoColor=white)

```bash
brew trust joelee/oss && brew tap joelee/oss
```

</div>

---

## A note from me

This repository brings together the Homebrew packages for my open-source projects, making them a little easier to install and keep up to date. I hope you find something useful here. Feedback, suggestions and contributions are always welcome.

— Joe

## 📦 Packages

| Package | What it does | Latest release | Install |
| --- | --- | --- | --- |
| [**cli-bot**](https://github.com/joelee/cli-bot) | Turn plain-English requests into shell commands, using a local Ollama model | [![crates.io](https://img.shields.io/crates/v/cli-bot?label=crates.io&color=orange)](https://crates.io/crates/cli-bot) | `brew install joelee/oss/cli-bot` |
| [**gmail-tool**](https://github.com/joelee/gmail-tool) | Manage Gmail labels, run searches, and back up mail from the terminal | [![PyPI](https://img.shields.io/pypi/v/gmail-tool?label=PyPI&color=blue)](https://pypi.org/project/gmail-tool/) | `brew install joelee/oss/gmail-tool` |
| [**joedocs**](https://github.com/joelee/joedocs-mcp) | MCP server for multi-project docs, stored as Markdown with git history and full-text search | [![crates.io](https://img.shields.io/crates/v/joedocs?label=crates.io&color=orange)](https://crates.io/crates/joedocs) | `brew install joelee/oss/joedocs` |
| [**passalong**](https://github.com/joelee/passalong) | Share the clipboard and files between machines through a folder on an SSH server | [![crates.io](https://img.shields.io/crates/v/passalong?label=crates.io&color=orange)](https://crates.io/crates/passalong) | `brew install joelee/oss/passalong` |

## 🚀 Quick start

Homebrew 7 and later load formulae only from taps you trust, so trust and tap this one first:

```bash
brew trust joelee/oss
brew tap joelee/oss
```

Then install whichever tools you want, by full name or, once tapped, by short name:

```bash
brew install cli-bot gmail-tool joedocs passalong
```

> [!TIP]
> On older Homebrew versions, `brew install joelee/oss/<name>` taps this repository automatically, so you can skip `brew tap`.

Upgrade everything from this tap with the rest of your Homebrew packages:

```bash
brew update && brew upgrade
```

## 🛠️ Getting started with each tool

<details>
<summary><b>cli-bot</b>: natural language to shell commands</summary>

Needs [Ollama](https://ollama.com) installed and running locally, with a model pulled:

```bash
brew install ollama
brew services start ollama
ollama pull lfm2:latest   # the default model

cli-bot --check           # verify the setup
```

</details>

<details>
<summary><b>gmail-tool</b>: Gmail from the command line</summary>

Gmail credentials are needed only when you run it against your account, not to install it.

```bash
gmail-tool --version
gmail-tool search --list-actions
```

</details>

<details>
<summary><b>joedocs</b>: an MCP documentation server</summary>

Needs `git` at run time (the Xcode Command Line Tools provide it).

```bash
joedocs init                  # create the store
joedocs check                 # verify the setup
brew services start joedocs   # serve http://127.0.0.1:8750/mcp at login
```

</details>

<details>
<summary><b>passalong</b>: clipboard and file sharing over SSH</summary>

Needs an SSH server you can log in to with a key.

```bash
passalong init              # create the configuration, pin the host key
passalong check             # verify the connection and store
passalong service-install   # keep it running in the background at login
```

</details>

## 🔧 Maintainers

New upstream releases are picked up automatically: the
[Bump Formula](.github/workflows/bump-formula.yml) workflow opens a pull request
for each one, and it merges once the
[Test Formula](.github/workflows/test-formula.yml) workflow has built, tested,
and audited every formula on macOS. See [`docs-release.md`](docs-release.md)
for how it works, the one-time setup, and manual bumps.

Bugs and feature requests for a tool belong in its upstream repository, linked
in the table above. Packaging problems belong [here](https://github.com/joelee/homebrew-oss/issues).
