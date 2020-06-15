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

  vpc_cidr             = "10.100.0.0/21"
  name                 = "kr-eks-handson"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = ["10.100.3.0/24", "10.100.4.0/24"]
  subnet_azs           = ["ap-northeast-1a", "ap-northeast-1c"]
}
