# Roadmap

The project is built in layers. A milestone is complete only when its core failure and rebuild scenarios are tested.

## M1 — Infrastructure and Kubernetes

**Outcome:** a Kubernetes cluster that can be destroyed and reconstructed from code.

1. Confirm Proxmox storage supports cloud-image import
2. Least-privilege API token
3. OpenTofu provider configuration
4. Reusable VM module
5. Import Ubuntu cloud image through OpenTofu
6. Control-plane VM
7. Worker VMs
8. Ansible inventory
9. Linux baseline role
10. containerd
11. Kubernetes prerequisites
12. kubeadm bootstrap
13. Cilium
14. Smoke-test workload
15. Full destroy/rebuild test

### Exit criteria

- No VM needs to be manually created.
- Re-running Ansible is idempotent.
- All Kubernetes nodes become Ready.
- Pod-to-pod and service networking works.
- The cluster can be rebuilt using documented steps.

## M2 — CI/CD and GitOps

**Outcome:** a commit can safely reach Kubernetes without a manual deployment.

- Helm
- CI validation
- container build
- vulnerability scanning
- registry
- Argo CD
- environment promotion
- rollback

## M3 — Observability and SRE

**Outcome:** failures are detectable, diagnosable and tied to user-facing reliability.

- Prometheus
- Grafana
- Loki
- Grafana Alloy
- OpenTelemetry
- Tempo
- Alertmanager
- RED / USE dashboards
- SLIs
- SLOs
- error budgets
- burn-rate alerts
- k6 load tests

## M4 — DevSecOps

**Outcome:** security is enforced in delivery and runtime rather than documented only as policy.

- Trivy
- SBOM
- SOPS + age
- Kyverno
- RBAC
- Cilium network policies
- Falco
- supply-chain controls

## M5 — Resilience

**Outcome:** the platform has evidence-backed recovery procedures.

- backup
- restore validation
- disaster recovery
- RTO / RPO
- chaos scenarios
- incident reports
- operational runbooks

## Later extensions

After the core platform works:

- separate management/application VLANs
- multi-cluster GitOps
- dedicated storage
- external secrets
- policy testing
- image signing
- service mesh evaluation
- cloud mirror environment
- platform self-service / golden paths
