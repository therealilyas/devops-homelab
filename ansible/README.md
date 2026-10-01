# Ansible

Ansible configures the VMs provisioned by OpenTofu.

## Inventory

| Host | Address | Group |
|---|---|---|
| k8s-cp01 | 192.168.1.201 | k8s_control_plane |
| k8s-w01 | 192.168.1.202 | k8s_workers |
| k8s-w02 | 192.168.1.203 | k8s_workers |

The SSH user is `devops` and passwordless sudo is expected.

## 1. Connectivity

From this directory:

```bash
ansible all -m ping
```

Expected for every host:

```text
SUCCESS
"ping": "pong"
```

## 2. Preflight

```bash
ansible-playbook playbooks/preflight.yml
```

This validates:

- Ubuntu 24.04+
- at least 2 GiB RAM
- swap disabled
- expected node IPv4 address

## 3. Common baseline

```bash
ansible-playbook playbooks/site.yml
```

The role installs basic administrative packages, configures UTC, enables Chrony and QEMU guest agent, and adds the Kubernetes host mappings.

## 4. Idempotence test

Immediately run the same playbook again:

```bash
ansible-playbook playbooks/site.yml
```

The second run should finish with `changed=0` for all hosts.

This is an explicit Milestone 1 acceptance criterion.

## Next

After the common baseline passes the idempotence test, add the Kubernetes preparation role:

- kernel modules
- sysctl
- containerd
- Kubernetes package repository
- kubelet
- kubeadm
- kubectl
