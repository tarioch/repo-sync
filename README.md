# repo-sync

Keeps the settings, rulesets and a few shared files of my repositories in sync. The repositories are listed in
[`repos.yml`](repos.yml), the configuration is in [`config/`](config/), see [CONTRIBUTING.md](CONTRIBUTING.md).

Uses [bulk-github-repo-settings-sync-action](https://github.com/joshjohanning/bulk-github-repo-settings-sync-action).

| What | Where | How |
|---|---|---|
| merge settings, secret scanning, Dependabot alerts and security updates | [`repos.yml`](repos.yml) | the action |
| branch ruleset `main` and tag ruleset `Release tags` | `config/rulesets/` | the action |
| `pr-labeler.yml`, `release-drafter.yml`, `dependabot-automerge.yml`, `dependabot.yml` | `config/workflows/`, `config/dependabot/` | the action, as pull requests in the repositories |
| no wiki and projects, read-only workflow token, SHA pinning required | [`scripts/extra-settings.sh`](scripts/extra-settings.sh) | `gh api`, the action cannot do these |

A pull request here only reports what would change (dry run), merging it applies the change. A weekly run puts back
what was changed by hand.

Not synced: `.github/pr-labeler.yml` (the label rules, identical in the repositories for now), and the build and
publish workflows, which differ per project.
