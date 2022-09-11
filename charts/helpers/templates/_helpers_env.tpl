
        {{- define "env_metadata" -}}
        - name: AppName
          value: {{ .Values.global.name }}
        - name: ReleaseName
          value: {{ .Release.Name }}
        - name: Host
          value: {{ include "host" . }}
        - name: AppVersion
          value: {{ include "appVersion" . }}
        {{- end -}}

        {{- define "env_aspnetcore" -}}
        - name: ASPNETCORE_ENVIRONMENT
          value: {{ include "environment" . }}
        - name: ASPNETCORE_URLS
          value: http://0.0.0.0:{{ .Values.port }}  
        {{- end -}}

        {{- define "env_logging" -}}
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
