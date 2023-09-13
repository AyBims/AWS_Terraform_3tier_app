resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  vpc_id      = aws_vpc.main.id
  description = "Nginx SG"


  tags = {
    Name            = "nginx-sg"
  }

}


resource "aws_security_group_rule" "allow_port80_from_ext_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.external-alb-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}


resource "aws_security_group_rule" "allow_port443_from_ext_alb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.external-alb-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}

# Add this later 

resource "aws_security_group_rule" "inbound-bastion-ssh-to-nginx" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}


resource "aws_security_group_rule" "allow_all_nginx_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx-sg.id
}

