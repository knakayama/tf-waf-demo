provider "aws" {
  region = "${var.region}"
}

module "main" {
  source = "../.."

  name         = "${var.name}"
  ipset_config = "${var.ipset_config}"
  vpc_cidr     = "${var.vpc_cidr}"
}
