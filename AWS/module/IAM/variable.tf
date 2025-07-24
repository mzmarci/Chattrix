variable "cluster_name" {
    type = string
    default = "demo_eks_cluster"
}

variable "fargate_name" {
    type = string
    default = "eks_fargate_profile_role"
}

variable "worker_node" {
    type = string
    default = "eks_node_group_role"
}