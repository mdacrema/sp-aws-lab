data "aws_instance" "this" {

  filter {
    name   = "tag:Name"
    values = [var.project_name]
  }
  depends_on = [
    aws_autoscaling_group.this
  ]
}