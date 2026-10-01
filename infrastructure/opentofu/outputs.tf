output "k8s_nodes" {
  description = "Provisioned Kubernetes nodes."
  value = {
    k8s-cp01 = {
      vm_id = module.k8s_cp01.vm_id
      ip    = var.k8s_cp01_ipv4
    }
    k8s-w01 = {
      vm_id = module.k8s_w01.vm_id
      ip    = var.k8s_w01_ipv4
    }
    k8s-w02 = {
      vm_id = module.k8s_w02.vm_id
      ip    = var.k8s_w02_ipv4
    }
  }
}
