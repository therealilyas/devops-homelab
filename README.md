# DevOps Homelab

A production-minded **DevOps / SRE / Platform Engineering homelab** built on Proxmox and designed to be reproducible from Git.

> Goal: learn and demonstrate the engineering practices expected in real DevOps/SRE work — Infrastructure as Code, configuration management, Kubernetes, GitOps, observability, security, reliability engineering, and disaster recovery.

## Architecture

```text
GitHub
  |
  +--> OpenTofu ------> Proxmox VMs
  |                       |
  +--> Ansible ----------> Linux baseline
                          |
                          +--> k8s-cp01
                          +--> k8s-w01
                          +--> k8s-w02
                                   |
                              Kubernetes
                                   |
                                Cilium
```

The first milestone deliberately stays small. CI/CD, GitOps, observability and security are added only after the cluster can be created, destroyed and rebuilt reliably.

## Principles

- **Everything possible is defined as code.**
- **Rebuild, don't hand-repair.**
- **Git is the source of truth.**
- **No secrets are committed to the repository.**
- **Automation must be idempotent.**
- **Every major failure scenario gets a runbook.**
- **Backups are not considered valid until restore is tested.**
- **A single physical Proxmox host is not claimed as true HA.**

## Target stack

| Layer | Technology |
|---|---|
| Hypervisor | Proxmox VE |
| Linux | Ubuntu Server LTS |
| Infrastructure as Code | OpenTofu |
| Configuration Management | Ansible |
| Container Runtime | containerd |
| Kubernetes Bootstrap | kubeadm |
| Kubernetes Networking | Cilium |
| Package Management | Helm |
| GitOps | Argo CD |
| Metrics | Prometheus |
| Dashboards | Grafana |
| Logs | Loki + Grafana Alloy |
| Tracing | OpenTelemetry + Tempo |
| Security Scanning | Trivy |
| Policy | Kyverno |
| Runtime Security | Falco |
| Secrets | SOPS + age |
| Load Testing | k6 |

## Roadmap

### Milestone 1 — Reproducible Kubernetes foundation

- [x] Create public GitHub repository
- [x] Establish architecture and engineering standards
- [ ] Create Ubuntu cloud-init template in Proxmox
- [ ] Create least-privilege Proxmox API credentials
- [ ] Configure OpenTofu provider
- [ ] Build reusable Proxmox VM module
- [ ] Provision `k8s-cp01`
- [ ] Provision `k8s-w01`
- [ ] Provision `k8s-w02`
- [ ] Configure nodes with Ansible
- [ ] Install containerd
- [ ] Bootstrap Kubernetes with kubeadm
- [ ] Install Cilium
- [ ] Deploy and verify a demo workload
- [ ] Destroy and rebuild the cluster from Git

### Milestone 2 — Delivery platform

- [ ] Helm
- [ ] CI pipeline
- [ ] Container registry
- [ ] Argo CD
- [ ] GitOps environments
- [ ] Automated deployment and rollback

### Milestone 3 — Observability & SRE

- [ ] Prometheus
- [ ] Grafana
- [ ] Loki + Alloy
- [ ] OpenTelemetry + Tempo
- [ ] Alertmanager
- [ ] SLIs / SLOs / error budgets
- [ ] Load testing

### Milestone 4 — DevSecOps

- [ ] Trivy
- [ ] SBOM generation
- [ ] SOPS + age
- [ ] Kyverno
- [ ] Network policies
- [ ] Falco
- [ ] RBAC hardening

### Milestone 5 — Resilience

- [ ] Backup and restore
- [ ] Disaster recovery
- [ ] Chaos experiments
- [ ] Incident runbooks
- [ ] RTO / RPO validation

## Repository layout

```text
.
├── infrastructure/       # OpenTofu / Proxmox
├── ansible/              # OS and Kubernetes node configuration
├── kubernetes/           # Cluster-level manifests
├── platform/             # GitOps, observability, security platform services
├── gitops/               # Desired state for environments
├── apps/                 # Demo workloads
├── docs/                 # Architecture, networking, security and runbooks
├── scripts/              # Small automation helpers
└── .github/              # Repository automation and contribution workflow
```

Directories are introduced as the corresponding milestone is implemented rather than filled with fake placeholder infrastructure.

## Current phase

**Phase 1: Proxmox → OpenTofu**

The next engineering task is to create a cloud-init-ready Ubuntu template and provision the first VM through OpenTofu.

## Security

Never commit:

- Proxmox API secrets
- SSH private keys
- kubeconfig files
- passwords
- tokens
- `.env` files
- unencrypted application secrets

See [docs/security.md](docs/security.md).

## Documentation

- [Architecture](docs/architecture.md)
- [Roadmap](docs/roadmap.md)
- [Networking](docs/networking.md)
- [Security](docs/security.md)
- [Disaster Recovery](docs/disaster-recovery.md)

## Status

🚧 **Actively being built from zero.**

The emphasis is on understanding and reproducibility rather than installing as many tools as possible.
