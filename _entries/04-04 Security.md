---
sectionid: security
sectionclass: h2
parent-id: opstasks
title: Security
---

### Azure Kubernetes Services integration with Security Center (Preview)

Use AKS together with Azure Security Center's standard tier to gain deeper visibility to your AKS nodes, cloud traffic, and security controls.

Security Center brings security benefits to your AKS clusters using data already gathered by the AKS master node.

![Azure Security Center](media/Azure-Security-Center.png)

> **References**
> * <https://docs.microsoft.com/en-us/azure/security-center/azure-kubernetes-service-integration>

#### Benefits of integration

Using the two services together provides:

##### Security recommendations:
Security Center identifies your AKS resources and categorizes them: from clusters to individual virtual machines. You can then view security recommendations per resource. For more information, see the containers recommendations in the reference list of recommendations.

##### Environment hardening:
Security Center constantly monitors the configuration of your Kubernetes clusters and Docker configurations. It then generates security recommendations that reflect industry standards.

##### Run-time protection:
Through continuous analysis of the following AKS sources, Security Center alerts you to threats and malicious activity detected at the host and AKS cluster level:

- Raw security events, such as network data and process creation
- The Kubernetes audit log

For more information, see [threat protection for Azure containers](https://docs.microsoft.com/en-us/azure/security-center/threat-protection#azure-containers)

For the list of possible alerts, see these sections in the alerts reference table: [AKS cluster level alerts](https://docs.microsoft.com/en-us/azure/security-center/alerts-reference#alerts-akscluster) and [Container host level alerts](https://docs.microsoft.com/en-us/azure/security-center/alerts-reference#alerts-containerhost).

![Azure Security Center Architecture](media/Azure-Security.png)

##### Note

- Some of the data scanned by Azure Security Center from your Kubernetes environment may contain sensitive information.
