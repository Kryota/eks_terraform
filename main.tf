provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "= 0.12.24"
  backend "s3" {
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = "10.100.0.0/24"
  name                 = "kr-eks-handson"
  public_subnet_cidrs  = ["10.100.0.1/28", "10.100.0.16/28"]
  private_subnet_cidrs = ["10.100.0.32/28", "10.100.0.48/28"]
  subnet_azs           = ["ap-northeast-1a", "ap-northeast-1c"]
}
