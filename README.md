# .github

Organization-wide GitHub defaults for [INENI-PT-GROUP-B](https://github.com/INENI-PT-GROUP-B).

Contents:

- `.github/ISSUE_TEMPLATE/task.yml` — shared issue form
  (see [`platform/CONTRIBUTING.md` § Creating Issues](https://github.com/INENI-PT-GROUP-B/platform/blob/main/CONTRIBUTING.md))
- `.github/PULL_REQUEST_TEMPLATE.md` — shared PR template
- `.github/workflows/` — reusable CI checks imported by every repo:
  - `commitlint-reusable.yml` — checks every commit message in the PR
    against Conventional Commits
  - `pr-title-reusable.yml` — checks the PR title against Conventional
    Commits
  - `lint-reusable.yml` — runs `yamllint` + `markdownlint-cli2` on the
    caller's repo (details below)
  - `root-app-spec-identity-reusable.yml` — verifies that the two
    manifests defining the Argo CD root App-of-Apps
    (`platform-iac/bootstrap/argocd-bootstrap.yaml` and
    `platform-gitops/applications/root.yaml`) have identical `.spec`
    blocks
- `.commitlintrc.json` — Conventional Commits configuration
- [`LABELS.md`](./LABELS.md) — canonical issue label set
- `scripts/bootstrap-labels.sh` — one-time idempotent label sync script

## Reusable lint workflow

`lint-reusable.yml` runs `yamllint` and `markdownlint-cli2` on pull requests.
The tool versions are pinned in the workflow per
[`platform/CONTRIBUTING.md` § Tool Versions in CI](https://github.com/INENI-PT-GROUP-B/platform/blob/main/CONTRIBUTING.md#tool-versions-in-ci),
so consuming repos do not pin them individually.

The workflow checks out the **calling** repository, so each consumer supplies
its own `.yamllint.yml` and `.markdownlint.jsonc` — the same mechanism by which
`commitlint-reusable.yml` reads the caller's `.commitlintrc.json`. A consumer
imports it with:

```yaml
jobs:
  lint:
    uses: INENI-PT-GROUP-B/.github/.github/workflows/lint-reusable.yml@main
```

## Sync labels across repos

`scripts/bootstrap-labels.sh` is idempotent — re-run it any time the
canonical set in [`LABELS.md`](./LABELS.md) changes:

```bash
./scripts/bootstrap-labels.sh
```

Requires `gh` authenticated against the org with `repo` + `admin:org`
scopes.
