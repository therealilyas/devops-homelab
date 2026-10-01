# Networking

## Current host network

| Purpose | Value |
|---|---|
| LAN CIDR | `192.168.1.0/24` |
| Default gateway | `192.168.1.1` |
| DHCP pool | `192.168.1.100-192.168.1.199` |
| Proxmox bridge | `vmbr0` |
| Proxmox host | `192.168.1.107/24` |
| k8s-cp01 | `192.168.1.201/24` |
| k8s-w01 | `192.168.1.202/24` |
| k8s-w02 | `192.168.1.203/24` |
| Planned LoadBalancer pool | `192.168.1.210-192.168.1.219` |
| Kubernetes Pod CIDR | TBD |
| Kubernetes Service CIDR | TBD |

## Important DHCP note

The Proxmox host currently uses `192.168.1.107`, which is **inside the router DHCP pool** (`192.168.1.100-199`).

Before relying on this address long term, reserve `192.168.1.107` for the Proxmox NIC in the router, or later move the Proxmox host to a static address outside the DHCP pool. Do not casually change the Proxmox management address during active work because it can interrupt access.

The Kubernetes node addresses `.201-.203` and planned LoadBalancer addresses `.210-.219` are intentionally outside the DHCP pool.

## Planned Kubernetes networks

The node network is the home LAN. Pod and Service CIDRs will use private, non-overlapping networks.

A likely layout is:

```text
Home LAN       192.168.1.0/24
Node IPs       192.168.1.201-203
LoadBalancers  192.168.1.210-219
Pod network    non-overlapping private CIDR
Service CIDR   non-overlapping private CIDR
```

Cilium will own pod networking after kubeadm initializes the cluster.

## Rules

1. VM addresses must be stable and outside the DHCP pool unless explicitly reserved.
2. The Kubernetes Pod CIDR must not overlap the LAN.
3. The Kubernetes Service CIDR must not overlap the LAN or Pod CIDR.
4. The LoadBalancer pool must remain outside DHCP allocation and must be checked for existing static devices.
5. Management endpoints should not be unnecessarily exposed to the Internet.
6. Verify addresses are unused before provisioning.

## Troubleshooting model

Debug networking layer by layer:

```text
NIC
 |
IP address
 |
route
 |
ARP / neighbor
 |
DNS
 |
TCP / UDP
 |
TLS
 |
Kubernetes Service
 |
Ingress / Gateway
 |
Application
```

Useful commands include:

```bash
ip addr
ip route
ip neigh
ss -lntup
dig
curl
nc
tcpdump
kubectl get svc -A
kubectl get endpoints -A
```

A future milestone will add explicit network segmentation and Cilium NetworkPolicy.
