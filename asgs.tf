# Bastion ASG
resource "aws_autoscaling_group" "bastion-asg" {
  name                      = "bastion-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier = [
    aws_subnet.PublicSubnet-1.id,
    aws_subnet.PublicSubnet-2.id
  ]


  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "bastion"
    propagate_at_launch = true
  }

}


# Nginx ASG
resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier = [
    aws_subnet.PrivateSubnet-1.id,
    aws_subnet.PrivateSubnet-2.id
  ]


  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "nginx"
    propagate_at_launch = true
  }

}
