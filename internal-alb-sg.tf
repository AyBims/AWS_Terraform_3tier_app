# Internal alb Security Group
resource "aws_security_group" "internal-alb" {
  name = "internal-alb-sg"
  description = "Internal ALB"
  vpc_id = aws_vpc.main.id
 
  tags = {
    Name        = "internal-alb-sg"
  }
}
 

# security group rules
 resource "aws_security_group_rule" "allow_nginx_port80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal-alb.id
}

 resource "aws_security_group_rule" "allow_nginx_port443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal-alb.id
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.internal-alb.id
}
 
 

 