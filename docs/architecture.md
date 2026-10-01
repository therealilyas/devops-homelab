# Architecture

## Objective

Build a small but production-minded DevOps/SRE platform that is reproducible from source control and can be explained component by component.

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

## Initial VM plan

The exact resources depend on host capacity. A practical starting point is:

| VM | Purpose | vCPU | RAM |
|---|---|---:|---:|
| k8s-cp01 | Kubernetes control plane | 2 | 3–4 GB |
| k8s-w01 | Kubernetes worker | 2 | 3–6 GB |
| k8s-w02 | Kubernetes worker | 2 | 3–6 GB |

An optional `ops01` VM can later host administrative tooling, but it is not required for the first OpenTofu milestone.
