---
sectionid: k8sbasics
sectionclass: h2
title: What is Kubernetes?
parent-id: intro
---

### Basic Kubernetes Architecture

When you deploy Kubernetes, you get a cluster.

A Kubernetes cluster consists of a set of worker machines, called nodes, that run containerized applications. Every cluster has at least one worker node.

The worker node(s) host the pods that are the components of the application. The Control Plane manages the worker nodes and the pods in the cluster. In production environments, the Control Plane usually runs across multiple computers and a cluster usually runs multiple nodes, providing fault-tolerance and high availability.

Here’s the diagram of a Kubernetes cluster with all the components tied together.

![Kubernetes Components diagram](media/components-of-kubernetes.png)


![Kubernetes Control Plane Components diagram](media/ControlPlane.png)


![Kubernetes Node Components diagram](media/WorkerNode.png)


![Kubernetes Pod Creation Flow](media/PodCreation.png)

#### Create Pod Flow

- kubectl writes to the API Server.
- API Server validates the request and persists it to etcd.
- etcd notifies back the API Server.
- API Server invokes the Scheduler.
- Scheduler decides where to run the pod on and return that to the API Server.
- API Server persists it to etcd.
- etcd notifies back the API Server.
- API Server invokes the Kubelet in the corresponding node.
- Kubelet talks to the Docker daemon using the API over the Docker socket to create the container.
- Kubelet updates the pod status to the API Server.
- API Server persists the new state in etcd.

> **References**
> * <https://kubernetes.io/docs/concepts/overview/components/>
> * <https://blog.heptio.com/core-kubernetes-jazz-improv-over-orchestration-a7903ea92ca/>
