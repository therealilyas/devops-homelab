# Architecture

## Objective

Build a small but production-minded DevOps/SRE platform that is reproducible from source control and can be explained component by component.

## Current physical host

| Item | Value |
|---|---|
| Platform | Lenovo ThinkCentre M75q-1 |
| Hypervisor | Proxmox VE 9.2.20 |
| Host OS | Debian GNU/Linux 13 (trixie) |
| Kernel | 7.0.14-17-pve |
| CPU | AMD Ryzen 5 PRO 3400GE |
| Architecture | x86-64 |
| Installed memory visible to host | ~13 GiB |
| Proxmox node name | `pve` |
| Proxmox bridge | `vmbr0` |

Sensitive machine identifiers are intentionally not stored in Git.

## Capacity strategy

This host is sufficient for a **lean three-node Kubernetes lab**, but memory is the primary constraint. The initial cluster will therefore avoid a separate operations VM and will not deploy the full observability/security stack until the Kubernetes foundation is stable.

Initial target:

| VM | Purpose | vCPU | RAM | Disk |
|---|---|---:|---:|---:|
| k8s-cp01 | Kubernetes control plane | 2 | 2.5 GiB | 25–30 GiB |
| k8s-w01 | Kubernetes worker | 2 | 2.5 GiB | 30 GiB |
| k8s-w02 | Kubernetes worker | 2 | 2.5 GiB | 30 GiB |

Total initial Kubernetes VM memory: ~7.5 GiB.

This deliberately leaves headroom for Proxmox and existing services. Resource allocations can be adjusted after observing real memory pressure.

## Physical layer

The initial environment intentionally uses one Proxmox host.

```text
                    Physical mini PC
                          |
                      Proxmox VE
                          |
          +---------------+---------------+
          |               |               |
      k8s-cp01         k8s-w01         k8s-w02
```

This is **not physical high availability**. Multiple Kubernetes VMs on one Proxmox node still share the same physical failure domain.

## Automation flow

```text
Git
 |
 +--> OpenTofu
 |       |
 |       +--> Proxmox API
 |               |
 |               +--> Virtual machines
 |
 +--> Ansible
         |
         +--> Linux baseline
         +--> containerd
         +--> Kubernetes prerequisites

kubeadm
   |
   +--> Kubernetes control plane + workers

Cilium
   |
   +--> Pod networking
   +--> Network policy
   +--> eBPF observability
```

## Desired end-state

```text
Developer
   |
 Git push
   |
   v
   CI
   |
 test / lint / scan / build
   |
   v
Container Registry
   |
   v
GitOps repository
   |
   v
Argo CD
   |
   v
Kubernetes
   |
   +--> Applications
   +--> Prometheus / Grafana
   +--> Loki / Alloy
   +--> OpenTelemetry / Tempo
   +--> Kyverno
   +--> Falco
```

## Design decisions

### kubeadm instead of a desktop Kubernetes distribution

The project uses kubeadm so the control plane, kubelet, runtime, CNI and node lifecycle are visible and must be understood.

### Cilium

Cilium provides Kubernetes networking while creating opportunities to learn eBPF, service networking, NetworkPolicy and network observability.

### GitOps

Manual `kubectl edit` is not the desired operational model. Application and platform state will eventually be reconciled from Git.

### Single physical host

Logical redundancy will be demonstrated where useful, but the project explicitly documents the single physical failure domain instead of calling it production HA.

### No dedicated ops VM initially

With ~13 GiB total host memory, a separate `ops01` VM would reduce useful Kubernetes capacity. OpenTofu/Ansible administration can initially run from an existing workstation or another suitable environment. A dedicated ops VM can be added later if memory is upgraded.
