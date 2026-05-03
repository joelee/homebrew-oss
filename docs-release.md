# Release Update Guide

## Update The Homebrew Formula

### cli-bot

When `cli-bot` publishes a new version to crates.io:

1. Open `Formula/cli-bot.rb`
2. Update the crate version in `url`
3. Update `sha256` to the new crates.io checksum
4. Commit and push

### gmail-tool

When `gmail-tool` publishes a new version to PyPI:

1. In the upstream `gmail-tool` repository, run:

```bash
scripts/update-homebrew-formula.sh vX.Y.Z
```

2. Review `Formula/gmail-tool.rb`
3. Commit and push

## Get The New Checksum

You can fetch crate metadata from crates.io:

```bash
curl -s https://crates.io/api/v1/crates/cli-bot | jq -r '.versions[0].checksum'
```

Or compute it directly from the downloaded crate:

```bash
curl -L https://static.crates.io/crates/cli-bot/cli-bot-0.2.1.crate | shasum -a 256
```

Use the checksum of the published crates.io download, not the checksum of a local `target/package/*.crate` file.

## Local Validation

```bash
brew install --build-from-source joelee/oss/cli-bot
brew test joelee/oss/cli-bot
brew audit --strict joelee/oss/cli-bot

brew install --build-from-source joelee/oss/gmail-tool
brew test joelee/oss/gmail-tool
brew audit --strict joelee/oss/gmail-tool
```
