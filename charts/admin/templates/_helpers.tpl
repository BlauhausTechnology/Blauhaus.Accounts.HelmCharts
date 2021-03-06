{{- define "applicationName" -}}
{{ printf "%s-%s" .Values.global.appName .Release.Name -}}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s-%s" .Values.global.appName .Release.Name .Chart.Name -}}
{{- end -}}

{{- define "host" -}}
{{- if eq .Release.Name "production" -}}
{{- printf "%s.%s" .Values.global.appName .Values.global.domain -}}
{{- else -}}
{{- printf "%s-%s.%s" .Values.global.appName .Release.Name .Values.global.domain -}}
{{- end -}}
{{- end -}}

{{- define "environment"}}
{{- if eq .Release.Name "production" -}}
{{- "Production" -}}
{{- else if eq .Release.Name "staging" -}}
{{- "Staging" -}}
{{- else if eq .Release.Name "testing" -}}
{{- "Testing" -}}
{{- else -}}
{{- "Development" -}}
{{- end -}}
{{- end -}}