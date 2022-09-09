{{- define "applicationName" -}}
{{ printf "%s" .Values.global.appName }}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s" .Values.global.appName .Values.global.environment .Chart.Name }}
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