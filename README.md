# .github

Organization-wide GitHub defaults for [INENI-PT-GROUP-B](https://github.com/INENI-PT-GROUP-B).

Contents:

- `.github/ISSUE_TEMPLATE/task.yml` — shared issue form
  (see [`platform/CONTRIBUTING.md` § Creating Issues](https://github.com/INENI-PT-GROUP-B/platform/blob/main/CONTRIBUTING.md))
- `.github/PULL_REQUEST_TEMPLATE.md` — shared PR template
- `.github/workflows/commitlint-reusable.yml`,
  `.github/workflows/pr-title-reusable.yml` — reusable CI checks
  (imported by every repo)
- `.commitlintrc.json` — Conventional Commits configuration
- [`LABELS.md`](./LABELS.md) — canonical issue label set
- `scripts/bootstrap-labels.sh` — one-time idempotent label sync script
