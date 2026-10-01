# Networking

The repository does not hard-code the home LAN because it must be adapted to the actual environment.

## Address plan

Fill this table before creating infrastructure:

| Purpose | Value |
|---|---|
| LAN CIDR | TBD |
| Default gateway | TBD |
| DNS server | TBD |
| Proxmox host | TBD |
| k8s-cp01 | TBD |
| k8s-w01 | TBD |
| k8s-w02 | TBD |
| LoadBalancer pool | TBD |
| Kubernetes Pod CIDR | TBD |
| Kubernetes Service CIDR | TBD |

## Rules

1. VM addresses should be stable.
2. The Kubernetes Pod CIDR must not overlap the LAN.
3. The Kubernetes Service CIDR must not overlap the LAN or Pod CIDR.
4. A LoadBalancer address pool must be outside the DHCP allocation range or explicitly reserved.
5. Management endpoints should not be unnecessarily exposed to the Internet.

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
