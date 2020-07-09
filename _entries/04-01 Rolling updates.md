---
sectionid: rollingupdate
sectionclass: h2
parent-id: opstasks
title: Perform Rolling Updates
---

Rolling updates can be used to to update the images, configuration, labels, annotations, and resource limits/requests of workloads in your clusters.

Incrementally updating Pod instances and replacing the resource’s Pods with new ones facilitate deployment updates with zero downtime.

Rolling updates are triggered on workloads by updating their Pod templates. Kubernetes workloads are represented by the following objects:

- DaemonSets
- Deployments
- StatefulSets

The Pod template *spec: template* includes these fields:

- container
- containers: image
- metadata: labels
- volumes

Note: Scaling a resource or updating fields other than those in the Pod template will not trigger a rolling update.

### Find the image uploaded to your private Azure Container Registry from Azure portal

Firstly, we will find the image that was uploaded to Azure Container Registry during the Getting Started section. We can use this private image to edit our deployment for testing the rolling update.

![ACR Tag](media/acrtag.png)

Find the tag of the captureorder application on your private ACR repository. The tag name will used for updating the deployment.

### Rolling Update

Perform rolling update by changing the image details for the captureorder deployment

{% collapsible %}

````
kubectl set image deployment/captureorder captureorder=<ACR_REPO_NAME>.azurecr.io/captureorder:<tag_name> --record
````

Example if ACR repository name (ACR_REPO_NAME) is akstest2020 and tag name is cm1:

````
kubectl set image deployment/captureorder captureorder=akstest2020.azurecr.io/captureorder:cm1 --record
````

{% endcollapsible %}

Check status of the update for captureorder deployment

{% collapsible %}

````
kubectl rollout status deployment captureorder
````

{% endcollapsible %}

Verify the tag has changed in the captureorder deployments

{% collapsible %}

````
kubectl describe deployment captureorder
````

{% endcollapsible %}

### Roll back the update

In order to roll back the update to a previous state, the rolling update should have been recorded.

Check history to determine which version to roll back the captureorder deployment

{% collapsible %}

````
kubectl rollout history deploy captureorder
````

{% endcollapsible %}

Roll back captureorder deployment to a previous version

{% collapsible %}

````
kubectl rollout undo deploy captureorder
````

{% endcollapsible %}

Roll back to a specific revision by specifying version

{% collapsible %}

````
kubectl rollout undo deploy captureorder --to-revision=1
````

{% endcollapsible %}

> **Hint** Similar steps can be used to trigger a rolling update for the frontend application

### Troubleshooting

If the `timeout` duration is reached during a rolling update, the operation will fail with some pods belonging to the new replication controller, and some to the original controller.

To continue the update from where it failed, retry using the same command.

To roll back to the original state before the attempted update, append the `--rollback=true` flag to the original command. This will revert all changes.
