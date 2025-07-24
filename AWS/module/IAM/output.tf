output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_fargate_profile_role" {
  value = aws_iam_role.eks_fargate_profile_role.arn
}

output "eks_node_role" {
  value = aws_iam_role.eks_node_role.arn
}

output "fargate_execution_policy" {
  value = aws_iam_role.eks_fargate_profile_role.name
}

output "eks_cluster_policy" {
  value = aws_iam_role.eks_cluster_role.name
}

output "WorkerNodePolicy" {
  value = aws_iam_role.eks_node_role.name
}

output "AmazonEKS_CNI_Policy" {
  value = aws_iam_role.eks_node_role.name
}

output "ContainerRegistryReadOnly" {
  value = aws_iam_role.eks_node_role.name
}

output "terraform_access_role" {
  value = aws_iam_role.terraform_access_role.arn
}