variable "eks_cluster_name" {
    type = string
   
}

variable "fargate_profile_role" {
    type = string
}

variable "private_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "fargate_execution_policy" {
  description = "fargate_execution_policy"
  type = string
}