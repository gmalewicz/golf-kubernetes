# Golf Application

Set of tools for creation of developement CI environment based on Rancher K3s on WSL2 Ubuntu 

Used technologes:
- Kubernetes for production 
- Docker required by K3s
- Rancher K3s for developement CI
- MetalLB as a network load balancer 
- HELM for managing Kubernetes application
- Bash script to start entire installatiom
- Ansible for installation automation
- ArgoCD for CI with git archive (push on main)  

Note: Images for backend (golf-app) and frontend (golf-web) applications are build by GitHub Actions in separate repositories. They are stored in DockerHub.

## Prerequisites:

- Installed Ubuntu on Windows WSL2 with user golf

## Install git

```console
sudo apt install git
```

## Clone golf-kubernetes project

```console
git clone https://github.com/gmalewicz/golf-kubernetes.git
```

## Run script

```console
sudo bash ./golf-kubernetes/install.sh
```

Note: Number of retries depends on machine performance and internet speed. Waiting time might take several minutes \
Note: Do not break the playbook execution. \
Note: You can run agin the script if it fails until it finish with success. Accept file overwritting if prompted. \
Note: You need to reopen ubuntu session to make kubectl working for your user otherwise use sudo

## Access to golf appication

### Start port forwarding

```console
kubectl port-forward svc/golf-web-lb 8900:443
```

### Open Golf application 

[https://localhost:8900](https://) 

Note: Credentials: golfer/welcome

## Optional: Acccess to ArgoCD UI

### Start port forwarding

```console
kubectl port-forward svc/argocd-server -n argocd 8901:443
```

### Open ArgoCD UI 

[https://localhost:8901](https://) 

### Get password for admin user 

```console
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d 
```

Note: Cluster is synchronized with repository main branch

## Work in progress

e. Socket bind

sudo socat TCP-LISTEN:8443,fork,bind=0.0.0.0 TCP:127.0.0.1:6443

e. Minify to find port

kubectl config view --minify
