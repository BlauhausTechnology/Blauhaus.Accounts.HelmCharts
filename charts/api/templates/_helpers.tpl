{{- define "applicationName" -}}
{{ printf "%s" .Release.Name -}}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}

{{- define "imageUrl" -}}
{{ printf "%s/%s-%s:%s" .Values.global.repository .Values.global.appName .Chart.Name .Chart.AppVersion -}}
{{- end -}}

{{- define "appVersion" -}}
 {{ printf "%s" .Chart.appVersion }}
{{- end -}}

{{- define "host" -}}
{{- if contains .Release.Name "production" -}}
{{- printf "%s.%s" .Values.global.appName .Values.global.domain -}}
{{- else -}}
{{- printf "%s-%s.%s" .Values.global.appName .Release.Name .Values.global.domain -}}
{{- end -}}
{{- end -}}

{{- define "environment"}}
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