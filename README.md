# streamshub-console-helm-community

Community Helm charts for [StreamsHub Console](https://github.com/streamshub/console).
Not an official StreamsHub project.

## Charts

- [`console-operator`](charts/console-operator/README.md) — installs the
  Console operator (CRDs, RBAC, Deployment).

## How it works

[`hack/sync-from-release.sh`](hack/sync-from-release.sh) mechanically
regenerates each chart's `crds/` and `templates/` from the "non-OLM install"
manifest that `streamshub/console` attaches to every GitHub release. A
scheduled workflow ([`sync-chart.yml`](.github/workflows/sync-chart.yml))
runs it automatically (every 6 hours, or on-demand via `workflow_dispatch`)
and commits any update to `main`. A second workflow
([`release-chart.yml`](.github/workflows/release-chart.yml)) then packages
and publishes the chart via [chart-releaser](https://github.com/helm/chart-releaser-action)
to this repo's `gh-pages` branch, served as a classic Helm repository.

This keeps the chart a low-drift mirror of what upstream itself ships for a
given release, rather than a hand-maintained copy that silently falls out of
sync. See each chart's README for exactly which values are templated (image,
namespace, watched namespaces, etc.) versus left untouched.

## Installing

```console
helm repo add streamshub-console-community https://jankalinic.github.io/streamshub-console-helm-community/
helm repo update
helm install console-operator streamshub-console-community/console-operator \
  --namespace console-operator --create-namespace
```

## Repo setup (one-time)

1. Settings → Actions → General → Workflow permissions → "Read and write
   permissions" (required for both workflows to push commits/releases).
2. After the first successful run of `release-chart.yml`, Settings → Pages →
   Source → Deploy from branch → `gh-pages` / `/ (root)`.
3. Optional: register this repo on [Artifact Hub](https://artifacthub.io) for
   discoverability (needs `artifacthub-repo.yml`'s `repositoryID`, issued by
   Artifact Hub when you add the repo there).
