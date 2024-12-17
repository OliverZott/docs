# Kubernetes

## Architecture of Kubernetes

### Pod

A Pod is the smallest deployable unit in Kubernetes  The smalles instance of an application. It is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers4. Pods are ephemeral by nature, if a pod (or the node it executes on) fails, Kubernetes can automatically create a new replica of that pod to continue operations5. Each Pod has its own IP, allowing Pods to communicate with other Pods on the same Node or other Nodes1.

- `pod-definition.yaml` - definition file for pod

#### Scaling

For scaling new PODs with same instance of application are created(**ReplicaSet** ??), NOT new containers inside POD! If physicall capacity is succeeded, we can add new Node to the cluster.

#### Multi-Container PODs

- Not for scaling, just helper containers for main container. For example, logging container, or helper container for main container.
- Can communicate due to network namespace. Also can share storage.
- PODs do all the linking etc automatically!
- In general rare usecase

### Nodes

A Node is a machine that runs these Pods. It can be a physical machine or a virtual machine, and can be hosted on-premises or in the cloud. Each Node is managed by the control plane and contains the services necessary to run Pods. A Kubernetes cluster can have a large number of Nodes. There are two types of Nodes: The Kubernetes Master Node which runs the Kubernetes control plane controlling the entire cluster, and Worker Nodes which are nodes on which you can run containerized workloads1.

- Single server in Kubernetes cluster
- machine on which kubernetes is installed
- can be a physical machine or a virtual machine
- 2 types:
  - Worker Node
  - Master Node

### Cluster

- group of nodes
- if one node fails, other one steps in

### Master Node

- **master node** manages the cluster

## Components

- when klubernetes is installed, it installs a bunch of components:
  - **API Server** - front end for the control plane
  - **etcd** - key-value store that stores all data used to manage the cluster. It is the single source of truth.
  - **kubelet** - agent that runs on each node in the cluster. It makes sure that containers are running in a pod.
  - **Container Runtime** - software that runs containers. Kubernetes supports several container runtimes: Docker, containerd, CRI-O, and any implementation of the Kubernetes CRI (Container Runtime Interface).
  - **kubectl** - (cube control) command line tool for interacting with the cluster
  - **Control Plane** - set of containers that manage the cluster
  - **Controller** - brain behind orchestration. It is always watching the state of the cluster through the API server and makes changes to the current state to match the desired state.
    - **kube-controller-manager** - runs controllers
    - **cloud-controller-manager** - runs controllers that interact with the underlying cloud providers
  - **kube-scheduler** - schedules pods to run on nodes in the cluster. distributing work or containers across multiple nodes.

### Replication Controller (NEW: Replica Set)

- special controller
- ensures that a specified number of pod replicas are running at any one time
- if a pod fails, it will create a new one
- load balancig & scaling
- `rd-definition.yaml` - definition file for replication controller

## Deployment

- similar to replica set file! (just different kind!)
- above in hierarchy
- automatically creates
  - replica sets
  - pods
- `deployment-definition.yaml` - definition file for deployment

### Rollout and Versioning

- On Rollouts Revision number is increased
- Deployment strategy
  - Recreate - destroy all pods and create new ones
  - Rolling Update - destroy one pod and create new one, then next one, etc.
- `kubectl rollout status deployment/myapp-deployment` - check status of rollout
- `kubectl rollout history deployment/myapp-deployment` - check history of rollout
- `kubectl rollout undo deployment/myapp-deployment` - undo rollout
- For updating:
  - `kubectl apply -f deployment-definition.yaml` - apply new definition file
  - `kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1` - set new image for deployment BUT definition yaml has differnet version!!
