# .github

Organization-wide GitHub defaults for [INENI-PT-GROUP-B](https://github.com/INENI-PT-GROUP-B).

Contents:

- `.github/ISSUE_TEMPLATE/task.yml` — shared issue form
  (see [`platform/CONTRIBUTING.md` § Creating Issues](https://github.com/INENI-PT-GROUP-B/platform/blob/main/CONTRIBUTING.md))
- `.github/PULL_REQUEST_TEMPLATE.md` — shared PR template
- `.github/workflows/commitlint-reusable.yml`,
  `.github/workflows/pr-title-reusable.yml`,
  `.github/workflows/lint-reusable.yml` — reusable CI checks
  (imported by every repo)
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
