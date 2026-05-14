# Issue Labels — INENI-PT-GROUP-B

Canonical set of issue and PR labels applied to **all six organization
repositories**.

## Canonical labels

| Name           | Color     | Description                                                       |
|----------------|-----------|-------------------------------------------------------------------|
| `task`         | `#D4C5F9` | Standard task (used by `.github/ISSUE_TEMPLATE/task.yml`)         |
| `pillar-1`     | `#0E8A16` | Documentation & Software Management Hygiene (15%)                 |
| `pillar-2`     | `#1D76DB` | Infrastructure Bootstrap (35%)                                    |
| `pillar-3`     | `#6F42C1` | Application Management (35%)                                      |
| `pillar-4`     | `#FBCA04` | Presentation (15%)                                                |
| `pillar-bonus` | `#C5DEF5` | Bonus tasks (Prometheus / Grafana monitoring)                     |

GitHub's default labels (`bug`, `documentation`, `enhancement`,
`duplicate`, `good first issue`, `help wanted`, `invalid`, `question`,
`wontfix`) are kept as-is in every repo and are not managed by this
scheme.

## Applying the canonical set

The set is enforced by `scripts/bootstrap-labels.sh` in this repo. The
script is idempotent — run it any time after editing the set:

```bash
gh auth status   # confirm you are logged in to gh CLI with write
                 # access to all six org repos
bash scripts/bootstrap-labels.sh
```

The script:

- creates the canonical labels in repos where they do not exist
- updates color and description in repos where they already exist
- renames a pre-existing `type-task` label to `task` (preserves all
  existing issue markings)

It deliberately does **not** delete any other labels.

## Deprecated labels

The following labels exist on some repos but are **no longer part of the
canonical set**. Do not apply them to new issues. They are kept to
preserve historical issue markings:

| Label                                            | Repos                                              | Note                                              |
|--------------------------------------------------|----------------------------------------------------|---------------------------------------------------|
| `type-task`                                      | migrated to `task` by the bootstrap script         | use `task`                                        |
| `priority-high`, `priority-med`                  | `platform-iac`, `app-backend`, `app-frontend`      | priority is no longer tracked via labels          |
| `sprint-1`                                       | `platform-iac`, `app-backend`, `app-frontend`      | sprints are no longer tracked via labels          |
| `repo-iac`, `repo-app-backend`, `repo-app-frontend` | respective repos                                | redundant — an issue's repo is implicit           |

## Changing the canonical set

1. Edit the `LABELS` array in `scripts/bootstrap-labels.sh` and update
   the table above accordingly.
2. Open a PR; after merge, run the script to roll out the change.
3. Document any rename or deprecation in this file.
