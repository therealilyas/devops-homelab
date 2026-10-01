# Networking

## Current host network

| Purpose | Value |
|---|---|
| LAN CIDR | `192.168.1.0/24` |
| Default gateway | `192.168.1.1` |
| Proxmox bridge | `vmbr0` |
| Proxmox host | `192.168.1.107/24` |
| k8s-cp01 | TBD |
| k8s-w01 | TBD |
| k8s-w02 | TBD |
| LoadBalancer pool | TBD |
| Kubernetes Pod CIDR | TBD |
| Kubernetes Service CIDR | TBD |

The VM and LoadBalancer addresses will be selected only after the DHCP allocation range is confirmed, to avoid address conflicts.

## Planned Kubernetes networks

The exact values will be finalized before cluster bootstrap. They must not overlap the home LAN.

A likely layout is:

```text
Home LAN       192.168.1.0/24
Pod network    non-overlapping private CIDR
Service CIDR   non-overlapping private CIDR
```

Cilium will own pod networking after kubeadm initializes the cluster.

## Rules

1. VM addresses should be stable.
2. The Kubernetes Pod CIDR must not overlap the LAN.
3. The Kubernetes Service CIDR must not overlap the LAN or Pod CIDR.
4. A LoadBalancer address pool must be outside the DHCP allocation range or explicitly reserved.
5. Management endpoints should not be unnecessarily exposed to the Internet.
6. Do not guess unused static addresses; verify the router DHCP pool first.

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
