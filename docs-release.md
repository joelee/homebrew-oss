# Release Update Guide

## Update The Homebrew Formula

When `cli-bot` publishes a new version to crates.io:

1. Open `Formula/cli-bot.rb`
2. Update the crate version in `url`
3. Update `sha256` to the new crates.io checksum
4. Commit and push

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
```
