output "rds_id_out" {
  value = "${aws_db_instance.rds.id}"
}

output "rds_subnet_group_id_out" {
  value = "${aws_db_subnet_group.rds_subnet_group.id}"
}

output "rds_security_group_id_out" {
  value = "${aws_security_group.rds_security_group.id}"
}

output "rds_connection_string_out" {
  value = "${aws_db_instance.rds.address}"
}