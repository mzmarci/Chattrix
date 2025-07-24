variable "node_role_arn" {
  type = string
}

variable "private_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

# variable "public_subnets_id" {
#   description = "List of Public Subnet IDs where ALB should be deployed"
#   type        = list(string)
# }

variable "vpc_id" {}

variable "WorkerNodePolicy" {
  type = string
}

variable "AmazonEKS_CNI_Policy" {
  type = string
}

variable "ContainerRegistryReadOnly" {
  type = string
}

variable "cluster_name" {
    type = string
   
}