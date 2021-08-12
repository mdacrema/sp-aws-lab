resource "aws_launch_template" "this" {
  name = var.project_name

  block_device_mappings {
    device_name = "/dev/sdb"

    ebs {
      volume_size = 5
    }
  }

  image_id      = data.aws_ami.this.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.this.key_name
  monitoring {
    enabled = false
  }

  network_interfaces {
    delete_on_termination       = true
    description                 = "eth0"
    device_index                = 0
    security_groups             = [aws_security_group.ec2.id]
    associate_public_ip_address = true
  }

  placement {
    availability_zone = var.region
  }


  #   vpc_security_group_ids = [aws_security_group.ec2.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.project_name
    }
  }

  user_data = filebase64("${path.module}/scripts/userdata.sh")
}