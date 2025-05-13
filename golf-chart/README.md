golf-chart

Install DGNG application in kubernetes cluster

Default applies for DigitalOcean kubernetes cluster

1. For installation in DigitalOcean kubernetes cluster (production)

a. Copy values.yaml into prod-values.yaml and update it with correct data regarding credentials, allowed origin, etc... (see test sections for guidance)
b. Install golf-chart using previously created values file
c. Copy domain ssl certificates to cert volume

2. For testing locally on Windows WS2 Ubuntu

Prerequisites:

  - Installed Ubuntu on Windows WS2 with below software:
    - Docker 
    - git

a. Install Ansible
 
  sudo apt update
  sudo apt install -y ansible

b. Install git

  sudo apt install git

b. Clone golf-kubernetes project

   git clone https://github.com/gmalewicz/golf-kubernetes.git

c. Set root password
  
    go to golf-kubernetes/ansible directory open 'hosts' files, modify 'ansible_become_pass=****' to point to your root password and save that file
    for fresh installation ws2 Ubuntu root password is not set. You can do it using 'sudo passwd root' command

d. go to golf-kubernetes/ansible and run execute playbook:

  ansible-playbook golf_playbook.yaml






d. Install Rancher K3s, check the status, verify if node and all pods are running

  curl -sfL https://get.k3s.io | sh -
  sudo systemctl status k3s
  sudo k3s kubectl get nodes
  sudo k3s kubectl get pods --all-namespaces

e. Install MetalLB and wait until pods are running

  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifest/metallb-native.yaml
  kubectl get pods -n metallb-system

d. Configure MetalLB IP address pool that matches your IP range

  kubectl apply -f ../matallb-config.yaml

e. install argoCD

  kubectl create namespace argocd
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

e. Port forward for application

  kubectl port-forward svc/golf-web-lb 8900:443

e. Port forward for argoCD

  kubectl port-forward svc/argocd-server -n argocd 8901:443

e. Socket bind

  sudo socat TCP-LISTEN:8443,fork,bind=0.0.0.0 TCP:127.0.0.1:6443

e. Minify to find port

  kubectl config view --minify

e. Get argocd password

  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


d. go to golf-kubernetes/ansible and run execute playbook:

  ansible-playbook golf_playbook.yaml


























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
e. Create and copy localhost ssl certificates (localhost.crt localhost.key)  to cert volume. Note that cert contents is removed after cluster uninstallation.


	C:\'Program Files'\OpenSSL-Win64\bin\openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RootCA.key -out RootCA.pem -subj "/C=US/CN=Example-Root-CA"
	C:\'Program Files'\OpenSSL-Win64\bin\openssl x509 -outform pem -in RootCA.pem -out RootCA.crt

	create file domains.txt with content:

	authorityKeyIdentifier=keyid,issuer
	basicConstraints=CA:FALSE
	keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
	subjectAltName = @alt_names
	[alt_names]
	DNS.1 = localhost
	DNS.2 = fake1.local
	DNS.3 = fake2.local

	C:\'Program Files'\OpenSSL-Win64\bin\openssl req -new -nodes -newkey rsa:2048 -keyout localhost.key -out localhost.csr -subj "/C=US/ST=YourState/L=YourCity/O=Example-Certificates/CN=localhost.local"
	C:\'Program Files'\OpenSSL-Win64\bin\openssl x509 -req -sha256 -days 1024 -in localhost.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile domains.ext -out localhost.crt

f. Create app-config.json file in web server assets directory with the following content:

{
  "wsEndpoint": "localhost/websocket/onlinescorecard?token="
}



