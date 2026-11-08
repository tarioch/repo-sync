# CLAUDE.md

@CONTRIBUTING.md

## Notes for Claude

- Open pull requests and stop there, the maintainer reviews and merges them. Do not merge unless explicitly asked.
  Merging here changes the settings of every repository in `repos.yml`.
- Run the checks from CONTRIBUTING.md before pushing, and `git add` new files first.
- Read the dry run of the `Sync` job before saying a change is safe, and say in the pull request what only the
  real run can show.
- Never put credentials or personal details into the repository. The token is the secret `SYNC_TOKEN`.
- Keep pull request descriptions factual: the problem, the change, how it was verified (including what could not be
  verified before merging).
