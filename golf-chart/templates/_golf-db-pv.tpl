# production data volume configuration
{{- define "golfDbProductionDataPV"}}
resources:
  requests:
    storage: {{ .Values.golfDb.dataStorageSize }}
accessModes:
  - ReadWriteOnce
storageClassName: do-block-storage
{{- end }}
# test data volume configuration
{{- define "golfDbTestDataPV"}}
storageClassName: golf-db-pv
resources:
  requests:
    storage: {{ .Values.golfDb.dataStorageSize }}
accessModes:
  - ReadWriteOnce
{{- end }}
# production backup volume configuration
{{- define "golfDbProductionBackupPV"}}
resources:
requests:
    storage: {{ .Values.golfDb.backupStorageSize }}
accessModes:
- ReadWriteOnce
storageClassName: do-block-storage
{{- end }}
# test backup volume configuration
{{- define "golfDbTestBackupPV"}}
storageClassName: golf-backup-pv
resources:
  requests:
    storage: {{ .Values.golfDb.backupStorageSize }}
accessModes:
  - ReadWriteOnce
{{- end }}