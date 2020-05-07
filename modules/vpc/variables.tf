variable "vpc_cidr" {
  description = "作成するVPCのCIDRブロック"
  type        = string
}

variable "name" {
  description = "タグに使う名前"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "public subnetのcidr block"
  type        = list
}

variable "private_subnet_cidrs" {
  description = "private subnetのcidr block"
  type        = list
}

variable "subnet_azs" {
  description = "subnetを作成するアベイラビリティゾーン"
  type        = list
}
