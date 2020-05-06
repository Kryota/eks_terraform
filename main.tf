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

  vpc_cidr = "10.100.0.0/24"
  name     = "kr-eks-handson"
}
