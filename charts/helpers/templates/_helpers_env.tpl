
        {{- define "env_metadata" -}}
        - name: AppName
          value: {{ .Values.global.name }}
        - name: ReleaseName
          value: {{ .Release.Name }}
        - name: Host
          value: {{ include "host" . }}
        - name: AppVersion
          value: {{ include "appVersion" . }}
        - name: Environment
          value: {{ include "environment" . }}
        {{- end -}}
                
        {{- define "env_evacs" -}}
        - name: Evacs__MaxJobsInParallel
          value: {{ .Values.global.evacs.maxJobsInParallel | quote }}   
        - name: Evacs__TimerIntervalSeconds
          value: {{ .Values.global.evacs.timerIntervalSeconds | quote }}
        {{- end -}}

        {{- define "env_aspnetcore" -}}
        - name: ASPNETCORE_ENVIRONMENT
          value: {{ include "environment" . }}
        - name: ASPNETCORE_URLS
          value: http://0.0.0.0:{{ .Values.port }}  
        {{- end -}}

        {{- define "env_logging" -}}
        - name: Logging__Level
          value: {{ .Values.global.logging.level }}
        - name: Logging__ConsoleLevel
          value: {{ .Values.global.logging.consoleLevel }}
        {{ $counter := 0 | int }}
        {{- range .Values.global.logging.overrides -}}
        - name: Logging__{{ $counter }}__SourceContext
          value: {{ .sourceContext }}
        - name: Logging__{{ $counter }}__Level
          value: {{ .level }}
        {{ $counter = add1 $counter }}
        {{ end }}
        {{- end -}}

        {{- define "env_custom" -}}
        {{- range .Values.customEnvironment -}}
        - name: {{ .name }}
          value: {{ .value | quote }}
        {{ end }} 
        {{- end -}}
        
        {{- define "env_customsecret" -}} 
        {{- range .Values.customSecret -}}
        - name: {{ .name }}
          valueFrom:
           secretKeyRef:
             name: {{ include "moduleName" $ }}-secrets
             key: {{ .name }}
        {{ end }}
        {{- end -}}

        {{- define "env_openidserver" -}}
        - name: OpenIdOptions__AccessTokenExpiryHours 
          value: {{ .Values.global.openId.accessTokenExpiryHours | quote }}
        - name: OpenIdOptions__RefreshTokenExpiryDays
          value: {{ .Values.global.openId.refreshTokenExpiryDays | quote }}
        - name: OpenIdOptions__BaseAuthUrl
          value: {{ .Values.global.openId.baseAuthUrl }}
        - name: OpenIdOptions__EncryptionPassword
          valueFrom:
            secretKeyRef:
              name: {{ include "moduleName" . }}-secrets
              key: OpenIdOptions--EncryptionPassword
        - name: OpenIdOptions__SigningPassword
          valueFrom:
            secretKeyRef:
              name: {{ include "moduleName" . }}-secrets
              key: OpenIdOptions--SigningPassword
        {{- end -}}

        {{- define "env_openidclient" -}}
        - name: ClientName
          value: {{ .Values.name }}
        - name: AccountClientOptions__TenantId
          value: {{ .Values.accountClientOptions.tenantId }}
        - name: AccountClientOptions__ApplicationId
          value: {{ .Values.accountClientOptions.applicationId }}
        - name: AccountClientOptions__OpenIdClientId
          value: {{ .Values.accountClientOptions.openIdClientId }}
        - name: AccountClientOptions__OpenIdClientSecret
          value: {{ .Values.accountClientOptions.openIdClientSecret }}
        - name: AccountClientOptions__OpenIdClientDomain
          value: {{ include "clientUrl" . }}
        - name: AccountClientOptions__AuthBaseUrl
          value: {{ .Values.global.openId.baseAuthUrl }}
        - name: AccountClientOptions__ApiBaseUrl
          value: {{ .Values.global.openId.baseAuthUrl }}
        {{- end -}}

        
        {{- define "resources" -}}
        {{- if .Values.resources -}}
        resources:
          requests:
            memory: {{ .Values.resources.requests.memory | quote }} 
            cpu:  {{ .Values.resources.requests.cpu | quote }} 
          limits:
            memory: {{ .Values.resources.limits.memory | quote }} 
            cpu: {{ .Values.resources.limits.cpu | quote }}
        {{- else if .Values.global.resources -}}
        resources:
          requests:
            memory: {{ .Values.global.resources.requests.memory | quote }} 
            cpu:  {{ .Values.global.resources.requests.cpu | quote }} 
          limits:
            memory: {{ .Values.global.resources.limits.memory | quote }} 
            cpu: {{ .Values.global.resources.limits.cpu | quote }}
        {{- else -}}
        resources:
          requests:
            memory: "32Mi"
            cpu:  "10M"
          limits:
            memory: "256Mi"
            cpu: "250M"
        {{- end -}}
        {{- end -}}
