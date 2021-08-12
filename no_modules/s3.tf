resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.project_name}-alb-logs"
  acl    = "private"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::156460612806:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.project_name}-alb-logs/${var.project_name}-alb/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.project_name}-alb-logs/${var.project_name}-alb/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.project_name}-alb-logs"
    }
  ]
}
POLICY
  tags = {
    Name = "${var.project_name}-alb-logs"
  }
}
