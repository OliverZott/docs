# Kubernetes

## Architecture of Kubernetes

### Pod

A Pod is the smallest deployable unit in Kubernetes4. It is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers4. Pods are ephemeral by nature, if a pod (or the node it executes on) fails, Kubernetes can automatically create a new replica of that pod to continue operations5. Each Pod has its own IP, allowing Pods to communicate with other Pods on the same Node or other Nodes1.

### Nodes

A Node is a machine that runs these Pods. It can be a physical machine or a virtual machine, and can be hosted on-premises or in the cloud21. Each Node is managed by the control plane and contains the services necessary to run Pods. A Kubernetes cluster can have a large number of Nodes. There are two types of Nodes: The Kubernetes Master Node which runs the Kubernetes control plane controlling the entire cluster, and Worker Nodes which are nodes on which you can run containerized workloads1.

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

### Components

- when klubernetes is installed, it installs a bunch of components:
  - **API Server** - front end for the control plane
  - **etcd** - key-value store that stores all data used to manage the cluster. It is the single source of truth.
  - **kubelet** - agent that runs on each node in the cluster. It makes sure that containers are running in a pod.
  - **Container Runtime** - software that runs containers. Kubernetes supports several container runtimes: Docker, containerd, CRI-O, and any implementation of the Kubernetes CRI (Container Runtime Interface).
  - **kubectl** - command line tool for interacting with the cluster
  - **Controller** - brain behind orchestration. It is always watching the state of the cluster through the API server and makes changes to the current state to match the desired state.
    - **kube-controller-manager** - runs controllers
    - **cloud-controller-manager** - runs controllers that interact with the underlying cloud providers
  - **kube-scheduler** - schedules pods to run on nodes in the cluster. distributing work or containers across multiple nodes.