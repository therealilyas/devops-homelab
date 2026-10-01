variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint."
  type        = string
  default     = "https://192.168.1.107:8006/"
}

variable "proxmox_insecure" {
  description = "Allow the Proxmox self-signed TLS certificate in the homelab."
  type        = bool
  default     = true
}

variable "proxmox_node_name" {
  description = "Target Proxmox node."
  type        = string
  default     = "pve"
}

variable "image_datastore_id" {
  description = "Datastore used for the Ubuntu cloud image."
  type        = string
  default     = "local"
}

variable "vm_datastore_id" {
  description = "Datastore used for VM disks."
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  description = "Proxmox Linux bridge used by Kubernetes VMs."
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "LAN default gateway."
  type        = string
  default     = "192.168.1.1"
}

variable "admin_username" {
  description = "Cloud-init administrative username."
  type        = string
  default     = "devops"
}

variable "ssh_public_key" {
  description = "SSH public key installed by cloud-init."
  type        = string
}

variable "k8s_cp01_ipv4" {
  description = "Static IPv4/CIDR for k8s-cp01, e.g. 192.168.1.201/24."
  type        = string
}

variable "k8s_w01_ipv4" {
  description = "Static IPv4/CIDR for k8s-w01."
  type        = string
}

variable "k8s_w02_ipv4" {
  description = "Static IPv4/CIDR for k8s-w02."
  type        = string
}
