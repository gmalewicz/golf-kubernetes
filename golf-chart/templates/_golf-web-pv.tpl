# production cert volume configuration
{{- define "golfWebProductionCertPV"}}
resources:
  requests:
    storage: {{ .Values.golfWeb.certStorageSize }}
accessModes:
  - ReadWriteOnce
storageClassName: do-block-storage
{{- end }}
# test cert volume configuration
{{- define "golfWebTestCertPV"}}
storageClassName: local-storage
resources:
  requests:
    storage: {{ .Values.golfWeb.certStorageSize }}
accessModes:
  - ReadWriteOnce
volumeName: golf-web-pv
{{- end }}