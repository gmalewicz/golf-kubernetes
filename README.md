# Golf Application

Prerequisites:

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
Note: Do not breake the playbook even if prompted

## Access to golf appication

### Start port forwarding

```console
kubectl port-forward svc/golf-web-lb 8900:443
```

### Open Golf spplication 

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

Note: You need to reopen ubuntu session to make kubectl working for your user otherwise use sudo \
Note: Cluster is synchronized with repository main branch

## Work in progress

e. Socket bind

sudo socat TCP-LISTEN:8443,fork,bind=0.0.0.0 TCP:127.0.0.1:6443

e. Minify to find port

kubectl config view --minify
