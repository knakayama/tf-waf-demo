resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-igw"
  }
}

resource "aws_subnet" "frontend_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index + 0)}"
  availability_zone       = "${data.aws_availability_zones.az.names[count.index]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-frontend-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "frontend_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.name}-frontend-subnet-rtb"
  }
}

resource "aws_route_table_association" "frontend_subnet" {
  count          = 2
  subnet_id      = "${element(aws_subnet.frontend_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.frontend_subnet.id}"
}

resource "aws_subnet" "application_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index + 100)}"
  availability_zone       = "${data.aws_availability_zones.az.names[0]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.name}-application-subnet-1"
  }
}

resource "aws_route_table" "application_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.name}-application-subnet-rtb"
  }
}

resource "aws_route_table_association" "application_subnet" {
  subnet_id      = "${aws_subnet.application_subnet.id}"
  route_table_id = "${aws_route_table.application_subnet.id}"
}

resource "aws_network_acl" "acl" {
  vpc_id     = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.frontend_subnet.*.id}", "${aws_subnet.application_subnet.id}"]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "${var.name}-nacl"
  }
}
