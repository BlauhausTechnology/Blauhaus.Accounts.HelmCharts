{{- define "moduleName" -}}
{{ printf "%s-%s-%s-%s" .Values.global.appName .Values.global.environment .Chart.Name .Values.clientName }}
{{- end -}}
 
{{- define "appVersion" -}}
{{ .Values.global.appVersion }}
{{- end -}}

{{- define "appHost" -}}
{{- if contains .Values.environment "production" -}}
{{- printf "%s.%s.%s" .Values.clientName .Values.global.appName .Values.global.domain -}}
{{- else -}}
{{- printf "%s.%s-%s.%s" .Values.clientName .Values.global.appName .Values.global.environment .Values.global.domain -}}
{{- end -}}
{{- end -}}

{{- define "logging" -}}
{{ $counter := 0 | int }}
{{- range .Values.global.logging.overrides -}}
- name: Logging__{{ $counter }}__SourceContext
  value: {{ .sourceContext }}
- name: Logging__{{ $counter }}__Level
  value: {{ .level }}
{{ $counter = add1 $counter }}
{{- end -}}
{{- end -}}

{{ define "environment"}}
{{- if contains .Values.global.environment "production" -}}
{{- "Production" -}}
{{- else if contains .Values.global.environment "staging" -}}
{{- "Staging" -}}
{{- else if contains .Values.global.environment "testing" -}}
{{- "Testing" -}}
{{- else -}}
{{- "Development" -}}
{{- end -}}
{{- end -}}