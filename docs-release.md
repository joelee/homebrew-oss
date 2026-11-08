# Release Update Guide

Formula updates are automated. When an upstream project publishes a release,
the [Bump Formula](.github/workflows/bump-formula.yml) workflow opens a
pull request that points the formula at it and turns on auto-merge. The
[Test Formula](.github/workflows/test-formula.yml) workflow builds, tests and
audits every formula on macOS, and the pull request merges once that passes.

```
upstream tag vX.Y.Z ─▶ publish to crates.io / PyPI ─▶ repository_dispatch ─┐
daily schedule ─────────────────────────────────────────────────────────────┼─▶ Bump Formula ─▶ PR ─▶ Test Formula ─▶ auto-merge
"Run workflow" button ──────────────────────────────────────────────────────┘
```

## How a bump works

`scripts/bump-formula.sh FORMULA [VERSION]` does the edit, here and in the
workflow. Without a version it uses the latest release on the registry.

| Formula | Source | What the script changes |
| --- | --- | --- |
| `cli-bot` | crates.io | `url` and `sha256` |
| `joedocs` | crates.io | `url` and `sha256` |
| `passalong` | crates.io | `url` and `sha256` |
| `gmail-tool` | PyPI | the whole formula, Python resources included, from `scripts/update-homebrew-formula.sh` on gmail-tool's default branch and `uv.lock` at the release tag |

The script waits up to 10 minutes (`BUMP_WAIT_SECONDS`) for a release to
appear on its registry, does nothing when the formula is already at that
version, and refuses to go back to an older version or to a yanked crate.

The workflow names the branch `bump/<formula>-<version>` and the commit and
pull request `<formula> <version>`. It skips a version whose branch already
exists, and closes open bump pull requests for older versions of the same
formula.

## When a bump fails

A failing Test Formula check stops auto-merge and leaves the pull request
open. Push a fix to its branch, and it merges once the checks pass. To start
over, close the pull request, delete its branch, and run the workflow again.

## Bump by hand

From the Actions tab, run **Bump Formula** with a formula, and optionally a
version. Or from a terminal:

```bash
gh workflow run bump-formula.yml -R joelee/homebrew-oss -f formula=joedocs -f version=0.1.2
```

Or edit locally and open the pull request yourself:

```bash
scripts/bump-formula.sh passalong 0.3.0
```

## One-time setup

### 1. Create the GitHub App

1. Go to **Settings → Developer settings → GitHub Apps → New GitHub App**.
2. Name it, for example `joelee-tap-bot`. Set any homepage URL, and turn off
   **Webhook**.
3. Under **Repository permissions**, set **Contents** and **Pull requests**
   to **Read and write**. Metadata stays **Read-only**.
4. Choose **Only on this account**, and create it.
5. Note the **Client ID**, and generate and download a **private key**.
6. Under **Install App**, install it on `joelee/homebrew-oss` only.

### 2. Configure this repository

1. **Settings → Secrets and variables → Actions**:
   - variable `TAP_BOT_CLIENT_ID`: the App's Client ID
   - secret `TAP_BOT_PRIVATE_KEY`: the contents of the private key file
2. **Settings → General → Pull Requests**: turn on **Allow auto-merge** and
   **Automatically delete head branches**.
3. **Settings → Rules → Rulesets → New branch ruleset** for the default
   branch: turn on **Require status checks to pass** and add
   **All formulae pass**. That check passes only when every formula in the
   Test Formula matrix passes. Without a required check, auto-merge has
   nothing to wait for.

### 3. Notify the tap from upstream releases

Add this job to the release workflow of each upstream repository, after the
job that publishes to the registry. Give each repository the same
`TAP_BOT_CLIENT_ID` variable and `TAP_BOT_PRIVATE_KEY` secret. The App needs no
installation on the upstream repository, because the token is for
`homebrew-oss`.

| Repository | Workflow | `needs:` | `FORMULA` |
| --- | --- | --- | --- |
| `joelee/cli-bot` | `release.yml` | `crates` | `cli-bot` |
| `joelee/passalong` | `release.yml` | `crates` | `passalong` |
| `joelee/gmail-tool` | `publish.yml` | `publish` | `gmail-tool` |
| `joelee/joedocs-mcp` | `release.yml` | (a step in `publish`) | `joedocs` |

```yaml
  homebrew:
    name: Ask the Homebrew tap to bump the formula
    needs: crates # the job that publishes to crates.io or PyPI
    runs-on: ubuntu-24.04
    permissions: {}
    steps:
      - name: Get a token for joelee/homebrew-oss
        id: app
        uses: actions/create-github-app-token@64ab729a6294000f5aa4a4bc0b73d1f32bc45510 # v3.3.0
        with:
          client-id: ${{ vars.TAP_BOT_CLIENT_ID }}
          private-key: ${{ secrets.TAP_BOT_PRIVATE_KEY }}
          owner: joelee
          repositories: homebrew-oss
      - name: Send formula-release to the tap
        env:
          GH_TOKEN: ${{ steps.app.outputs.token }}
          FORMULA: cli-bot # the formula name in the tap
        run: |
          gh api repos/joelee/homebrew-oss/dispatches \
            -f event_type=formula-release \
            -f "client_payload[formula]=$FORMULA" \
            -f "client_payload[version]=${GITHUB_REF_NAME#v}"
```

`joelee/joedocs-mcp` has no release workflow. Its releases are picked up by
the daily check, or right away with the `gh workflow run` command above.

The upstream `scripts/update-homebrew-formula.sh` scripts in `passalong` and
`gmail-tool` still work for local use, and the bump script uses gmail-tool's
script to generate its formula.

## Get a checksum by hand

```bash
curl -s https://crates.io/api/v1/crates/cli-bot/0.4.1 | jq -r '.version.checksum'
curl -L https://static.crates.io/crates/cli-bot/cli-bot-0.4.1.crate | shasum -a 256
```

Use the checksum of the published crates.io download, not the checksum of a
local `target/package/*.crate` file.

## Local validation

With Homebrew 7 or later, run `brew trust joelee/oss` once first. For a tap
cloned from a local folder, run it after `brew tap joelee/oss <folder>`, as
the workflow does, so that it records the folder.

```bash
for formula in cli-bot gmail-tool joedocs passalong; do
  brew install --build-from-source "joelee/oss/$formula"
  brew test "joelee/oss/$formula"
  brew audit --strict "joelee/oss/$formula"
done
```
