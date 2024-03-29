{{- define "applicationName" -}}
{{ printf "%s" .Values.global.name }}
{{- end -}}
  
{{- define "appVersion" -}}
{{ .Values.global.appVersion }}
{{- end -}}

{{- define "moduleName" -}}
{{ printf "%s-%s-%s" .Values.global.name .Values.global.environment .Chart.Name }}
{{- end -}}

{{- define "clientModuleName" -}}
{{ printf "%s-%s-%s-%s" .Values.global.name .Values.global.environment .Chart.Name .Values.name }}
{{- end -}}


{{- define "host" -}} 
{{- printf "%s-%s.%s" .Values.global.name .Values.global.environment .Values.global.domain -}}
{{- end -}}

{{- define "clientHost" -}} 
{{- .Values.clientHost -}}
{{- end -}}

{{- define "clientUrl" -}} 
{{- printf "https://%s/" .Values.clientHost -}}
{{- end -}}

{{- define "dockerImage" -}} 
{{- printf "%s/%s-%s:%s" .Values.global.repository .Values.global.name .Chart.Name .Values.global.appVersion -}}
{{- end -}}

{{- define "clientDockerImage" -}} 
{{- printf "%s/%s-%s-%s:%s" .Values.global.repository .Values.global.name .Chart.Name .Values.name .Values.global.appVersion -}}
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



