output "eip_id_out" {
  value = "${aws_eip.nat.id}"
}

output "ngw_id_out" {
  value = "${aws_nat_gateway.ngw.id}"
}
