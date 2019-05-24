---
layout: page
title: Openshift 3.9
parent: installation.md
weight: 2
---

## Environment

- rhel-server-7.6-x86_64-dvd.iso
- Bare-metal machine x1

## Reference

- https://docs.okd.io/3.9/install_config/index.html

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
# yum -y install wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
```

2. (install with RPM-based installer) Install Ansible. To use EPEL as a package source for Ansible.
    1. download ansible 2.4.3.0 from https://releases.ansible.com/ansible/
    ```
    # wget https://releases.ansible.com/ansible/ansible-2.4.3.0.tar.gz
    ```
    2. Install ansible 2.4.3.0
    ```
    # tar zxvf ansible-2.4.3.0.tar.gz
    # cd ansible-2.4.3.0/
    # python setup.py install
    ```

3. Clone the openshift/openshift-ansible repository from GitHub, which provides the required playbooks and configuration files:
```
# cd ~
# git clone -b release-3.9 --single-branch https://github.com/openshift/openshift-ansible
# cd openshift-ansible
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
openshift_master_cluster_hostname=okd-internal.\<ip\>.nip.io  
openshift_master_cluster_public_hostname=okd-public.\<ip\>.nip.io  
openshift_master_default_subdomain=apps.\<ip\>.nip.io  

### Verifying the Installation

1. Verify that the master is started and nodes are registered and reporting in Ready status. On the master host, run the following command as root:
```
# oc get nodes
NAME                    STATUS    ROLES                  AGE       VERSION
localhost.localdomain   Ready     compute,infra,master   14m       v1.9.1+a0ce1bc657
```

2. To verify that the web console is installed correctly, use the master host name and the web console port number to access the web console with a web browser.

For example, for a master host with a host name of localhost and using the default port of 8443, the web console URL is https://localhost:8443/console.

### Uninstalling an OKD cluster

To uninstall OKD across all hosts in your cluster, change to the playbook directory and run the playbook using the inventory file you used most recently:
```
# ansible-playbook -i inventory/hosts.localhost playbooks/adhoc/uninstall.yml
```

