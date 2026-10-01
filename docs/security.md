# Security Baseline

Security controls are introduced incrementally, but secrets hygiene starts on day one.

## Never commit

- passwords
- API tokens
- Proxmox credentials
- private SSH keys
- private TLS keys
- kubeconfig files
- cloud credentials
- plaintext application secrets
- SOPS/age private keys

## Proxmox

Use a dedicated API identity/token with the minimum privileges required by OpenTofu. Do not automate infrastructure with the Proxmox root password.

## SSH

Target state:

- key-based authentication
- root SSH login disabled
- password authentication disabled after key access is verified
- explicit administrative user
- least-privilege sudo

## Kubernetes

Later milestones will enforce:

- namespace-scoped RBAC
- non-root containers
- resource requests and limits
- no privileged containers by default
- approved image registries
- NetworkPolicy
- encrypted Git secrets
- vulnerability scanning
- runtime detection

## Secret-management roadmap

Development path:

```text
local environment variables
        |
        v
SOPS + age encrypted files
        |
        v
GitOps-compatible secret workflow
```

Plain Kubernetes Secret YAML containing real credentials must not be committed.
