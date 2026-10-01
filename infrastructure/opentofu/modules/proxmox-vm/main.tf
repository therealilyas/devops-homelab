resource "proxmox_virtual_environment_vm" "this" {
  name        = var.name
  description = "Managed by OpenTofu - devops-homelab"
  tags        = ["homelab", "kubernetes", "opentofu"]

  node_name = var.node_name
  vm_id     = var.vm_id

  started         = true
  stop_on_destroy = true

  cpu {
    cores = var.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = var.image_id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size_gb
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      username = var.admin_username
      keys     = [trimspace(var.ssh_public_key)]
    }
  }

  network_device {
    bridge = var.bridge
    model  = "virtio"
  }

  operating_system {
    type = "l26"
  }
}
