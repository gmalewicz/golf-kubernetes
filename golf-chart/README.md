golf-chart

Install DGNG application in kubernetes cluster

Default applies for DigitalOcean kubernetes cluster

1. For installation in DigitalOcean kubernetes cluster (production)

a. Copy values.yaml into prod-values.yaml and update it with correct data regarding credentials, allowed origin, etc... (see test sections for guidance)
b. Install golf-chart using previously created values file
c. Copy domain ssl certificates to cert volume

2. For installation in local kubernetes cluster (test)

a. Create cert volume - example below. Update path if required.
	
apiVersion:  v1
kind: PersistentVolume
metadata:
  name: golf-web-pv
spec:
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: local-storage
  volumeMode: Filesystem
  capacity:
    storage: 1M
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /C/Data/cert
    type: DirectoryOrCreate

b. Create backup volume - example below. Update path if required.
	
apiVersion:  v1
kind: PersistentVolume
metadata:
  name: golf-backup-pv
spec:
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: backup-storage
  volumeMode: Filesystem
  capacity:
    storage: 10M
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /C/Data/backup
    type: Directory

c. Copy values.yaml into test-values.yaml and update it with correct data regarding credentials, allowed origin, etc... 
   Following must be set in order to have functional application (base64 encoded)
	golfDb.credentials.username: your_defined_username
	golfDb.credentials.password: your_defined_password
  golfDb.credentials.backupPassword: your_defined_password (Note: the following pattern shall be used: *:*:*:*:your_defined_password)
	golfDb.dataStorageSize: 100M
	golfDb.backupStorageSize: 10M
	golfApp.allowedOrigins: localhost
	golfApp.profile: dev 
	golfWeb.certStorageSize: 1M
	developement: true
  The rest if not set, will not allow mail sending support (currenty not used) or social media registration/log in

d. Install golf-chart using previously created values file
e. Create and copy localhost ssl certificates to cert volume. Note that cert contents is removed after cluster uninstallation.
f. Create app-config.json file in web server assets directory with the following content:

{
  "wsEndpoint": "localhost/websocket/onlinescorecard?token="
}
