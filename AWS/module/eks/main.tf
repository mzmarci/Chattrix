resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = var.eks_cluster_role
    vpc_config {
    endpoint_private_access = true  //this means that my worker node will join the cluster interally within the vpc andthey wont get routed out of the vpc
    endpoint_public_access = false  //this means that i dont want my cluster to be accessed outside the vpc
    //control_plane_subnet_ids = var.private_subnets_id
    subnet_ids = concat(var.private_subnets_id, var.public_subnets_id)  # Use concat() to combine both the public and the private subnet into a single list
    # cluster_security_group_additional_rules = var.cluster_security_group_additional_rules
    # cluster_addons                   = var.cluster_addons
    }
    access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
    }

    bootstrap_self_managed_addons = true
    
    tags = var.tags
    version = var.eks_version
    upgrade_policy {
    support_type = "STANDARD"
    }
    //depends_on = var.eks_cluster_policy

}

resource "aws_eks_access_entry" "terraform_access" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = var.terraform_access_role
}

# # Configure credentials to assume that user/role.Run kubectl or helm commands using the cluster kubeconfig.
# resource "aws_eks_access_entry" "terraform_access" {  # This grants cluster access to the IAM user terraform with the AmazonEKSClusterAdminPolicy. 
#   cluster_name  = aws_eks_cluster.eks_cluster.name     
#   principal_arn = "arn:aws:iam::723855297198:user/terraform"
# }

# resource "aws_eks_access_policy_association" "terraform_admin_policy" {
#   cluster_name  = aws_eks_cluster.eks_cluster.name
#   principal_arn = aws_eks_access_entry.terraform_access.principal_arn
#   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

#   access_scope {
#     type = "cluster"
#   }
# }

