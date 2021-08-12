variable "region" {
  type    = string
  default = "eu-west-1"
}
variable "project_name" {
  type    = string
  default = "satispay"
}
variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmDTnP41WtJfYPdx3dQiVXip4oCL+lMGg2EeqCyA7V+qraIKkJ3cc4mhLsmsRvj70Wx5wXG+6Cu9qGalbDWzsoPn+6jMyzAnWvfW9U+4XPK2DL6LMrccGEpapgLrvDhqKHGnTbPpddlefuJYto9dizJEsBaQ+V+XgCjGBfcRli3GfAY+JbErKUw5UBW7sz2p7Jy9ahs9aYxqBqZnkuI8z+h8sUxuIDE8aNlO8vlOFdmuARRmVhKQ6i5ZN6GowS1iio/7+56lias737t3z0xKNQaAEQHmfhCMCNAvqFQhwppZHf8V8U1U6rwhCzlxGkSWzdIM2xKvSJhdiNKauMmL/7GtBcuzgAJumYM1FLYdHsaoWCNQSOjbd7RxwR4q7weoUo9v/fPMIms/QqY8/sVUjx36NSCsDjkbB8W3vN2fvrS53WQZm1oMr1ORZVAWL781sjavA18cSxfmQqYPPQbHB+0BPOGLxvYlGFGkBj4811+K30lXrC0QFgc7+u+geG9pM= dacremam@dacrema-apple"
}
variable "home_ip" {
  type    = string
  default = "93.46.107.59/32"
}
variable "private_cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}
variable "private_subnet_count" {
  type    = string
  default = 3
}
variable "availability_zones" {
  type    = list(any)
  default = ["a", "b", "c"]
}