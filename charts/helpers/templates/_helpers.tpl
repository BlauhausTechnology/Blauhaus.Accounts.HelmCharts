{{- define "applicationName" -}}
{{ printf "%s" .Values.global.appName }}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s-%s-%s" .Values.global.appName .Values.global.environment .Chart.Name .Values.clientName }}
{{- end -}}
  
{{- define "appVersion" -}}
{{ .Values.global.appVersion }}
{{- end -}}

{{- define "appHost" -}} 
{{- printf "%s-%s.%s" .Values.global.appName .Values.global.environment .Values.global.domain -}}
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