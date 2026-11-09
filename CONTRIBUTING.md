# Contributing

Settings and shared files of the repositories in [`repos.yml`](repos.yml) are defined here and applied by
`.github/workflows/sync.yml`.

## Layout

| Path | Content |
|---|---|
| `repos.yml` | what is synced, as rules: the first rule has the repositories and the defaults for all of them, the rules below only what differs |
| `config/rulesets/` | the rulesets, matched by their `name` (a renamed ruleset is created again, the old one stays) |
| `config/workflows/` | workflow files copied into `.github/workflows/` of the repositories |
| `config/dependabot/` | the variants of `.github/dependabot.yml` (`python` is the default) |
| `scripts/extra-settings.sh` | what the action cannot set |
| `.github/` | this repository's own workflows, `pr-labeler.yml` and `dependabot.yml` are copies of the synced ones |

## Setup and checks

```bash
uvx pre-commit run --all-files   # file hygiene, shellcheck, zizmor
```

CI runs the same (`Lint`) plus `jq` on the rulesets. `git add` new files first, `pre-commit run --all-files` skips
untracked files. The workflows need `ZIZMOR_OFFLINE=true` locally without a GitHub token.

## Changing something

- A pull request runs the sync as a dry run, read the job summary of `Sync` for what would change.
- Merging to `main` applies it: settings directly, files as pull requests in the repositories (labeled `chore` by the synced `pr-labeler.yml` from their `chore:` title, which `sync.yml` sets, the action's branch
  names have no prefix, merge them there).
  The synced `dependabot-automerge.yml` also enables auto-merge for them (branch ending in `-sync` or starting with
  `file-sync`, opened by the repository owner), so they merge themselves once `CI ok` and `Label check` pass.
- Required status checks in the ruleset (`CI ok`, `Label check`) must exist in every repository with a ruleset,
  otherwise nothing can be merged there.
- The files in `config/workflows/` and `config/dependabot/` start with a comment that names them as synced, keep it.
- A later rule in `repos.yml` replaces a setting as a whole, also a list like `workflow-files`, so it has to name every
  file the repository should get. Only `rulesets-file` adds up over the rules.
- A new repository: add it to the list of the first rule in `repos.yml`. `SYNC_TOKEN` covers all repositories.

## Secret

`SYNC_TOKEN` is a fine-grained personal access token (owner `tarioch`, all repositories) with Administration, Contents,
Pull requests and Workflows read/write and Metadata read. Pull requests from forks and Dependabot do not get it, the
sync job is skipped for them.

## Git and pull requests

- Branch off `main`, named `feature/…`, `bugfix/…` or `chore/…` (snake_case after the prefix), the prefix labels the PR.
- Commit subjects are imperative and start with a capital letter, the body explains why.
- Changes go through pull requests into `main` and are merged with a merge commit. `CI ok` is the check to require.
