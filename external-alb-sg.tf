# external alb Security Group
resource "aws_security_group" "external-alb" {
  name = "external-alb-sg"
  description = "Public internet access"
  vpc_id = aws_vpc.main.id
 
  tags = {
    Name        = "external-alb-sg"
  }
}
 

# security group rules
 resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.external-alb.id
}
resource "aws_security_group_rule" "public_out_external_alb" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.external-alb.id
}
 
 

 