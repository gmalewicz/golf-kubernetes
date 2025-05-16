# Golf Application

Set of tools for creation of developement CD environment based on Rancher K3s on WSL2 Ubuntu 

Used technologes: 
- Docker required by K3s
- Rancher K3s for developement CD
- MetalLB as a network load balancer 
- HELM for managing Kubernetes application
- Bash script to start entire installation
- Ansible for installation automation
- ArgoCD for CD with git archive (push on main)  

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
