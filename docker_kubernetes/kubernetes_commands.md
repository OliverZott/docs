# Kubernetes Commands & Examples

## Examples

```bash
# Deployment
kubectl create -f deployment-definition.yaml --record # CREATE / --record to record change-cause in history!
kubectl describe deployment deployment-name  # GET
kubectl rollout history deployment/myapp-deployment  # CHECK HISTORY

kubectl edit deployment deployment-name --record # UPDATE --> e.g. edit image version
kubectl describe deployment deployment-name  # GET
kubectl rollout history deployment/myapp-deployment  # CHECK HISTORY

kubectl set image deployment <deployment-name> <template/container-name>=nginx:1.10  --record # UPDATE  (yaml not chnaged!!)
kubectl describe deployment deployment-name  # GET
kubectl rollout history deployment/myapp-deployment  # CHECK HISTORY

kubectl apply -f deployment-definition.yaml  # UPDATE
kubectl rollout status deployment/myapp-deployment  # CHECK STATUS
kubectl rollout undo deployment/myapp-deployment  # UNDO ROLLOUT
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
# Clean up
kubectl delete deployment php-apache && kubectl delete pod load-generator && kubectl delete hpa php-apache && kubectl delete service php-apache

# better via labels - e.g. labels: app: my-app
kubectl delete all -l app=my-app

# or delete ENTIRE namespace
kubectl delete namespaces my-namespace
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

# edit
kubectl edit replicaset new-replica-set

# scaling
kubectl replace -f rs-definition.yaml # replace existing rs with new one if replica count updated for scaling
kubectl scale --replicas=6 -f rs-definition.yaml
kubectl scale --replicas=6 rs <rs-name>  # or use:
kubectl edit replicaset <rs-name>  # edit replica set yaml file
```

```bash
# deployment commands
kubectl create -f .\04-deployment.yaml
kubectl get all
kubectl describe deployment <deployment-name>
kubectl create deployment <deployment-name> --image=<image-name> --replicas=<replica-count> --dry-run=client -o yaml > deployment-definition.yaml

# Strategies
kubectl create -f deployment-definition.yaml --record # CREATE / --record to record change-cause in history!
kubectl get deployments  # GET
kubectl apply -f deployment-definition.yaml  # UPDATE
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1  # UPDATE  (yaml not chnaged!!)
kubectl rollout status deployment/myapp-deployment  # CHECK STATUS
kubectl rollout history deployment/myapp-deployment  # CHECK HISTORY
kubectl rollout undo deployment/myapp-deployment  # UNDO ROLLOUT
```
