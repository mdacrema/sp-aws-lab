resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP only"
  vpc_id      = aws_vpc.this.id

  ingress = [
    {
      description      = "HTTP from Home"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["${var.home_ip}"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow egress to the world"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group" "ec2" {
  name        = "ec2-sg"
  description = "Allow HTTP only"
  vpc_id      = aws_vpc.this.id


  ingress = [
    {
      description      = "SSH from Home"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["${var.home_ip}"]
      security_groups  = [aws_security_group.alb.id]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow egress to the world"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "ec2-sg"
  }
}