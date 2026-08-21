# What is Kubernetes?

- **Kubernetes (K8s)** is an open-source container orchestration platform.
- It automates the deployment, scaling, and management of containerized applications.
- Originally developed by Google, now maintained by the Cloud Native Computing Foundation (CNCF).
- It groups containers into **Pods**, runs them on **Nodes** (machines), and manages a **Cluster** (a set of nodes).
- Key features:
  - **Self-healing**: restarts failed containers, replaces and reschedules containers when nodes die.
  - **Scaling**: horizontal scaling (add/remove replicas automatically based on load).
  - **Service discovery & load balancing**: exposes containers via stable IP/DNS and distributes traffic.
  - **Rollouts & rollbacks**: handles updates of applications with zero downtime.
  - **Storage orchestration**: mounts local or cloud storage.
  - **Secret & configuration management**: stores sensitive data and configs.
- Core components:
  - **Control Plane** (master): API server, scheduler, controller manager, etcd.
  - **Worker Nodes**: kubelet, container runtime (e.g. containerd), kube-proxy.
- Common tools used with Kubernetes:
  - **kubectl**: CLI to interact with the cluster.
  - **K3s / K3d**: lightweight Kubernetes distributions (used in this project).
  - **Helm**: package manager for Kubernetes.
  - **[[Minikube]]**: local single-node cluster for development.

Related: [[Minikube]]
