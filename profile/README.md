# INENI-PT-GROUP-B

Multi-tenant SaaS platform engineering — coursework for the **Infrastructure
Engineering** module at Hochschule Burgenland, summer term 2026.

We build a Kubernetes platform that provisions isolated, on-demand SaaS
application instances. Each tenant gets a dedicated namespace with its own
application stack (frontend, backend, database), provisioned end-to-end via
GitOps and Crossplane — a single pull request onboards a new tenant, no manual
cluster operations.

## How it fits together

```text
platform-iac      →  Terraform provisions GKE + installs Argo CD (one bootstrap run)
                          ↓
platform-gitops   →  Argo CD reconciles platform components + Crossplane
                          ↓
tenants/          →  one PR adds a tenant claim → Crossplane provisions the tenant
```

- **Day 1 — Bootstrap:** GKE cluster, networking, Workload Identity and Argo CD,
  applied locally through one idempotent `bootstrap.sh` run (no click-ops).
- **Day 2 — Service Catalog:** Crossplane Compositions turn a tenant claim into a
  namespace, a CloudNativePG database, network policies, ingress with per-tenant
  BasicAuth, and the application Helm release.

## Repositories

| Repository | Purpose |
| ---------- | ------- |
| [platform](https://github.com/INENI-PT-GROUP-B/platform) | Documentation hub, conventions, architecture decisions — **start here** |
| [platform-iac](https://github.com/INENI-PT-GROUP-B/platform-iac) | Terraform for the GCP infrastructure (Day 1 bootstrap) |
| [platform-gitops](https://github.com/INENI-PT-GROUP-B/platform-gitops) | Argo CD applications, Crossplane XRDs/Compositions, Helm values, tenant claims |
| [app-backend](https://github.com/INENI-PT-GROUP-B/app-backend) | Application REST API plus the tenant Helm chart |
| app-frontend | Application single-page frontend (private per assignment) |
| [.github](https://github.com/INENI-PT-GROUP-B/.github) | Org-wide defaults: issue/PR templates, reusable CI, shared labels |

All repositories are public except `app-frontend`, which is private per the
assignment requirement.

## Tech stack

GKE · Terraform · Argo CD · Crossplane · CloudNativePG · External Secrets
Operator · ExternalDNS · cert-manager · Traefik · Prometheus + Grafana.

## Working here

New to the project? Read
[`platform/README.md`](https://github.com/INENI-PT-GROUP-B/platform) for the
overview and
[`platform/CONTRIBUTING.md`](https://github.com/INENI-PT-GROUP-B/platform/blob/main/CONTRIBUTING.md)
for the contribution rules: branch off `main`, Conventional Commits, squash
merge, one approving review, and every PR references an issue. All artefacts are
in English; AI usage is disclosed in `platform/AI_USAGE.md`.

## Team

A four-person student team building and operating the platform together:

- Marco — [@marco93r](https://github.com/marco93r)
- Alex — [@mlexinho27](https://github.com/mlexinho27)
- Ronny — [@ronaldley](https://github.com/ronaldley)
- Patrick — [@prohaskap](https://github.com/prohaskap)
