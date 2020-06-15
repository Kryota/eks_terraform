# VPC
resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name                                = "vpc-${var.name}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  count             = length(var.subnet_azs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.subnet_azs, count.index)

  tags = {
    Name                                = "subnet-${var.name}-public-${count.index}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name      = "igw-${var.name}"
    Terraform = "true"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name      = "rt-${var.name}-public"
    Terraform = "true"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.subnet_azs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# Private Subnet
resource "aws_subnet" "private" {
  count             = length(var.subnet_azs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.subnet_azs, count.index)

  tags = {
    Name                                = "subnet-${var.name}-private-${count.index}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }
}

# Elastic IP
resource "aws_eip" "default" {
  count = length(var.subnet_azs)
  vpc   = true

  tags = {
    Name      = "eip-${var.name}-${count.index}"
    Terraform = "true"
  }
}

# Nat Gateway
resource "aws_nat_gateway" "default" {
  count         = length(var.subnet_azs)
  allocation_id = element(aws_eip.default.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name      = "nat-${var.name}-${count.index}"
    Terraform = "true"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.subnet_azs)
  vpc_id = aws_vpc.default.id

  tags = {
    Name      = "rt-${var.name}-private-${count.index}"
    Terraform = "true"
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.subnet_azs)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.default.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.subnet_azs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
