resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}"
  public_key = "${file("${path.module}/keys/key_pair.pub")}"
}

resource "aws_instance" "app" {
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "t2.nano"
  vpc_security_group_ids      = ["${aws_security_group.app.id}"]
  subnet_id                   = "${aws_subnet.application_subnet.id}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  user_data                   = "${file("${path.module}/user_data/ec2_cloud_config.yml")}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags {
    Name = "${var.name}-app-${count.index+1}"
  }
}
