# How to make kubectl working from windows when Kubernetes is installed on WSL2 Ubuntu

Note: Tested on Rancher k3s (after installation of golf application)

## Prerequisites:

- Installed kubectl on Windows
- Executed procedure from readme

## Install socat

```console
sudo apt install socat 
```

## Double check Kubernetes port 

```console
kubectl config view --minify | grep server:
```

Note: Port is displayed for that IP address

## Socket bind

```console
sudo socat TCP-LISTEN:8443,fork,bind=0.0.0.0 TCP:127.0.0.1:6443 &
```

Note: Assuming port is 6443

## Copy configuration file to Windows

```console
cp ~/.kube/config /mnt/c/private/projects/kubernetes/wsl2-config.yaml
```

Note: The Windows target location is an example

## Modify yyour wsl2-config.yaml to use 8443 port

Note: Port is provided in the line with string 'server'

## Test it with kubectl 

kubectl --kubeconfig="wsl2-config.yaml" get pods

Note: Assuming the execution is in the same location as configuration file