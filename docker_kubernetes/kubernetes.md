# Kubernetes commands

- `kubectl config get-contexts`

- `kubectl get pods --namespace <namespace>`
- `kubectl get pods --namespace <namespace> <podname> -o yaml`
- `kubectl describe pods <podname>`

- `kubectl get deployments`
- `kubectl get deployments <deployment-name> -o yaml`
- `kubectl describe deployment <DEPLOYMENT-NAME>`

- `kubectl logs <POD-NAME>`

Steps to deploy and use kong for routing:

## Routing via Kong

Add service to kong file:

- `kubectl apply -f C:\Data\conf.yml`

Restart apigateway:

- `kubectl rollout restart deployment apigateway`

## General Kubernetes steps (example)

- generate docker image with env-var
- push image to registry
  - `docker push <registry.azurecr.io/oliver_zott_app>`
  - `kubectl get pods`
- create secret
  - `kubectl apply -f .\manifests\secret.yaml`
- create deployment
  - `kubectl apply -f .\manifests\deployment.yaml`
- create service and/or add service to deployment.yaml
  - `kubectl apply -f .\manifests\deployment.yaml`
  - `kubectl get services`
  - `kubectl get service oz-service -o yaml`
- create and push ingress
  - `kubectl apply -f .\manifests\ingress.yaml`
  - `kubectl get ingress` and add path defined in ingress.yaml

## Basics

In Kubernetes, a **Pod** is the smallest and most basic unit of an application. It is a group of one or more containers that share storage, network, and a specification for how to run the containers.

A **Deployment** is a higher-level concept that manages Pods and provides declarative updates to them. It allows you to describe the desired state of your application, and Kubernetes will work to ensure that the current state matches the desired state. Deployments use another API object called ReplicaSet to maintain the desired state by creating or deleting Pods as needed¹.

In summary, Pods run your application in containers, while Deployments manage and maintain the desired state of those Pods.

Source: Conversation with Bing, 01/08/2023:  

- kubernetes - What is the difference between a pod and a deployment .... <https://stackoverflow.com/questions/41325087/what-is-the-difference-between-a-pod-and-a-deployment>.
- When to use Kubernetes deployments, pods, and services - Educative. <https://www.educative.io/blog/kubernetes-deployments-pods-services>.
- kubernetes - Difference pod and deployment - Stack Overflow. <https://stackoverflow.com/questions/64451504/difference-pod-and-deployment>.

```md
In Kubernetes, **Ingress** is an API object that manages external access to the services in a cluster, typically via HTTP or HTTPS. Ingress may provide load balancing, SSL termination, and name-based virtual hosting¹. It allows you to easily set up rules for routing traffic without creating a bunch of Load Balancers or exposing each service on the node. This makes it the best option to use in production environments².

**Kong** is an open-source API gateway and microservice management layer. Based on Nginx and the lua-nginx-module (specifically OpenResty), Kong's pluggable architecture makes it flexible and powerful⁷. It can be used as an Ingress Controller in Kubernetes, which reads and processes the Ingress Resource information and usually runs as pods within the Kubernetes cluster².

Source: Conversation with Bing, 01/08/2023
(1) Ingress | Kubernetes. https://kubernetes.io/docs/concepts/services-networking/ingress/.
(2) What is Kubernetes Ingress? | IBM. https://www.ibm.com/cloud/blog/kubernetes-ingress.
(3) An Introduction to Kong | Baeldung. https://www.baeldung.com/kong.
(4) Ingress Controllers | Kubernetes. https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/.
(5) KONG Company – Because dogs need to play. https://www.kongcompany.com/.
(6) Kong: Skull Island (2017) - IMDb. https://www.imdb.com/title/tt3731562/.
(7) King Kong - Wikipedia. https://en.wikipedia.org/wiki/King_Kong.
```

```md
```

```md
```
