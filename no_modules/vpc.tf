resource "aws_vpc" "this" {
  cidr_block           = var.private_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.project_name
  }

}
resource "aws_subnet" "this" {
  count             = length(var.availability_zones)
  cidr_block        = cidrsubnet(var.private_cidr_block, 8, count.index)
  vpc_id            = aws_vpc.this.id
  availability_zone = "${var.region}${var.availability_zones[count.index]}"
  tags = {
    Name = "public-subnet-${var.region}${var.availability_zones[count.index]}"
  }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.this.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]

  tags = {
    Name = "${var.project_name}-public"
  }
}
resource "aws_route_table_association" "this" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}