
module "mainvpc" {
  source               = "./module/network"
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_cidr             = var.vpc_cidr

}

module "Bastion" { # this is used to connect to our eks cluster cos our eks cluster is in private cluster and private endpoint is enabled.And all the nodes including the control plane resides in the private subnet 
  source                 = "./module/ec2"
  ec2_ami                = var.ec2_ami
  ec2_instance_type      = var.ec2_instance_type1 == "dev" ? "t2.micro" : "t2.small"
  ec2_key_name           = var.ec2_key_name == "prod" ? "test100" : "assign1"
  vpc_security_group_ids = [module.security_group.bastion_security_group_id]
  public_subnets_id      = module.mainvpc.public_subnets_id[*]
  user_data              = file("npm.sh")

  root_block_device = {
    volume_size = 33
    volume_type = "gp3"
  }

}

module "security_group" {
  source = "./module/securitygroup"
  vpc_id = module.mainvpc.vpc_id
}

module "load_balancer" {
  source                    = "./module/alb"
  frontend_target_group_arn = module.load_balancer.frontend_target_group_arn
  vpc_id                    = module.mainvpc.vpc_id
  public_subnets_id         = module.mainvpc.public_subnets_id
  private_subnets_id        = module.mainvpc.private_subnets_id
  alb_security_group_id     = [module.security_group.alb_security_group_id]
  ami_id                    = var.ec2_ami
  instance_type             = var.ec2_instance_type
}

module "iam" {
  source = "./module/IAM"
}

module "Fargate" {
  source                   = "./module/fargate"
  eks_cluster_name         = module.eks.eks_cluster_name
  fargate_profile_role     = module.iam.eks_fargate_profile_role
  fargate_execution_policy = module.iam.fargate_execution_policy
  private_subnets_id       = module.mainvpc.private_subnets_id

  depends_on = [module.eks]
}

module "eks" {
  source                                  = "./module/eks"
  eks_cluster_role                        = module.iam.eks_cluster_role
  public_subnets_id                       = module.mainvpc.public_subnets_id
  private_subnets_id                      = module.mainvpc.private_subnets_id
  cluster_security_group_additional_rules = var.cluster_security_group_additional_rules
  cluster_addons                          = var.cluster_addons
  terraform_access_role                   = module.iam.terraform_access_role
  //eks_cluster_policy = module.iam.eks_cluster_policy

  depends_on = [module.iam]

}


module "node" {
  source                    = "./module/node"
  cluster_name              = module.eks.eks_cluster_name
  node_role_arn             = module.iam.eks_node_role
  WorkerNodePolicy          = module.iam.WorkerNodePolicy
  AmazonEKS_CNI_Policy      = module.iam.AmazonEKS_CNI_Policy
  ContainerRegistryReadOnly = module.iam.ContainerRegistryReadOnly
  private_subnets_id        = module.mainvpc.private_subnets_id
  vpc_id                    = module.mainvpc.vpc_id

  depends_on = [module.Fargate]
}