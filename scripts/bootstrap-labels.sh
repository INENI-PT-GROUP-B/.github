#!/bin/bash
# Bootstrap canonical org-wide issue labels across all INENI-PT-GROUP-B repos.
# Idempotent: re-run any time to re-sync labels to the canonical state.
# Reference: LABELS.md in this repo.

set -euo pipefail

ORG="INENI-PT-GROUP-B"
REPOS=(platform platform-iac platform-gitops .github app-backend app-frontend)

# Canonical labels: name | color (hex without #) | description
LABELS=(
  "task|D4C5F9|Standard task (used by .github/ISSUE_TEMPLATE/task.yml)"
  "pillar-1|0E8A16|Documentation & Software Management Hygiene (15%)"
  "pillar-2|1D76DB|Infrastructure Bootstrap (35%)"
  "pillar-3|6F42C1|Application Management (35%)"
  "pillar-4|FBCA04|Presentation (15%)"
  "pillar-bonus|C5DEF5|Bonus tasks (Prometheus / Grafana monitoring)"
)

label_exists() {
  local repo="$1" name="$2"
  gh label list -R "$ORG/$repo" --limit 200 --json name -q '.[].name' \
    | grep -Fxq "$name"
}

ensure_label() {
  local repo="$1" name="$2" color="$3" desc="$4"

  # Special case for `task`: if a legacy `type-task` label exists and `task`
  # does not, rename it. This preserves any existing issue markings.
  if [[ "$name" == "task" ]] \
     && label_exists "$repo" "type-task" \
     && ! label_exists "$repo" "task"; then
    echo "  $repo: rename type-task -> task"
    gh label edit "type-task" -R "$ORG/$repo" \
      --name "$name" --color "$color" --description "$desc" >/dev/null
    return
  fi

  if label_exists "$repo" "$name"; then
    echo "  $repo: ensure $name (edit color/description)"
    gh label edit "$name" -R "$ORG/$repo" \
      --color "$color" --description "$desc" >/dev/null
  else
    echo "  $repo: create $name"
    gh label create "$name" -R "$ORG/$repo" \
      --color "$color" --description "$desc" >/dev/null
  fi
}

main() {
  echo "Bootstrap labels in $ORG ..."
  for repo in "${REPOS[@]}"; do
    echo "=> $repo"
    for entry in "${LABELS[@]}"; do
      IFS='|' read -r name color desc <<<"$entry"
      ensure_label "$repo" "$name" "$color" "$desc"
    done
  done
  echo "Done."
}

main "$@"
