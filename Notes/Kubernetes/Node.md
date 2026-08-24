# Node

- A **Node** is a single machine (physical or virtual) inside a **Cluster**.
- Each Node has resources: CPU, RAM, disk, network. Kubernetes schedules **Pods** onto Nodes.
- Two types:
  - **Control-Plane Node**: runs the control plane components (API server, scheduler, controller-manager, etcd). Manages the cluster.
  - **Worker Node**: runs your workloads. Contains `kubelet` (agent), `kube-proxy` (networking), and a container runtime (e.g. `containerd`/`Docker`).
- If a Node dies, Kubernetes moves its Pods to other healthy Nodes (self-healing).

## Example

**Single-node cluster (most common for learning):**
```bash
minikube start --driver=docker
kubectl get nodes
```
Output:
```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   2m    v1.28.0
```
Here: **1 Node** that acts as both control-plane and worker (everything runs on one machine).

**Multi-node cluster:**
```bash
kubectl get nodes -o wide
```
Output:
```
NAME           STATUS   ROLES           INTERNAL-IP      OS-IMAGE
minikube       Ready    control-plane   192.168.49.2     Ubuntu 22.04
minikube-m02   Ready    <none>          192.168.49.3     Ubuntu 22.04
```
Then deploy an app:
```bash
kubectl get pods -o wide
```
Output:
```
NAME                     READY   STATUS    NODE           IP
my-app-7d4b8c9f-abcde    1/1     Running   minikube-m02   10.244.1.2
my-app-7d4b8c9f-fghij    1/1     Running   minikube       10.244.0.5
```
Each Pod is running on a specific Node. The cluster decides where to place them based on available resources.

> Analogy: **Cluster = Team**, **Node = Team Member**, **Pod = Task**. The team (cluster) distributes tasks (pods) among members (nodes).

Related: [[Cluster]], [[What is Kubernetes]], [[Minikube]]
