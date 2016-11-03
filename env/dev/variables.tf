variable "name" {
  default = "tfWafDemo"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "ipset_config" {
  default = {
    value = "_YOUR_IP_"
  }
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}
