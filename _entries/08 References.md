---
sectionid: resources
sectionclass: h1
title: Resources
is-parent: yes
---

### Kubernetes Cheat Sheet

  ![Kubectl Cheat Sheet](media/K8CheatSheet-1.png)

  ![Kubectl Cheat Sheet](media/K8CheatSheet-2.png)

### Scaling Types

- Horizontal scaling - scale by adding more machines (nodes in Kubernetes) into your pool of resources

- Vertical scaling - scale by adding more power (CPU, RAM) to an existing machine (Node or Master in Kubernetes).

  ![Horizontal and Vertical Scaling](media/Scaling.png)

### Self Healing Applications on Kubernetes

When a pod is scheduled to a node, the kubelet on that node runs its containers and keeps them running as long as the pod exists. The kubelet will restart a container if its main process crashes. But if the application inside of the container throws an error which causes it to continuously restart, Kubernetes has the ability to heal it by using the correct diagnostic and then following the pod’s restart policy.

Within containers, the kubelet can react to two kinds of probes:

**Liveness Probe** - the kubelet uses these probes as an indicator to restart a container. A liveness probe is used to detect when an application is running and is unable to make progress. When a container gets in this state, the pod’s kubelet can restart the container via its restart policy.

**Readiness Probe** - This type of probe is used to detect if a container is ready to accept traffic. You can use this probe to manage which pods are used as backends for load balancing services. If a pod is not ready, it can then be removed from the list of load balancers.

  ![Pod Health Status](media/pod-health-check.png)


### Kubernetes Controllers

#### DaemonSet

A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.

Typical uses of a DeamonSet are:

- Running a node monitoring daemon on every node, such as Prometheus, Datadog Agent, New Relic agent.
- Running log collection daemon on every node, such as fluentd.
- Running a cluster storage daemon on every node, such as ceph, glusterd.

  ![DaemonSet](media/DaemonSet.png)

#### ReplicaSet

A ReplicaSet’s purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods.

A ReplicaSet ensures that a specified number of pod replicas are running at any given time.

  ![ReplicaSet](media/ReplicaSet.png)

#### Deployment

Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods along with a lot of other useful features.

We recommend using Deployments instead of directly using ReplicaSets, unless you require custom update orchestration or don’t require updates at all.

Deployments ensure that we can safely rollout new versions of our pods safely and without outages. They also make it possible to rollback a deployment if there is some terrible issue with the new version.

Deployments manage ReplicaSets and ReplicaSets manage pods and pods manage containers.

  ![Deployment](media/Deployment.png)

> **References**
> * <https://linuxacademy.com/blog/containers/kubernetes-cheat-sheet/>
> * <https://www.weave.works/blog/resilient-apps-with-liveness-and-readiness-probes-in-kubernetes>
> * <https://kubernetes.io/docs/concepts/workloads/controllers/>
