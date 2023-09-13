# Tooling
resource "aws_security_group" "tooling-sg" {
  name        = "tooling-sg"
  vpc_id      = aws_vpc.main.id
  description = "tooling SG"

  tags = {
    Name            = "tooling-sg"
  }
}


resource "aws_security_group_rule" "allow_HTTP_from_internal_alb_to_tooling" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.internal-alb-sg.id
  security_group_id        = aws_security_group.tooling-sg.id
}

resource "aws_security_group_rule" "inbound-bastion-ssh-to-tooling" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  security_group_id        = aws_security_group.tooling-sg.id
}

resource "aws_security_group_rule" "allow_all_tooling_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tooling-sg.id
}


# Wordpress
resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg"
  vpc_id      = aws_vpc.main.id
  description = "wordpress SG"


  tags = {
    Name            = "wordpress-sg"
  }

}

resource "aws_security_group_rule" "allow_HTTP_from_internal_alb_to_wordpress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.internal-alb-sg.id
  security_group_id        = aws_security_group.wordpress-sg.id
}

resource "aws_security_group_rule" "allow_all_wordpress_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpress-sg.id
}


# Datalayer
resource "aws_security_group" "datalayer-sg" {
  name        = "datalayer-sg"
  vpc_id      = aws_vpc.main.id
  description = "Datalayer SG"


  tags = {
    Name            = "datalayer-sg"
  }
}

resource "aws_security_group_rule" "allow_from_tooling_web_to_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}


resource "aws_security_group_rule" "allow_from_wordpress_web_to_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}



resource "aws_security_group_rule" "allow_from_tooling_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}


resource "aws_security_group_rule" "allow_from_wordpress_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}
