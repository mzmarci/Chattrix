variable "cluster_name" {
  type = string
  default = "azurecluster"
}

variable "location" {
  description = "location "
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  type = string
}


variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
  default = "ak8s"
}

variable "node_pool_name" {
  type        = string
  default     = "nodepool1"
  description = "Default node pool name"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Number of nodes in the default node pool"
}

variable "vm_size" {
  type        = string
  default     = "standard_a4m_v2"
  description = "VM size for the node pool"
}
