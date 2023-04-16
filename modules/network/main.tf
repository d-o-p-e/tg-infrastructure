resource "aws_vpc" "dope_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "dope-${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "dope_internet_gw" {
  vpc_id = aws_vpc.dope_vpc.id

  depends_on = [
    aws_vpc.dope_vpc
  ]

  tags = {
    Name = "dope-${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dope_vpc.id

  depends_on = [
    aws_vpc.dope_vpc,
    aws_internet_gateway.dope_internet_gw
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dope_internet_gw.id
  }

  tags = {
    Name = "route-table"
    Environment = var.environment
  }
}

resource "aws_route" "IG_route" {

  depends_on = [
    aws_route_table.public_route_table
  ]

  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.dope_internet_gw.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.dope_vpc.id
  count = length(var.public_subnets_cidr)
  cidr_block = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "dope-${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_subnet_association" {

  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.public_route_table
  ]
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_security_group" "dope_default_sg" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to alllow traffic to/from the VPC"
  vpc_id      = aws_vpc.dope_vpc.id
  depends_on = [
    aws_vpc.dope_vpc
  ]

  ingress {
    description = "all incoming traffic"
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    description = "all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "dope-${var.environment}-default-sg"
    Environment = var.environment
  }
}