---
layout: page
title: Federator.ai v4.2
parent: installation.md
weight: 6
---

## Requirement

- Kubernetes 1.11+
- Prometheus

## Reference

- https://github.com/containers-ai/federatorai-operator

## Deployment

1. Checkout the latest tag number of v4.2. Assuming ```v4.2.159```. Execute the following command and follow the interactive prompt to input settings.
```
# curl https://raw.githubusercontent.com/containers-ai/federatorai-operator/4.2/deploy/install.sh |sh -s v4.2.159
Please input Federator.ai Operator tag: v4.2.159
Is tag "v4.2.159" correct? [default: y]:
Downloading file 00-namespace.yaml ...
Done
Downloading file 01-serviceaccount.yaml ...
Done
Downloading file 02-alamedaservice.crd.yaml ...
Done
Downloading file 03-federatorai-operator.deployment.yaml ...
Done
Downloading file 04-clusterrole.yaml ...
Done
Downloading file 05-clusterrolebinding.yaml ...
Done
Downloading file 06-role.yaml ...
Done
Downloading file 07-rolebinding.yaml ...
Done

Starting apply Federator.ai operator yaml files
namespace/federatorai created
serviceaccount/federatorai-operator created
customresourcedefinition.apiextensions.k8s.io/alamedaservices.federatorai.containers.ai created
deployment.apps/federatorai-operator created
clusterrole.rbac.authorization.k8s.io/federatorai-operator created
clusterrolebinding.rbac.authorization.k8s.io/federatorai-operator created
role.rbac.authorization.k8s.io/federatorai-operator created
rolebinding.rbac.authorization.k8s.io/federatorai-operator created
Processing...
Waiting for federatorai pods to be ready...

All federatorai pods are ready.

Install Federator.ai operator v4.2.159 successfully

Downloading alamedaservice and alamedascaler sample files ...
Done
========================================
Do you want to launch interactive installation of Federator.ai [default: y]:
Enter the namespace you want to install Federator.ai [default: alameda]:
Do you want to enable execution? [default: y]: :
Enter the prometheus service address
[default: https://prometheus-k8s.openshift-monitoring:9091]: http://prometheus-prometheus-oper-prometheus.monitoring:9090
Which storage type you would like to use? ephemeral or persistent?
[default: ephemeral]:

----------------------------------------
install_namespace = alameda
enable_execution = true
prometheus_address = http://prometheus-prometheus-oper-prometheus.monitoring:9090
storage_type = ephemeral
----------------------------------------
Is the above information correct [default: y]:
Processing...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...
Waiting for alameda pods to be ready...

All alameda pods are ready.

Install Alameda v4.2.159 successfully

Downloaded YAML files are located under /tmp/install-op
```

