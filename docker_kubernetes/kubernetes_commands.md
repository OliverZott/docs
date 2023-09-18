# Kubernetes Commands & Examples

## Examples

```bash
```

```bash
```

```bash
```

## Commands

```bash
kubectl run hello-minikube
kubectl cluster-info
kubectl get nodes
```

```bash
# pod commands
kubectl run nginx --image=nginx --dry-run=client -o yaml > creation.yaml # dry-run to see what will be created
kubectl run nginx --image=nginx  # pull image (dockerhub), create deployment, create pod
kubectl get pods
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl describe pods nginx
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=minikube
```

```bash
# replicaset and replication controller commands
kubectl get rs -o wide
kubectl get rc -o wide
kubectl create -f rs-definition.yaml
kubectl describe rs <rs-name>
kubectl delete rs <rs-name>

# scaling
kubectl replace -f rs-definition.yaml # replace existing rs with new one if replica count updated for scaling
kubectl scale --replicas=6 -f rs-definition.yaml
kubectl scale --replicas=6 rs replicaset <rs-name>
```
