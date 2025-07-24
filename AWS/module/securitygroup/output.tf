
output "alb_security_group_id" {
  value = aws_security_group.lb_security_group.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}


