#!/usr/bin/env bash
# Settings that bulk-github-repo-settings-sync-action does not cover, for every repository in repos.yml:
# no wiki and no projects, a read-only default token for workflows that cannot approve pull requests,
# and actions have to be pinned to a commit SHA.
# Needs GH_TOKEN (the sync token) and yq. DRY_RUN=true only prints what would be done.
set -euo pipefail

DRY_RUN=${DRY_RUN:-false}

run() {
  if [ "$DRY_RUN" = true ]; then
    echo "   [dry run] $*"
  else
    "$@"
  fi
}

for repo in $(yq '.repos[].repo' repos.yml); do
  echo "== $repo"
  run gh api -X PATCH "repos/$repo" -F has_wiki=false -F has_projects=false --silent
  run gh api -X PUT "repos/$repo/actions/permissions/workflow" \
    -f default_workflow_permissions=read -F can_approve_pull_request_reviews=false --silent
  run gh api -X PUT "repos/$repo/actions/permissions" \
    -F enabled=true -f allowed_actions=all -F sha_pinning_required=true --silent
done
