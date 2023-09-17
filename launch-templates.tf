# launch template for bastion

resource "aws_launch_template" "bastion-launch-template" {
  name = "bastion"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-026ebd4cfe2c043b2"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name            = "bastion-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/bastion.sh")
}




# Nginx Launch Template

resource "aws_launch_template" "nginx-launch-template" {
  name = "nginx"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-026ebd4cfe2c043b2"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name            = "nginx-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/nginx.sh")
}



# Tooling Launch Template
resource "aws_launch_template" "tooling-launch-template" {
  name = "tooling"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-026ebd4cfe2c043b2"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.tooling-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name            = "tooling-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/tooling.sh")
}


# Wordpress Launch Template
resource "aws_launch_template" "wordpress-launch-template" {
  name = "wordpress"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-026ebd4cfe2c043b2"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.wordpress-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name            = "wordpress-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/wordpress.sh")
}