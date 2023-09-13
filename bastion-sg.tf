# Internal alb Security Group
resource "aws_security_group" "bastion-sg" {
  name = "bastion-sg"
  description = "Bastion SG"
  vpc_id = aws_vpc.main.id
 
  tags = {
    Name        = "bastion-sg"
  }
}
 

# security group rules
 resource "aws_security_group_rule" "allow_ssh_access_from_ipaddress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["172.30.240.1/32"]
  security_group_id = aws_security_group.bastion-sg.id
}

 resource "aws_security_group_rule" "allow_ssh_access_from_ipaddress_engineers" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["192.168.215.25/32"]
  security_group_id = aws_security_group.bastion-sg.id
}

resource "aws_security_group_rule" "public_out_bastion" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.bastion-sg.id
}
 
 

 