data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
}
resource "aws_key_pair" "this" {
  key_name   = "satispay-lab"
  public_key = var.public_key
}
module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-sg"
  description = "HTTP SG"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = local.home_ip
    },
  ]
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]
  tags         = local.tags_as_map

}
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name = "${local.name}-asg"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.public_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  #   instance_refresh = {
  #     strategy = "Rolling"
  #     preferences = {
  #       min_healthy_percentage = 50
  #     }
  #     triggers = ["tag"]
  #   }

  # Launch template
  lt_name                = "${local.name}-asg"
  description            = "${local.name} launch template"
  update_default_version = true

  use_lt    = true
  create_lt = true

  image_id                 = data.aws_ami.amazon_linux.id
  instance_type            = "t2.micro"
  user_data_base64         = base64encode(local.user_data)
  ebs_optimized            = false
  enable_monitoring        = false
  iam_instance_profile_arn = aws_iam_instance_profile.this.arn
  target_group_arns        = module.alb.target_group_arns
  key_name                 = aws_key_pair.this.key_name


  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/sdb"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
    }
  ]

  network_interfaces = [
    {
      delete_on_termination       = true
      description                 = "eth0"
      device_index                = 0
      security_groups             = [module.asg_sg.security_group_id]
      associate_public_ip_address = true
    }
  ]

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    }
  ]

  tags = local.tags

  tags_as_map = local.tags_as_map
}