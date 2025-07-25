
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "EKS-VPC"
  }
}

# Public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available_zones.names, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "EksPublic Subnet ${count.index + 1} "
  }
}

resource "aws_internet_gateway" "tierhub_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "Eks igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = " Eks Public RouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.tierhub_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id 
  route_table_id = aws_route_table.public_route_table.id
}


# NAT Gateway and Private Subnets
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "NAT EIP FOR EKS"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "NAT Gateway ${count.index + 1}"
  }
}

# Private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available_zones.names, count.index)
  map_public_ip_on_launch = false

  tags = { 
    Name    = "private-subnet ${count.index + 1}"  //always tag your kuberentes private subnet
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"    // owned → use this when the subnet is dedicated to a single EKS cluster, shared → use this when the subnet is used by multiple clusters.
  }
}

resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "Eks Private Route Table ${count.index + 1}"
  }
}

resource "aws_route" "private_route" {
  count                = length(var.private_subnet_cidrs)
  route_table_id       = aws_route_table.private_route_table[count.index].id
  nat_gateway_id       = aws_nat_gateway.nat_gateway[0].id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_route_association" {
  count       = length(var.private_subnet_cidrs)
  subnet_id   = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}