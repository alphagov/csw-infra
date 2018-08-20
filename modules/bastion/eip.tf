resource "aws_eip" "bastion_eip" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true

  tags {
    Name = "${var.prefix}-bastion-eip"
  }
}
