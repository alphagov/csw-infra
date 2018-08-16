output "private_subnet_id_out" {
  value = "${aws_subnet.private_subnet.id}"
}

output "private_subnet_cidr_block_out" {
  value = "${aws_subnet.private_subnet.cidr_block}"
}

output "private_route_table_id_out" {
  value = "${aws_route_table.private_route_table.id}"
}
