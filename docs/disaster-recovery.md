# Disaster Recovery

A backup is considered useful only after a successful restore has been demonstrated.

## Recovery objectives

RTO and RPO will be measured after the first end-to-end recovery exercise rather than invented in advance.

| Objective | Initial target | Measured |
|---|---|---|
| RTO | TBD | TBD |
| RPO | TBD | TBD |

## What must eventually be recoverable

- infrastructure definitions
- Ansible configuration
- Kubernetes desired state
- Git repositories
- persistent application data
- database data
- required secret material
- operational documentation

## Recovery model

```text
Git repository
     |
     v
OpenTofu
     |
     v
Proxmox VMs
     |
     v
Ansible
     |
     v
Kubernetes
     |
     v
GitOps
     |
     v
Platform + Applications
     |
     v
Persistent-data restore
```

## First DR exercise

After Milestone 1:

1. Verify all infrastructure code is committed.
2. Record the current cluster state.
3. Destroy the Kubernetes VMs through OpenTofu.
4. Recreate them.
5. Re-run Ansible.
6. Bootstrap Kubernetes.
7. Reinstall Cilium.
8. Verify the smoke-test application.
9. Record recovery duration and failures encountered.

Later milestones will automate more of this path.
