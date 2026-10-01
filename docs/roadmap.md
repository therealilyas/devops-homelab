# Roadmap

The project is built in layers. A milestone is complete only when its core failure and rebuild scenarios are tested.

## M1 — Infrastructure and Kubernetes

**Outcome:** a Kubernetes cluster that can be destroyed and reconstructed from code.

1. Proxmox cloud-init template
2. Least-privilege API token
3. OpenTofu provider configuration
4. Reusable VM module
5. Control-plane VM
6. Worker VMs
7. Ansible inventory
8. Linux baseline role
9. containerd
10. Kubernetes prerequisites
11. kubeadm bootstrap
12. Cilium
13. Smoke-test workload
14. Full destroy/rebuild test

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
