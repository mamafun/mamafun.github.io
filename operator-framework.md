---
layout: page
title: Operator Framework
parent: installation.md
weight: 2
---

## Background

### OLM Architecture

[OLM Architecture](https://github.com/operator-framework/operator-lifecycle-manager/blob/274df58592c2ffd1d8ea56156c73c7746f57efc0/Documentation/design/architecture.md)

### Operator Framework Object Map
![object map](./img/obj-map.png)

## Deploy Operator Framework

### Deploy OLM and Catalog Operator

```
$ git clone https://github.com/operator-framework/operator-lifecycle-manager.git
$ sed -i 's/image: quay.io\/coreos\/olm@.*/image: quay.io\/openshift\/origin-operator-lifecycle-manager:latest/g' ./deploy/upstream/manifests/latest/*
$ kubectl create -f deploy/upstream/manifests/latest/
```
Refer to [Install document](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/Documentation/install/install.md) for details.

### Deploy Marketplace Operator

```
$ git clone https://github.com/operator-framework/operator-marketplace.git
$ kubectl apply -f deploy/upstream
```
Refer to [README.md](https://github.com/operator-framework/operator-marketplace/blob/master/README.md) for details.


## Workflow

1. Operator developer prepares all [CSV](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/Documentation/design/building-your-csv.md), CRD, and Package yamls.
2. Operator developer uses [```operator-courier```](https://github.com/operator-framework/operator-courier/#usage) to verify and push operator bundle to the Quay application repository.
3. Cluster admin creates [```OperatorSource```](https://github.com/operator-framework/operator-marketplace#description) CR to add the operator source into cluster. (All operators under the same Quay namespace share the same ```OperatorSource```)
4. Cluster admin creates [```CatalogSourceConfig```](https://github.com/operator-framework/operator-marketplace/blob/master/README.md#description) to enable selected operators in ```OperatorSource``` to ```CatalogSource```
5. Cluster admin creates [```OperatorGroup```](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/Documentation/design/operatorgroups.md) for target namespaces where operators are going to be installed into.
6. Cluster admin creates ```Subscription``` to subscribe operators.
7. *Catalog Operator* will reconcile to ```Subscription``` and create ```InstallPlan```.
8. *Catalog Operator* will reconcile to ```InstallPlan``` and create corresponding ```ClusterServiceVersion```.
9. *OLM Operator* reconciles to ```ClusterServiceVersion``` and make operators started.
10. User creates CRs defined by operators to create services.
