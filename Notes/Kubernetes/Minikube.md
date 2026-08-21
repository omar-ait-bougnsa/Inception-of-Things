# Minikube

- **Minikube** is a tool that runs a single-node Kubernetes cluster locally on your machine (great for learning and development).
- Before starting, check that a container runtime (e.g. Docker) or a VM driver (e.g. VirtualBox) is installed.

## Minikube start

### Basic commands

```bash
minikube start
```

- Starts a local Kubernetes cluster with default settings (single node).
- Downloads the needed Kubernetes components on first run and creates the node inside a container/VM.

```bash
minikube start --driver=docker
```

- Forces minikube to run the Kubernetes node inside a Docker container (lightweight, no VM needed).

```bash
minikube start --driver=virtualbox
```

- Runs the cluster inside a VirtualBox VM (more isolated, closer to a real machine).

```bash
minikube start --nodes=2
```

- Starts a cluster with 2 nodes (1 control-plane + 1 worker), useful to practice multi-node behavior.

```bash
minikube start --kubernetes-version=v1.28.0
```

- Starts the cluster with a specific Kubernetes version.

```bash
minikube start -p mycluster
```

- Creates a named cluster (profile) so you can run multiple clusters side by side.

### Useful related commands

```bash
minikube status          # show the status of the cluster (host, kubelet, apiserver)
kubectl get nodes        # list the nodes of the running cluster
minikube stop            # stop the cluster (keep its data)
minikube delete          # delete the cluster completely (remove data and VM/container)
minikube dashboard       # open the Kubernetes web dashboard
```

Related: [[What is Kubernetes]]
