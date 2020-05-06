# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name                                = var.name
    Terraform                           = "true"
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}
