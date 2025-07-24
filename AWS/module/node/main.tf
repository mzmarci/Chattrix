resource "aws_security_group" "node_group_remote_access" {  # created a remote access for the node group, so that one can ssh into it
  name        = "eks-node-remote-access"
  description = "Allow SSH access to EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider replacing with bastion IP
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_eks_node_group" "eks_demo_node_group" {
  cluster_name           = var.cluster_name
  node_role_arn   = var.node_role_arn
  node_group_name = "eks_node_group"
  subnet_ids = var.private_subnets_id
  instance_types  = ["t2.medium"]
  capacity_type   = "SPOT"
  disk_size       = 35

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = aws_key_pair.deployer.key_name
    source_security_group_ids = [aws_security_group.node_group_remote_access.id]
  }

  tags = {
    Name        = "eks-node-group"
    Environment = "production"
    Application = "my-app"
  }

# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
depends_on = [
    var.WorkerNodePolicy,
    var.AmazonEKS_CNI_Policy,
    var.ContainerRegistryReadOnly,
]
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
