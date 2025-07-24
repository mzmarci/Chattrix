resource "aws_eks_fargate_profile" "eks_fg_profile" { 
cluster_name           = var.eks_cluster_name
fargate_profile_name   = "eks_fargate_profile"
pod_execution_role_arn = var.fargate_profile_role
selector {
    namespace = "kube-system"
    #can further filter by labels
}
selector {
    namespace = "default"
}
#these subnets must be labeled with kubernetes.io/cluster/{cluster-name} = owned
subnet_ids             = var.private_subnets_id

//depends_on = var.fargate-execution-policy

}