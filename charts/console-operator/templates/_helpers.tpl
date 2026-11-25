{{/*
Hand-authored helper templates. Not touched by hack/sync-from-release.sh.
*/}}

{{- define "console-operator.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{ .Values.image.registry }}/{{ .Values.image.repository }}:{{ $tag }}
{{- end -}}
