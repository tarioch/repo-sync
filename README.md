# repo-sync

Keeps the settings, rulesets and a few shared files of my repositories in sync. The repositories are listed in
[`repos.yml`](repos.yml), the configuration is in [`config/`](config/), see [CONTRIBUTING.md](CONTRIBUTING.md).

Uses [bulk-github-repo-settings-sync-action](https://github.com/joshjohanning/bulk-github-repo-settings-sync-action).

| What | Where | How |
|---|---|---|
| merge settings, no wiki and no projects, immutable releases, secret scanning, code scanning, Dependabot alerts and security updates, read-only workflow token, SHA pinning required | [`repos.yml`](repos.yml) | the action |
| branch ruleset `main` and tag ruleset `Release tags` | `config/rulesets/` | the action |
| `pr-labeler.yml`, `release-drafter.yml`, `dependabot-automerge.yml`, `dependabot.yml` | `config/workflows/`, `config/dependabot/` | the action, as pull requests in the repositories |
| `.github/pr-labeler.yml`, `.gitattributes`, `SECURITY.md`, private vulnerability reporting | `config/files/`, [`repos.yml`](repos.yml) | the action (`file-sync`), as pull requests in the repositories |
| `build-publish.yml` (PyPI repositories only) | `config/workflows/` | the action |
| deployment environments `testpypi` and `pypi` (PyPI repositories only) | `config/environments/` | the action |

A pull request here only reports what would change (dry run), merging it applies the change. A weekly run puts back
what was changed by hand.

Not synced: the `ci.yml` and `dockerimage.yml` workflows and `.pre-commit-config.yaml`, which differ per project.
