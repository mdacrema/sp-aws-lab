resource "aws_iam_role" "this" {
  name = var.project_name
  tags = {
    Name = "${var.project_name}-iam-role"
  }

  assume_role_policy = <<-EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOT
}
resource "aws_iam_instance_profile" "this" {
  name = var.project_name
  role = aws_iam_role.this.name
  tags = {
    Name = "${var.project_name}-iam-role"
  }
}
resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  description      = "Service linked role for autoscaling"
  custom_suffix    = var.project_name

  # Sometimes good sleep is required to have some IAM resources created before they can be used
  provisioner "local-exec" {
    command = "sleep 10"
  }
}