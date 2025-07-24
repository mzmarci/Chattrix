resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {    //Defines the VMs that will run your Kubernetes apps
    name       = var.node_pool_name    // Name of this pool
    node_count = var.node_count     // How many VMs
    vm_size    = var.vm_size      //The size of each VM
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    dns_service_ip    = "10.1.0.10"
    service_cidr      = "10.1.0.0/16"
  }

  tags = {
    Environment = "Dev"
  }
}
