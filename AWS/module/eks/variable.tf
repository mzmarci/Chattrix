variable "cluster_name" {
    type = string
    default = "demo_eks_cluster"
}

variable "eks_cluster_role" {
    type = string
}

# variable "eks_cluster_policy" {
#   type = list
# }

variable "private_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "public_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "tags" {
type = map(string)
default = {
    terraform  = "true"
    kubernetes = "eks-cluster"
}
description = "Tags to apply to all resources"
}

variable "eks_version" {
type = string
default = "1.31"
description = "EKS version"
}

variable "cluster_security_group_additional_rules" {}
variable "cluster_addons" {}

variable "terraform_access_role" {}