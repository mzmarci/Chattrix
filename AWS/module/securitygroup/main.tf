resource "aws_security_group" "lb_security_group" {
  name        = "lb_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = var.vpc_id
 
  tags = {
    Name = "EKS load balancer secuirty group"
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}


# Security group for bastion host 
resource "aws_security_group" "bastion_sg" {   //frontend layer
  name        = "bastion_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = var.vpc_id

  tags = {
    Name = "EKS-bastion"
  }
}

resource "aws_security_group_rule" "bastion_ingress2" {
  security_group_id        = aws_security_group.bastion_sg.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]  # Open to internet
}

resource "aws_security_group_rule" "bastion_ingress" {
  security_group_id        = aws_security_group.bastion_sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_ingress1" {
  security_group_id        = aws_security_group.bastion_sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

}


resource "aws_security_group_rule" "bastion-egress-rule" {
  security_group_id = aws_security_group.bastion_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

}







