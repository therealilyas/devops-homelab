# OpenTofu — Proxmox

This directory provisions the first Kubernetes VMs on the `pve` node.

## Current mapping

| Resource | Value |
|---|---|
| Proxmox node | `pve` |
| API endpoint | `https://192.168.1.107:8006/` |
| Cloud image datastore | `local` — `import` content type confirmed |
| VM disk datastore | `local-lvm` |
| Bridge | `vmbr0` |
| Control plane VM ID | `201` |
| Worker 1 VM ID | `202` |
| Worker 2 VM ID | `203` |

## Credentials

Credentials are never stored in Git.

Use environment variables:

```bash
export PROXMOX_VE_API_TOKEN='terraform@pve!homelab=REDACTED'
```

The endpoint is configured in code because it is not secret.

## Local variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit the three node addresses only after confirming they do not overlap the router DHCP pool.

Add your **public** SSH key to `terraform.tfvars`.

## Commands

```bash
tofu init
tofu fmt -recursive
tofu validate
tofu plan
tofu apply
```

Storage import capability is confirmed on `local`.

Do not run `tofu apply` until the Proxmox API identity, SSH public key and static addresses have been verified.
