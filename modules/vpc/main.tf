# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name                                = "vpc-${var.name}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.subnet_azs, count.index)

  tags = {
    Name                                = "subnet-${var.name}-public-${count.index}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.subnet_azs, count.index)

  tags = {
    Name                                = "subnet-${var.name}-private-${count.index}"
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }
}
