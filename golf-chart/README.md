golf-chart

Install DGNG application in kubernetes cluster

Default applies for DigitalOcean kubernetes cluster

1. For installation in DigitalOcean kubernetes cluster (production)

a. Copy values.yaml into prod-values.yaml and update it with correct data regarding credentials, allowed origin, etc... (see test sections for guidance)
b. Install golf-chart using previously created values file
c. Copy domain ssl certificates to cert volume

2. For testing locally on Windows WS2 Ubuntu

Prerequisites:

  - Installed Ubuntu on Windows WS2 with user golf
    
a. Install Ansible
 
  sudo apt update
  sudo apt install -y ansible

b. Install git

  sudo apt install git

c. Clone golf-kubernetes project

  git clone https://github.com/gmalewicz/golf-kubernetes.git

d. Set root password (set password to 'welcome')
  
  for fresh installation ws2 Ubuntu root password is not set. You can do it using 'sudo passwd root' command

e. Optional: Modify root password if set to different than 'welcome'

  go to golf-kubernetes/ansible directory open 'hosts' files, modify 'ansible_become_pass=****' to point to your root password and save that file
  
f. go to golf-kubernetes/ansible and run execute playbook:

  ansible-playbook golf_playbook.yaml

h. Optional: Acccess ArgoCD UI

  kubectl port-forward svc/argocd-server -n argocd 8901:443
  https://localhost:8901 (from your local browser to access UI)
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d (to get password - user is admin) 

c. Access golf appication

  kubectl port-forward svc/golf-web-lb 8900:443
  https://localhost:8900 (from your local browser to access - if you are able log in it means environment is set up correctly)






e. Port forward for application

  kubectl port-forward svc/golf-web-lb 8900:443



e. Socket bind

  sudo socat TCP-LISTEN:8443,fork,bind=0.0.0.0 TCP:127.0.0.1:6443

e. Minify to find port

  kubectl config view --minify