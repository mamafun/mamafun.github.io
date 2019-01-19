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
# yum install docker-1.13.1
```

2. Verify that version 1.13 was installed:
```
# rpm -V docker-1.13.1
# docker version
```

