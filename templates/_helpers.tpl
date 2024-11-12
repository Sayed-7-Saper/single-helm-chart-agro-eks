{{/* Generate the full name of the chart, including the release name */}}
{{- define "my-service.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate a shorter name if necessary, e.g., for labels that need fewer characters */}}
{{- define "my-service.name" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 40 | trimSuffix "-" -}}
{{- end -}}

{{/* Labels common to all resources created by this chart */}}
{{- define "my-service.labels" -}}
app.kubernetes.io/name: {{ include "my-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: "backend"
{{- end -}}

{{/* Annotations common to all resources created by this chart */}}
{{- define "my-service.annotations" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "my-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "my-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}