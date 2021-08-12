resource "aws_key_pair" "this" {
  key_name   = "satispay-lab"
  public_key = var.public_key
}