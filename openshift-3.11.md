---
layout: page
title: Openshift 3.11
parent: installation.md
weight: 2
---

## Environment

- rhel-server-7.6-x86_64-dvd.iso
- Bare-metal machine x1

## Reference

- https://docs.okd.io/latest/install/index.html

## Deployment

### Ensuring host access

1. Generate an SSH key on the host you run the installation playbook on:
```
# ssh-keygen
```

2. Distribute the key to localhost
```
# ssh-copy-id -i ~/.ssh/id_rsa.pub localhost
```

### Installing base packages

1. Install the following base packages:
```
# yum install wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
```

2. (install with RPM-based installer) Install Ansible. To use EPEL as a package source for Ansible.
    1. Install the EPEL repository:
    ```
     # yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    ```

    2. Disable the EPEL repository globally so that it is not accidentally used during later steps of the installation:
    ```
    # sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
    ```

    3. Install the packages for Ansible:
    ```
    # yum -y --enablerepo=epel install ansible pyOpenSSL
    ```

3. Clone the openshift/openshift-ansible repository from GitHub, which provides the required playbooks and configuration files:
```
# cd ~
# git clone https://github.com/openshift/openshift-ansible
# cd openshift-ansible
# git checkout release-3.11
```

### Installing Docker

1. Install Docker 1.13:
```
# subscription-manager repos --enable=rhel-7-server-extras-rpms
# yum install docker-1.13.1
# systemctl start docker
```

2. Verify that version 1.13 was installed:
```
# rpm -V docker-1.13.1
# docker version
```

### Installing OKD (Running the RPM-based installer)

1. Change to the playbook directory and run the prerequisites.yml playbook. This playbook installs required software packages, if any, and modifies the container runtimes. Unless you need to configure the container runtimes, run this playbook only once, before you deploy a cluster the first time:
```
# cd /root/openshift-ansible
# ansible-playbook -i inventory/hosts.localhost playbooks/prerequisites.yml
```

2. Initiate the cluster installation:
```
# ansible-playbook -i inventory/hosts.localhost playbooks/deploy_cluster.yml
```

> **Note:** add the following directives for using hostname other than localhost  
openshift_master_cluster_hostname=ocp-internal.\<ip\>.nip.io  
openshift_master_cluster_public_hostname=ocp-public.\<ip\>.nip.io  
openshift_master_default_subdomain=apps.\<ip\>.nip.io  

### Verifying the Installation

1. Verify that the master is started and nodes are registered and reporting in Ready status. On the master host, run the following command as root:
```
# oc get nodes
NAME                    STATUS    ROLES                  AGE       VERSION
localhost.localdomain   Ready     compute,infra,master   14m       v1.11.0+d4cacc0
```

2. To verify that the web console is installed correctly, use the master host name and the web console port number to access the web console with a web browser.

For example, for a master host with a host name of localhost and using the default port of 8443, the web console URL is https://localhost:8443/console.

### Uninstalling an OKD cluster

To uninstall OKD across all hosts in your cluster, change to the playbook directory and run the playbook using the inventory file you used most recently:
```
# ansible-playbook -i inventory/hosts.localhost playbooks/adhoc/uninstall.yml
```

