resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat_gateway.ngw_id_out

    /*gateway_id = var.igw_id*/
  }

  tags = {
    Name = "${var.prefix}-public-routes-${var.subnet_zone}"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
