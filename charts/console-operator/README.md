# console-operator

Community Helm chart for the [StreamsHub Console](https://github.com/streamshub/console)
Kubernetes operator. This is **not** an official StreamsHub project.

This chart installs the operator only — its CRDs, ServiceAccount, RBAC, and
Deployment. It does not create a `Console` custom resource for you; the
operator's own RBAC/Deployment are rich enough to install declaratively, but
a `Console` instance has enough surface area (security, metrics sources,
Kafka cluster references) that it's left for you to author directly. See the
[upstream project's docs](https://github.com/streamshub/console) for
`Console` CR examples.

## How this chart is maintained

Every document in `crds/` and `templates/` (except `_helpers.tpl` and
`NOTES.txt`) is mechanically generated from the "non-OLM install" manifest
that `streamshub/console` itself attaches to every GitHub release
(`streamshub-console-operator.yaml`), via `hack/sync-from-release.sh` in the
root of this repo, run automatically on a schedule. Only the values below are
templated; everything else — RBAC rules, probes, resource shape — is exactly
what upstream ships for that release. Do not hand-edit the generated files;
they'll be overwritten on the next sync.

## Installing

```console
helm repo add streamshub-console-community https://jankalinic.github.io/streamshub-console-helm-community/
helm install console-operator streamshub-console-community/console-operator \
  --namespace console-operator --create-namespace
```

## Values

| Key | Default | Description |
|-----|---------|-------------|
| `image.registry` | `quay.io` | Container image registry |
| `image.repository` | `streamshub/console-operator` | Container image repository |
| `image.tag` | `""` (chart `appVersion`) | Override the image tag |
| `image.pullPolicy` | `Always` | Image pull policy |
| `replicaCount` | `1` | Operator replica count |
| `watchNamespaces` | `JOSDK_ALL_NAMESPACES` | Namespaces to watch for `Console` CRs, comma-separated, or `JOSDK_ALL_NAMESPACES` for cluster-wide |
| `serviceMonitor.enabled` | `false` | Install a Prometheus Operator `ServiceMonitor` (requires the `monitoring.coreos.com` CRDs) |
| `openshift.clusterMonitoringView` | `false` | Bind the operator to OpenShift's built-in `cluster-monitoring-view` ClusterRole |
