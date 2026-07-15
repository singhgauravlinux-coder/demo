{{/*
Namespace the release deploys into. Defaults to the release namespace but can
be pinned explicitly via .Values.global.namespace (used so UAT/Prod land in
distinct namespaces like bakery-uat / bakery-prod).
*/}}
{{- define "bakery.namespace" -}}
{{- .Values.global.namespace | default .Release.Namespace -}}
{{- end -}}

{{/*
Fully qualified image reference. Usage: (list $root $name $svc.tag)
Falls back to global.imageTag when the service doesn't pin its own tag.
*/}}
{{- define "bakery.image" -}}
{{- $root := index . 0 -}}
{{- $name := index . 1 -}}
{{- $tag := index . 2 | default $root.Values.global.imageTag -}}
{{ $root.Values.global.imageRegistry }}/{{ $name }}:{{ $tag }}
{{- end -}}

{{/*
Common labels applied to every resource.
*/}}
{{- define "bakery.labels" -}}
app.kubernetes.io/part-of: crumb-and-ember
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
env: {{ .Values.global.envName | default "dev" }}
{{- end -}}
