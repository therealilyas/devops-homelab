resource "proxmox_download_file" "ubuntu_noble_cloud_image" {
  content_type = "import"
  datastore_id = var.image_datastore_id
  node_name    = var.proxmox_node_name

  url       = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name = "noble-server-cloudimg-amd64.qcow2"

  overwrite = false
}

module "k8s_cp01" {
  source = "./modules/proxmox-vm"

  name           = "k8s-cp01"
  vm_id          = 201
  node_name      = var.proxmox_node_name
  datastore_id   = var.vm_datastore_id
  image_id       = proxmox_download_file.ubuntu_noble_cloud_image.id
  bridge         = var.bridge
  ipv4_address   = var.k8s_cp01_ipv4
  ipv4_gateway   = var.gateway
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
  cpu_cores      = 2
  memory_mb      = 2560
  disk_size_gb   = 25
}

module "k8s_w01" {
  source = "./modules/proxmox-vm"

  name           = "k8s-w01"
  vm_id          = 202
  node_name      = var.proxmox_node_name
  datastore_id   = var.vm_datastore_id
  image_id       = proxmox_download_file.ubuntu_noble_cloud_image.id
  bridge         = var.bridge
  ipv4_address   = var.k8s_w01_ipv4
  ipv4_gateway   = var.gateway
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
  cpu_cores      = 2
  memory_mb      = 2560
  disk_size_gb   = 30
}

module "k8s_w02" {
  source = "./modules/proxmox-vm"

  name           = "k8s-w02"
  vm_id          = 203
  node_name      = var.proxmox_node_name
  datastore_id   = var.vm_datastore_id
  image_id       = proxmox_download_file.ubuntu_noble_cloud_image.id
  bridge         = var.bridge
  ipv4_address   = var.k8s_w02_ipv4
  ipv4_gateway   = var.gateway
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
  cpu_cores      = 2
  memory_mb      = 2560
  disk_size_gb   = 30
}
