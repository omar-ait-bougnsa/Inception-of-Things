# Cluster

- A **Cluster** is a set of **Nodes** (machines) that run containerized applications together, managed by Kubernetes.
- Think of it as a **data center in a box**: Kubernetes makes multiple machines look like one big computer.
- It has two parts:
  - **Control Plane**: the brain - makes decisions (API server, scheduler, etcd). You talk to it via `kubectl`.
  - **Worker Nodes**: the workers - actually run your Pods/containers.
- Kubernetes keeps your apps running inside the cluster even if a Node fails (it reschedules Pods to another Node).

## Example

**Local (your laptop) with Minikube:**
```bash
minikube start --nodes=2
kubectl get nodes
```
Output:
```
NAME           STATUS   ROLES           AGE   VERSION
minikube       Ready    control-plane   5m    v1.28.0
minikube-m02   Ready    <none>          5m    v1.28.0
```
Here: **1 Cluster** (`minikube`) containing **2 Nodes** (`minikube` is the control-plane node, `minikube-m02` is a worker node).

**Real world (cloud):**
An EKS/GKE cluster with 3 worker Nodes (3 VMs on AWS/GCP). If you deploy 6 Pods, Kubernetes spreads them across the 3 Nodes for high availability.

Related: [[What is Kubernetes]], [[Node]], [[Minikube]]
