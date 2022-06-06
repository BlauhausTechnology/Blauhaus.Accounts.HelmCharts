{{- define "applicationName" -}}
{{ printf "%s" .Values.global.appName }}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}

{{- define "imageUrl" -}}
{{ printf "%s/%s-%s:%s" .Values.global.repository .Values.global.appName .Chart.Name .Values.global.AppVersion }}
{{- end -}}

{{- define "appVersion" -}}
{{ .Values.global.appVersion }}
{{- end -}}

{{- define "host" -}}
{{- if contains .Release.Name "production" -}}
{{- printf "%s.%s" .Values.global.appName .Values.global.domain -}}
{{- else -}}
{{- printf "%s.%s" .Release.Name .Values.global.domain -}}
{{- end -}}
{{- end -}}

{{ define "environment"}}
{{- if contains .Release.Name "production" -}}
{{- "Production" -}}
{{- else if contains .Release.Name "staging" -}}
{{- "Staging" -}}
{{- else if contains .Release.Name "testing" -}}
{{- "Testing" -}}
{{- else -}}
{{- "Development" -}}
{{- end -}}
{{- end -}}