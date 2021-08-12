resource "aws_autoscaling_group" "this" {
  name                      = "${var.project_name}-asg"
  max_size                  = 1
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  vpc_zone_identifier     = aws_subnet.this[*].id
  service_linked_role_arn = aws_iam_service_linked_role.autoscaling.arn
  target_group_arns       = [aws_lb_target_group.this.arn]
  #   initial_lifecycle_hook {
  #     name                 = "foobar"
  #     default_result       = "CONTINUE"
  #     heartbeat_timeout    = 2000
  #     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  #     notification_metadata = <<EOF
  # {
  #   "foo": "bar"
  # }
  # EOF

  #     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
  #     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  #   }

  #   tag {
  #     key                 = "foo"
  #     value               = "bar"
  #     propagate_at_launch = true
  #   }

  #   timeouts {
  #     delete = "15m"
  #   }

  #   tag {
  #     key                 = "lorem"
  #     value               = "ipsum"
  #     propagate_at_launch = false
  #   }
}