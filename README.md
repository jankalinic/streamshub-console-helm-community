# StreamsHub Console Helm Charts (Community)

Community-maintained Helm charts for [StreamsHub Console](https://github.com/streamshub/console).
Not an official StreamsHub project.

## Charts

| Chart | Description |
|---|---|
| [`console-operator`](charts/console-operator) | Installs the Console operator: CRDs, RBAC, and Deployment |

## Usage

```console
helm repo add streamshub-console-community https://jankalinic.github.io/streamshub-console-helm-community/
helm repo update
helm install console-operator streamshub-console-community/console-operator \
  --namespace console-operator --create-namespace
```

See the [`console-operator` chart's README](charts/console-operator/README.md)
for available values and what is (and isn't) configurable.

## How charts stay up to date

Charts here are regenerated automatically from each upstream
`streamshub/console` release, not hand-maintained — see
[`hack/sync-from-release.sh`](hack/sync-from-release.sh) and the
[`sync-chart`](.github/workflows/sync-chart.yml) /
[`release-chart`](.github/workflows/release-chart.yml) workflows for how.
